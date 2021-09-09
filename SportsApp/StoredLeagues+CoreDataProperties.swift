//
//  StoredLeagues+CoreDataProperties.swift
//  
//
//  Created by MacOSSierra on 3/7/21.
//
//

import Foundation
import CoreData


extension StoredLeagues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredLeagues> {
        return NSFetchRequest<StoredLeagues>(entityName: "StoredLeagues")
    }

    @NSManaged public var leagueID: String?
    @NSManaged public var leagueName: String?
    @NSManaged public var sportName: String?
    @NSManaged public var youtubeLink: String?
    @NSManaged public var badge: String?

}
