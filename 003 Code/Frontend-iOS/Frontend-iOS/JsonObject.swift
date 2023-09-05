//
//  JsonObject.swift
//  Frontend-iOS
//
//  Created by Mjolnir on 9/5/23.
//

import Foundation

struct UserInfo: Codable {
    var id: Int
    var email: String
    var password: String
    var roles: [String]
    var authorities: [String]
    var accountNonExpired: Bool
    var credentialsNonExpired: Bool
    var username: String
    var enabled: Bool
}
