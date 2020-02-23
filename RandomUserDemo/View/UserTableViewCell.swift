//
//  UserTableViewCell.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 23/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userThumbnail: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userGender: UILabel!
    @IBOutlet weak var userDob: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /**
        Cell rendering for every user
            - Parameter result: User object
            - Note: none
    */
    
    func renderUserCells(result:User)
    {
        self.userName.text = "\(result.name?.title! ?? "") \(result.name?.first! ?? "") \(result.name?.last! ?? "")"
        self.userGender.text = result.gender?.firstUppercased
        self.userDob.text = DateFormatter.getStringFromDate(result.dateOfBirth!.date!)
        self.userThumbnail.image = UIImage(named: "placeholder")
        self.userThumbnail.downloadImageFrom(link: result.picture!.thumbnail!, contentMode: UIView.ContentMode.scaleAspectFit)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
