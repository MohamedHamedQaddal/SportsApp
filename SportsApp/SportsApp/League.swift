//
//  league.swift
//  SportsApp
//
//  Created by MacOSSierra on 3/6/21.
//  Copyright © 2021 MHQ. All rights reserved.
//
import Foundation

class League {
    
    var idLeague: String?
    var strLeague: String?
    var strSport: String?
    var strLeagueAlternate: String?
    
    var strYoutube: String = ""
    var strBadge: String = ""
    
    init(idLeague: String, strLeague: String, strSport: String, strLeagueAlternate: String) {

        self.idLeague = idLeague
        self.strLeague = strLeague
        self.strSport = strSport
        self.strLeagueAlternate = strLeagueAlternate
    }
}
