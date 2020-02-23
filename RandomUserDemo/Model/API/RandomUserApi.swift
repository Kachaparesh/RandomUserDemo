//
//  RandomUserApi.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 21/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//

import Foundation
import CoreData
class RandomUserApi{
    //Utilize Singleton pattern by instanciating RandomUserApi only once.
    fileprivate let persistenceManager: PersistenceManager!
    fileprivate var mainContextInstance: NSManagedObjectContext!
    fileprivate var pages: [Page]!
    class var sharedInstance: RandomUserApi {
        struct Singleton {
            static let instance = RandomUserApi()
        }
        return Singleton.instance
    }
    
    init() {
        self.persistenceManager = PersistenceManager.sharedInstance
        self.mainContextInstance = persistenceManager.getMainContextInstance()
    }
    
    
    /**
     Retrieve a Page
     
     Scenario:
     Given that there there is only a single page in the datastore
     Let say we only created one page in the datastore, then this function will get that single persisted page from page number
     Thus calling this method multiple times will result in getting always the one page.
     
     - Returns: a found Page item, or nil
     */
    func getSingleAndOnlyPage(_ pageNumber:Int) -> Page? {
        var fetchedResultPage: Page?
        
        // Create request on Page entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Page")

        //Execute Fetch request
        do {
            let pagesCount = try  self.mainContextInstance.count(for: fetchRequest)
            if pagesCount > 0 {
                let findByIdPredicate = NSPredicate(format: "page = %d", pageNumber)
                fetchRequest.predicate = findByIdPredicate
                fetchRequest.fetchLimit = 1
                let fetchedResults = try  self.mainContextInstance.fetch(fetchRequest) as! [Page]
                fetchedResultPage =  fetchedResults.first
            }
        } catch let fetchError as NSError {
            print("retrieve single page error: \(fetchError.localizedDescription)")
        }
        
        return fetchedResultPage
    }
        
    // MARK: Create

