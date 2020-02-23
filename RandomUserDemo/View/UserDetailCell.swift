//
//  UserDetailCell.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 23/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//

import UIKit

class UserDetailCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showDetailsOfUSer(user:User)
    {
        userNameLabel.text = "\(user.name?.title ?? "") \(user.name?.first ?? "") \(user.name?.last ?? "")"
        emailLabel.text    = user.email ?? ""
        phoneLabel.text    = user.phone ?? ""
        locationLabel.text = "\(user.location?.street?.number ?? 0) \(user.location?.street?.name ?? "")\n\(user.location?.city ?? "")\n\(user.location?.state ?? "")"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
