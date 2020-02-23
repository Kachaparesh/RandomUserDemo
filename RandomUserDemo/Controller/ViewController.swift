//
//  ViewController.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 20/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var PrevButton: UIBarButtonItem!
    @IBOutlet weak var NextButton: UIBarButtonItem!
    @IBOutlet weak var userTable: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var pageLabel: UILabel!
    
    fileprivate var currentPage: Page!
    fileprivate var usersList = [User]()
    fileprivate var remoteReplicator: RemoteReplicator!
    fileprivate var randomUserApi: RandomUserApi!
    fileprivate var indexTitles: [String]!
    
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search user by first name or last name"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        self.searchController.searchBar.delegate = self
        
        //Register for notifications
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.renderRecords), name: .updateUserTableData, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.remoteReplicator = RemoteReplicator.sharedInstance
        self.randomUserApi = RandomUserApi.sharedInstance
        self.updatePages()
    }
    
    /**
        Get data in JSON format from given url, store it in core data and as per the current page filter returns records
        - Parameter : None
        - Note: This method is used in starting, loading next page and loading previous page.
    */
    func updatePages()
    {
        let tempPage = self.randomUserApi.getSingleAndOnlyPage(remoteReplicator.getCurrentPage())
        
        if tempPage == nil {
            DispatchQueue.main.async {
                self.loader.startAnimating()
            }
            self.remoteReplicator.fetchData(viewController: self)
        }
        else
        {
            self.currentPage = tempPage
            self.usersList = tempPage?.userResults?.allObjects as? [User] ?? [User]()
            self.userTable.reloadData()
            self.pageLabel.text = "\(remoteReplicator.getCurrentPage())"
            PrevButton.isEnabled = remoteReplicator.getCurrentPage() != 1
            NextButton.isEnabled = tempPage != nil
            self.loader.stopAnimating()
        }
    }
    
    @objc func renderRecords(){
        let tempPage = self.randomUserApi.getSingleAndOnlyPage(remoteReplicator.getCurrentPage())
        self.currentPage = tempPage
        self.usersList = tempPage?.userResults?.allObjects as? [User] ?? [User]()
        self.userTable.reloadData()
        self.pageLabel.text = "\(remoteReplicator.getCurrentPage())"
        PrevButton.isEnabled = remoteReplicator.getCurrentPage() != 1
        NextButton.isEnabled = tempPage != nil
        DispatchQueue.main.async {
            self.loader.stopAnimating()
        }
    }

    @IBAction func goToPreviousPage(_ sender: Any) {
        self.remoteReplicator.loadPrevPage()
        self.updatePages()
    }
    @IBAction func goToNextPage(_ sender: Any) {
        self.remoteReplicator.loadNextPage()
        self.updatePages()
    }
    
    /**
        Filters data from given page records, it will check search string is within user's first name and last name.
            - Parameter searchString: String enterd by user in search bar.
            - Note: More search fields can be added, for location etc.
    */
    func filterListedData(searchString: String){
        if searchString.count > 0 {
            let filteredResult = self.usersList.filter({ (user) -> Bool in
                (user.name?.first?.lowercased().contains(searchString.lowercased()))! || (user.name?.last?.lowercased().contains(searchString.lowercased()))!
            })
            self.usersList = filteredResult
            self.userTable.reloadData()
        }
        else{
            self.usersList = self.currentPage?.userResults?.allObjects as? [User] ?? [User]()
            self.userTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailViewController {
            viewController.user = (sender as! User)
        }
    }
}
extension Notification.Name {
    static let updateUserTableData = Notification.Name(rawValue: "updateUserTableData")
}
// MARK: Table Data Source
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        let result = self.usersList[indexPath.row]
        cell.renderUserCells(result:result)
        return cell
    }
    
}
// MARK: Table Delegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "userDetail", sender: self.usersList[indexPath.row])
    }
    
}
// MARK: Search controller handlers
extension ViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    self.filterListedData(searchString: searchBar.text!)
  }
}

extension ViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    self.filterListedData(searchString: searchBar.text!)
  }
}
