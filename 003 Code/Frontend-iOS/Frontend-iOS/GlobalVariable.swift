//
//  GlobalVariable.swift
//  Frontend-iOS
//
//  Created by Mjolnir on 9/6/23.
//

import Foundation

class GlobalVariable {
    static let shared: GlobalVariable = GlobalVariable()
    
    var apiURL: String = "http://121.159.178.99:8080"
    var userEmail: String?
    var userName: String?
    var userRank: String?
}
