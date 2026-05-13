//
//  User+CoreDataProperties.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 29.04.2025.
//
//

import Foundation
import CoreData


extension AppUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppUser> {
        return NSFetchRequest<AppUser>(entityName: "AppUser")
    }

    @NSManaged public var currentLanguage: String?
    @NSManaged public var currentTopic: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var progressLevel: Int16

}

extension AppUser : Identifiable {

}
