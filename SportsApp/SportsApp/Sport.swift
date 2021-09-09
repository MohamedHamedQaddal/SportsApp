//
//  Sport.swift
//  SportsApp
//
//  Created by MacOSSierra on 3/6/21.
//  Copyright © 2021 MHQ. All rights reserved.
//

import Foundation


class Sport {
    
    var idSport: String?
    var strSport: String?
    var strFormat: String?
    var strSportThumb: String?
    var strSportDescription: String?
    
    init(idSport: String, strSport: String, strFormat: String, strSportThumb: String, strSportDescription: String) {

        self.idSport = idSport
        self.strSport = strSport
        self.strFormat = strFormat
        self.strSportThumb = strSportThumb
        self.strSportDescription = strSportDescription
    }
}

