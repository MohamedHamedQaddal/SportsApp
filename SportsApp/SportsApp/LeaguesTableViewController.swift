//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by MacOSSierra on 3/6/21.
//  Copyright © 2021 MHQ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class LeaguesTableViewController: UITableViewController {
    
    
    var leagues: Array<League> = []
    var strSport: String = ""
    //var leagueDetailsViewController: LeagueDetailsViewController?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//         self.leagueDetailsViewController = self.storyboard!.instantiateViewController(withIdentifier: "leagueDetailsViewController") as? LeagueDetailsViewController
        
        
       // tableView.rowHeight = UITableView.automaticDimension

        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        tableView.register(LeaguesTableViewCell.nib(), forCellReuseIdentifier: "leagueCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchLeagues()
    }
    
    
    
    func fetchLeagues() {
        print(self.strSport)
        let request = Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/all_leagues.php")
        
        
        request.validate().responseJSON { response in
            
            switch response.result {
            
            case .success:
                let result = try? JSON (data: response.data!)
                
                let leagues = result!["leagues"]
                
                for league in leagues.arrayValue {
                    
                    if league["strSport"].string == self.strSport {
                        
                        self.leagues.append(League(idLeague: league["idLeague"].string ?? "", strLeague: league["strLeague"].string ?? "", strSport: league["strSport"].string ?? "", strLeagueAlternate: league["strLeagueAlternate"].string ?? ""))
                    }
                }
                
                print(self.leagues[0].idLeague!)
                print(self.leagues[0].strLeague!)
                print(self.leagues[0].strSport!)
                print(self.leagues[0].strLeagueAlternate!)
                
                
                self.tableView.reloadData()
                
                
            case .failure(_):
                print("error")
            }
            
        }
        
    }
    
    func fetchLeague(league: League) -> League {
        let request = Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id=\(league.idLeague!)")
        
        
                    
        request.validate().responseJSON { response in
            
            
            
            switch response.result {
            
            case .success:
                let result = try? JSON (data: response.data!)
                
                let leagues = result!["leagues"]
                
                for leagueDetail in leagues.arrayValue {
                    
                    league.strYoutube = leagueDetail[].string ?? ""
                    league.strBadge = leagueDetail["strBadge"].string ?? ""
                    
                    self.tableView.reloadData()
                }
                
            case .failure(_):
                print("error")
            }
            
        }
        print(league.idLeague ?? "Hi")
        print(league.strBadge )
        print(league.strLeague ?? "Hi")
        print(league.strLeagueAlternate ?? "Hi")
        print(league.strSport ?? "Hi")
        print(league.strYoutube )

        return league
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        var leagueDetailsViewController: LeagueDetailsViewController?
        
        leagueDetailsViewController = self.storyboard!.instantiateViewController(withIdentifier: "leagueDetailsViewController") as? LeagueDetailsViewController
        
        leagueDetailsViewController?.league = self.leagues[indexPath.row]
        print(leagueDetailsViewController?.league?.idLeague)

        //print(self.leagues[indexPath.row].strLeague)
        self.present(leagueDetailsViewController!, animated: true)
        {
            
            leagueDetailsViewController?.navBar?.topItem?.title = self.leagues[indexPath.row].strLeague
            
            
        }
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leaguesTableViewCell: LeaguesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeaguesTableViewCell
        
        leaguesTableViewCell.leagueId = leagues[indexPath.row].idLeague
        leaguesTableViewCell.cellHandler = {
            (strBadge, strYoutube) in
            self.leagues[indexPath.row].strBadge = strBadge
            self.leagues[indexPath.row].strYoutube = strYoutube
        }
        
//        let imageView: UIImageView = cell.viewWithTag(1) as! UIImageView
//        let label: UILabel = cell.viewWithTag(2) as! UILabel
//        let button: UIButton = cell.viewWithTag(3) as! UIButton
//
//        if(leagues[indexPath.row].strBadge == "") {
//            leagues[indexPath.row] = fetchLeague(league: leagues[indexPath.row])
//        }
//
//        //print("\(indexPath.row) \(leagues[indexPath.row].strBadge)")
//
//        imageView.sd_setImage(with: URL(string: leagues[indexPath.row].strBadge), placeholderImage: UIImage(named: "placeholder.png"))
//
//        label.text = leagues[indexPath.row].strLeague!
                
        return leaguesTableViewCell
    }
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

