//
//  User.swift
//  Hobbly_SwiftUI
//
//  Created by Nina Paripovic on 5/17/21.
//

import Foundation
import RealmSwift

@objcMembers class User: Object, ObjectKeyIdentifiable {
    dynamic var _id: String = UUID().uuidString
//    dynamic var _partition: String = ""
    dynamic var name: String = ""
    // eventually add activites a user is invited/going to
//    let memberOf = RealmSwift.List<Project>()

    override static func primaryKey() -> String? {
        return "_id"
    }
}

