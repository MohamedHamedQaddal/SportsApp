
//
//  CoreDataModel.swift
//  SportsApp
//
//  Created by MacOSSierra on 3/7/21.
//  Copyright © 2021 MHQ. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataLayer{
    
    private(set) var StoredLeaguess = [StoredLeagues]()
    private static var coreDataObj = CoreDataLayer()
    static var shared : CoreDataLayer {
        get{
            coreDataObj.getDataFromStorage()
            return coreDataObj
        }
    }
    
    //MARK:- Core Data Methods
    private func getDataFromStorage(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest : NSFetchRequest<StoredLeagues> = StoredLeagues.fetchRequest()
            do{
                StoredLeaguess = try managedContext.fetch(fetchRequest)
            }catch let error as NSError{
                print(error)
            }
        }
    }
    
    
    func addLeagueToStorage(_ league: League){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let managedContext = appDelegate.persistentContainer.viewContext
            
            if league.strLeague != nil,!(isLeagueFound(with: league.idLeague) ?? true){
                let newLeague = StoredLeagues(context: managedContext)
                newLeague.leagueID = league.idLeague
                newLeague.leagueName = league.strLeague
                newLeague.sportName = league.strSport
                newLeague.youtubeLink = league.strYoutube
                newLeague.badge = league.strBadge
                
                StoredLeaguess += [newLeague]
                
                do{
                    try managedContext.save()
                    print("<<<<< SAVED")
                }catch let error as NSError{
                    print(error)
                }
            }
        }
    }
    
    private func isLeagueFound(with leagueID : String?)->Bool?{
        guard let id = leagueID else{
            return nil
        }
        if StoredLeaguess.count == 0{
            getDataFromStorage()
        }
        for league in StoredLeaguess{
            if(league.leagueID == id){
                return true
            }
        }
        return false
    }
    
    
    
    func deleteFromStorage(at index:Int ){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(StoredLeaguess[index])
            StoredLeaguess.remove(at: index)
            do{
                try managedContext.save();
                print("item Deleted")
            }catch let error as NSError{
                print(error);
            }
        }
    }
    
    //    func deleteFromStorageIfExistsWith(title : String){
    //        getDataFromStorage()
    //        for movie in stordMovies{
    //            if movie.title == title{
    //                if let index = stordMovies.firstIndex(of: movie){
    //                    deleteFromStorage(at: index)
    //                    stordMovies.remove(at: index)
    //                }
    //            }
    //        }
    //    }
    //
    //    private func deleteAllFromStorage(){
    //        if(displayLocally){
    //            for index in stordMovies.indices{
    //                deleteFromStorage(at: index)
    //            }
    //            stordMovies.removeAll()
    //            tableView.reloadData()
    //            reloadFromWeb()
    //        }
    //    }
}
