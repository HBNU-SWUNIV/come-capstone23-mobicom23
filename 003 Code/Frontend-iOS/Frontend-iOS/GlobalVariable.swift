//
//  GlobalVariable.swift
//  Frontend-iOS
//
//  Created by Mjolnir on 9/6/23.
//

import Foundation

class GlobalVariable {
    static let shared: GlobalVariable = GlobalVariable()
    
    var userEmail: String?
    var userName: String?
    var userRank: String?
}
