
//
//  LowerClass.swift
//  SportsApp
//
//  Created by MacOSSierra on 3/6/21.
//  Copyright © 2021 MHQ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LowerClass: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var delegate:TeamProtocol?
    
    @IBOutlet weak var lowerClass: UICollectionView!
    var teams: Array<Team> = []
    
    
    var uiViewController: UIViewController?

    
    
    var leagueId:String?{
        didSet{
            self.teams = []
            let request = Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=\(leagueId!)")
            
            
            
            request.validate().responseJSON { response in
                
                switch response.result {
                    
                case .success(let data):
                    guard let dataDict = data as? [String:Any] ,
                        let dataArray = dataDict["teams"] as? [Any]
                        else {
                            return
                    }
                    
                    
                    for teamData in dataArray{
                        guard let teamDict = teamData as? [String:Any]
                            else{
                                continue
                        }
                        var team = Team(idTeam: teamDict["idTeam"] as! String,
                                        strTeam:teamDict["strTeam"] as! String, strTeamBadge: teamDict["strTeamBadge"] as! String, strTeamAlternate: teamDict["strAlternate"] as! String)
                        
                        self.teams+=[team]
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.lowerClass.reloadData()
                    }
                    
            
                case .failure(_):
                    print("error")
                }
                
            }
        }
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = lowerClass.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let strTeamBadge: UIImageView = cell.viewWithTag(1) as! UIImageView

//        if teams.count > indexPath.row && teams.count > 0 {
        
        print("====================")
        //print(teams[indexPath.row].strTeamBadge)
        
                    strTeamBadge.sd_setImage(with: URL(string: teams[indexPath.row].strTeamBadge!), placeholderImage: UIImage(named: "1.png"))
            
//        }
        
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
//        cell.backgroundColor = UIColor(red: 197/255, green: 98/255, blue: 0, alpha: 1)
//
//        cell.backgroundColor = UIColor(red: 1, green: 194/255, blue: 70/255, alpha: 1)
        
        return cell
        
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.display(team: teams[indexPath.row])
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
