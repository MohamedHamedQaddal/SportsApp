//
//  Team.swift
//  SportsApp
//
//  Created by MacOSSierra on 3/6/21.
//  Copyright © 2021 MHQ. All rights reserved.
//

import Foundation

class Team {
    
    var idTeam: String?
    var strTeam: String?
    var strTeamBadge:String?
    var strTeamAlternate:String?
    
    
    init(idTeam: String, strTeam: String, strTeamBadge: String, strTeamAlternate: String) {
        
        self.idTeam = idTeam
        self.strTeam = strTeam
        self.strTeamBadge = strTeamBadge
        self.strTeamAlternate = strTeamAlternate
    }
}
