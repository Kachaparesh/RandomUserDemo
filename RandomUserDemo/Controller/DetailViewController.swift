//
//  DetailViewController.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 23/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var user : User!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = indexPath.row == 0 ? "UserImageCell" : "UserDetailCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if indexPath.row == 0 {
            let imageCell = cell as! UserImageCell
            imageCell.userFullImage.downloadImageFrom(link: user.picture!.large!, contentMode: .scaleAspectFit)
        } else {
            let detailCell = cell as! UserDetailCell
            detailCell.showDetailsOfUSer(user:user)
        }
        return cell
    }
    
}
