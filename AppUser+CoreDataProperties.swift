//
//  AppUser+CoreDataProperties.swift
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

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var pythonProgressLevel: Int16
    @NSManaged public var pythonCurrentTopic: String?
    @NSManaged public var csharpProgressLevel: Int16
    @NSManaged public var csharpCurrentTopic: String?
    @NSManaged public var javaProgressLevel: Int16
    @NSManaged public var javaCurrentTopic: String?

}

extension AppUser : Identifiable {

}
