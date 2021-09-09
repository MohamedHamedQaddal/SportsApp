//
//  Result.swift
//  SportsApp
//
//  Created by MacOSSierra on 3/6/21.
//  Copyright © 2021 MHQ. All rights reserved.
//

import Foundation


class Result {
    
    //var idResult: String?
    var homeTeam: String?
    var secondTeam: String?
    var homeScore: String?
    var secondScore: String?
    var time: String?
    var dateEvent: String?

    
    
    init(
        //idResult: String,
        homeTeam: String,
        secondTeam: String,
        homeScore: String,
        secondScore: String,
        time:String,
        dateEvent: String
        ) {
        
        //self.idResult = idResult
        self.homeTeam = homeTeam
        self.secondTeam = secondTeam
        self.homeScore = homeScore
        self.secondScore = secondScore
        self.time = time
        self.dateEvent = dateEvent

    }
}
