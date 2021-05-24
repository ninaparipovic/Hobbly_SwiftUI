//
//  Activity.swift
//  Hobbly_SwiftUI
//
//  Created by Nina Paripovic on 5/23/21.
//

import Foundation
import RealmSwift

/// An individual Activity. Part of a `Category`.
final class Activity: Object, ObjectKeyIdentifiable {
    /// The unique ID of the Activity.
    @objc dynamic var _id = ObjectId.generate()
    /// The name of the Activity, By default, a random name is generated.
    @objc dynamic var name = ""
    @objc dynamic var price = ""
    @objc dynamic var image1: String = "kaf1"
    @objc dynamic var image2: String = "kaf2"
    @objc dynamic var image3: String = "kaf3"
    /// A flag indicating whether the user "favorited" the Activity.
    @objc dynamic var isFavorite = false
    /// The backlink to the `Category` this Activity is a part of.
    let category = LinkingObjects(fromType: Category.self, property: "Activitys")
    /// Declares the _id member as the primary key to the realm.
    override class func primaryKey() -> String? {
        "_id"
    }
    
    convenience init(name: String, price: String) {
        self.init()
        self.name = name
        self.price = price
        self.image1 = "kaf1"
    }
}

/// Represents a collection of Activitys.
final class Category: Object, ObjectKeyIdentifiable {
    /// The unique ID of the Category.
    @objc dynamic var _id = ObjectId.generate()
    @objc dynamic var name = "yeeeh"


    /// The collection of Activitys in this Category.
    var Activitys = RealmSwift.List<Activity>()

    /// Declares the _id member as the primary key to the realm.
    override class func primaryKey() -> String? {
        "_id"
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}



//
///// An individual Activity. Part of a `Group`.
//    final class Activity: Object, ObjectKeyIdentifiable {
//
//
//    var name: String = ""
////    var description: String
//    // make price a new data type that can hold exact prices as well as $/$$/$$$
//    var price: String = ""
//    // is Date a valid data type
////    var duration: Date
////    var images: [String]
//
//    var imageName: String {return name}
//    var thumbnailName: String { return name + "Thumb"}
//
//    @objc dynamic var _id = ObjectId.generate()
//
//    @objc dynamic var isFavorite = false
//
//    /// The backlink to the `Group` this Activity is a part of.
//    let group = LinkingObjects(fromType: Group.self, property: "Activitys")
//
//    override class func primaryKey() -> String? {
//        "_id"
//    }
//
////    convenience init(name: String, price: String) {
////        self.init()
////        self.name = name
////        self.price = price
//////        self.description = description
////    }
//}


