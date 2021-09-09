//
//  Event.swift
//  SportsApp
//
//  Created by MacOSSierra on 3/6/21.
//  Copyright © 2021 MHQ. All rights reserved.
//

import Foundation

class Event {
    
    var strEvent: String?
    var dateEvent:String?
    var strTime: String?

    
    init(strEvent: String, dateEvent: String, strTime: String) {
        
        self.strEvent = strEvent
        self.dateEvent = dateEvent
        self.strTime = strTime
    }
}
