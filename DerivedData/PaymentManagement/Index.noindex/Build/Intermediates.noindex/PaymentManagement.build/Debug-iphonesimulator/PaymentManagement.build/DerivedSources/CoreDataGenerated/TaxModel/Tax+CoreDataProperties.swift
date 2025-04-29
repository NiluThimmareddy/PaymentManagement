//
//  Tax+CoreDataProperties.swift
//  
//
//  Created by ToqSoft on 29/04/25.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Tax {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tax> {
        return NSFetchRequest<Tax>(entityName: "Tax")
    }

    @NSManaged public var taxName: String?
    @NSManaged public var taxPercentage: String?

}

extension Tax : Identifiable {

}
