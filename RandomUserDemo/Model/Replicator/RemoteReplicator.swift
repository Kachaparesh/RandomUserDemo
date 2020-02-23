//
//  RemoteReplicator.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 22/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//

import Foundation
/**
    Remote Replicator handles calling remote datasource and parsing response JSON data and calls the Core Data Stack,
    (via RandomUserApi) to actually create Core Data Entities and persist to SQLite Datastore.
*/

class RemoteReplicator {

    fileprivate var randomUserApi: RandomUserApi!
    fileprivate var pageNumber = 1
    fileprivate var numberOfUSers = 10
    fileprivate var isFetchInProgress : Bool!
    let networking = NetworkingService.shared

    //Utilize Singleton pattern by instanciating Replicator only once.
    class var sharedInstance: RemoteReplicator {
        struct Singleton {
            static let instance = RemoteReplicator()
        }

        return Singleton.instance
    }

    init() {
        self.randomUserApi = RandomUserApi.sharedInstance
    }
    
    // MARK: Paging handler
    func loadNextPage()
    {
        pageNumber += 1
    }
    
    func loadPrevPage()
    {
        pageNumber -= 1
    }
    
    func getCurrentPage() -> Int
    {
        return pageNumber
    }
    
    // MARK: Records handler
    func setNumbersOfUsersPerPage(userCount: Int){
        numberOfUSers = userCount
    }
    
    func getNumbersOfUsersPerPage() -> Int{
        return numberOfUSers
    }

    /**
        Pull user page data from a given Remote resource, posts a notification to update
        datasource of a given/listening ViewController/UITableView.
    
        - Note: Returns within main thread
        - Parameter :None
    */
    func fetchData() {
        
        isFetchInProgress = true
        networking.request(_urlPath: "https://randomuser.me/api/?page=\(pageNumber)&results=\(numberOfUSers)") { result in
            //Remote resource
            switch result {
                        case .success(let data):
                            //Read JSON response in seperate thread
                                DispatchQueue.global().async {
                                    // read JSON file, parse JSON data
                                    self.processData(data as AnyObject?)

                                    // Post notification to update datasource of a given ViewController/UITableView
                                    DispatchQueue.main.async {
                                        self.isFetchInProgress = false
                                        NotificationCenter.default.post(name: Notification.Name(rawValue: "updateUserTableData"), object: nil)
                                    }
                                }
                        case .failure(let err):
                            DispatchQueue.main.async {
                                self.isFetchInProgress = false
                                print("Failed to fetch courses:", err)
                            }
                        }
            }
    }

    /**
        Process data from a given resource Page object and assigning
        (additional) property values and calling the  RandomUserAPI to persist Page
        to the datastore.
        
        - Parameter jsonResult: The JSON content to be parsed and stored to Datastore.
        - Note: None
    */
    internal func processData(_ jsonResponse: AnyObject?) {

        let jsonData: Data = jsonResponse as! Data
        var jsonResult: AnyObject!

        do {
            jsonResult = try JSONSerialization.jsonObject(with: jsonData) as AnyObject
        } catch let fetchError as NSError {
            print("pull error: \(fetchError.localizedDescription)")
        }

        if let pageDetail = jsonResult {
            randomUserApi.savePage(pageDetail as! Dictionary<String, AnyObject>)
        }
    }
}