    /**
        Create a single Page item, and persist it to Datastore via Worker,
        that synchronizes with Main context.
    
        - Parameter Page: <Dictionary<String, AnyObject> A single page item to be persisted to the Datastore.
        - Returns: Void
    */
    func savePage(_ pageDetail: Dictionary<String, AnyObject>) {

        //Minion Context worker with Private Concurrency type.
        let minionManagedObjectContextWorker: NSManagedObjectContext =
        NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        minionManagedObjectContextWorker.parent = self.mainContextInstance

        //Create new Object of Page entity
        let pageItem = NSEntityDescription.insertNewObject(forEntityName: "Page",
            into: minionManagedObjectContextWorker) as! Page

        //Assign field values
        for (key, value) in pageDetail {
            if key == "info" {
                let infoDict = value
                pageItem.seed     = infoDict["seed"] as? String
                pageItem.version  = infoDict["version"] as? String
                pageItem.results  = infoDict["results"] as! Int16
                pageItem.page     = infoDict["page"] as! Int16
            }
            else{
                guard let results = value as? [[String: Any]] else { return }
                for tempresult in results {
                    
                    let userItem = NSEntityDescription.insertNewObject(forEntityName: "User",
                        into: minionManagedObjectContextWorker) as! User
                    
                    let coordinatesItem = NSEntityDescription.insertNewObject(forEntityName: "Coordinates",
                        into: minionManagedObjectContextWorker) as! Coordinates

                    let dateOfBirthItem = NSEntityDescription.insertNewObject(forEntityName: "DateOfBirth",
                        into: minionManagedObjectContextWorker) as! DateOfBirth
                    
                    let registeredDateItem = NSEntityDescription.insertNewObject(forEntityName: "RegisteredDate",
                    into: minionManagedObjectContextWorker) as! RegisteredDate

                    let idItem = NSEntityDescription.insertNewObject(forEntityName: "Id",
                        into: minionManagedObjectContextWorker) as! Id

                    let locationItem = NSEntityDescription.insertNewObject(forEntityName: "Location",
                        into: minionManagedObjectContextWorker) as! Location

                    let loginItem = NSEntityDescription.insertNewObject(forEntityName: "Login",
                        into: minionManagedObjectContextWorker) as! Login

                    let nameItem = NSEntityDescription.insertNewObject(forEntityName: "Name",
                        into: minionManagedObjectContextWorker) as! Name

                    let pictureItem = NSEntityDescription.insertNewObject(forEntityName: "Picture",
                        into: minionManagedObjectContextWorker) as! Picture

                    let streetItem = NSEntityDescription.insertNewObject(forEntityName: "Street",
                        into: minionManagedObjectContextWorker) as! Street

                    let timeZoneItem = NSEntityDescription.insertNewObject(forEntityName: "Timezone",
                        into: minionManagedObjectContextWorker) as! Timezone

                    
                    userItem.gender = tempresult["gender"] as? String
                    userItem.email  = tempresult["email"] as? String
                    userItem.nat    = tempresult["nat"] as? String
                    userItem.phone  = tempresult["phone"] as? String
                    userItem.cell   = tempresult["cell"] as? String
                    
                    guard let result_name = tempresult["name"] as? [String: Any] else {return}
                    nameItem.title = result_name["title"] as? String
                    nameItem.first = result_name["first"] as? String
                    nameItem.last  = result_name["last"] as? String
                    
                    guard let result_login = tempresult["login"] as? [String: Any] else {return}
                    loginItem.uuid     = result_login["uuid"] as? String
                    loginItem.username = result_login["username"] as? String
                    loginItem.password = result_login["password"] as? String
                    loginItem.salt     = result_login["salt"] as? String
                    loginItem.md5      = result_login["md5"] as? String
                    loginItem.sha1     = result_login["sha1"] as? String
                    loginItem.sha256   = result_login["sha256"] as? String

                    guard let result_id = tempresult["id"] as? [String: Any] else {return}
                    idItem.name  = result_id["name"] as? String
                    idItem.value = result_id["value"] as? String

                    guard let result_location = tempresult["location"] as? [String: Any] else {return}
                    locationItem.city     = result_location["city"] as? String
                    locationItem.state    = result_location["state"] as? String
                    locationItem.postcode = result_location["postcode"] as? String
                    
                    guard let result_location_street = result_location["street"] as? [String: Any] else {return}
                    streetItem.number = Int16(result_location_street["number"] as! Int)
                    streetItem.name   = result_location_street["name"] as? String

                    guard let result_location_timezone = result_location["timezone"] as? [String: Any] else {return}
                    timeZoneItem.offset              = result_location_timezone["offset"] as? String
                    timeZoneItem.timeZoneDescription = result_location_timezone["description"] as? String

                    guard let result_location_coordinates = result_location["coordinates"] as? [String: Any] else {return}
                    coordinatesItem.latitude  = result_location_coordinates["latitude"] as? String
                    coordinatesItem.longitude = result_location_coordinates["longitude"] as? String
                    
                    locationItem.coordinates = coordinatesItem
                    locationItem.timezone    = timeZoneItem
                    locationItem.street      = streetItem
                    
                    guard let result_picture = tempresult["picture"] as? [String: Any] else {return}
                    pictureItem.large     = result_picture["large"] as? String
                    pictureItem.medium    = result_picture["medium"] as? String
                    pictureItem.thumbnail = result_picture["thumbnail"] as? String
                    
                    guard let result_dateOfBirth = tempresult["dob"] as? [String: Any] else {return}
                    dateOfBirthItem.age  = Int16(result_dateOfBirth["age"] as! Int)
                    let date_dob = result_dateOfBirth["date"] as? String
                    dateOfBirthItem.date = DateFormatter.getDateFromString(date_dob!, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                    
                    guard let result_registeredDate = tempresult["registered"] as? [String: Any] else {return}
                    registeredDateItem.age  = Int16(result_registeredDate["age"] as! Int)
                    let date_registered = result_registeredDate["date"] as? String
                    registeredDateItem.date = DateFormatter.getDateFromString(date_registered!, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                    
                    userItem.name        = nameItem
                    userItem.location    = locationItem
                    userItem.login       = loginItem
                    userItem.dateOfBirth = dateOfBirthItem
                    userItem.registered  = registeredDateItem
                    userItem.id          = idItem
                    userItem.picture     = pictureItem
                    pageItem.addToUserResults(userItem)
                }
            }
        }

        //Save current work on Minion workers
        self.persistenceManager.saveWorkerContext(minionManagedObjectContextWorker)

        //Save and merge changes from Minion workers with Main context
        self.persistenceManager.mergeWithMainContext()

        //Post notification to update datasource of a given Viewcontroller/UITableView
        self.postUpdateNotification()
    }
        
    fileprivate func postUpdateNotification() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "updatePageTableData"), object: nil)
    }

}
