//
//  UserModel.swift
//  SlackHuddle
//
//  Created by Mayank Gupta on 23/02/22.
//

import Foundation

struct UserModel: Identifiable {
    var id = UUID()
    var image: String
    var name: String
}

