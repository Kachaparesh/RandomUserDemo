//
//  String+extension.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 24/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//

import Foundation
extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
