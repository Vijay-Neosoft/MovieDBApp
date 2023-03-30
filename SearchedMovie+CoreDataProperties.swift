//
//  SearchedMovie+CoreDataProperties.swift
//  
//
//  Created by NeoSOFT on 20/03/23.
//
//

import Foundation
import CoreData


extension SearchedMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchedMovie> {
        return NSFetchRequest<SearchedMovie>(entityName: "SearchedMovie")
    }

    @NSManaged public var id: Int64
    @NSManaged public var movieImage: String?
    @NSManaged public var movieName: String?

}
