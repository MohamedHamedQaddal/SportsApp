//
//  SportsCollectionViewController.swift
//  SportsApp
//
//  Created by MacOSSierra on 3/6/21.
//  Copyright © 2021 MHQ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class SportsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    var sports: Array<Sport> = []
    var leaguesTableViewController: LeaguesTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.leaguesTableViewController = self.storyboard!.instantiateViewController(withIdentifier: "leaguesTableViewController") as? LeaguesTableViewController

        fetchLeagues()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    func fetchLeagues(){
        let request = Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/all_sports.php")
        
        
        
        request.validate().responseJSON { response in
            
            switch response.result {
            
                case .success:
                    let result = try? JSON (data: response.data!)
                    
                    let sports  = result!["sports"]
                    
                    for sport in sports.arrayValue {
                   
                        self.sports.append(Sport(idSport: sport["idSport"].string ?? "", strSport: sport["strSport"].string ?? "", strFormat: sport["strFormat"].string ?? "", strSportThumb: sport["strSportThumb"].string ?? "", strSportDescription: sport["strSportDescription"].string ?? ""))
                    }
                    
//                    print(self.sports[0].idSport!)
//                    print(self.sports[0].strSport!)
//                    print(self.sports[0].strFormat!)
//                    print(self.sports[0].strSportThumb!)
//                    print(self.sports[0].strSportDescription!)
                    
                    
                    self.collectionView.reloadData()
                    
                    

            case .failure(_):
                print("error")
            }
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.leaguesTableViewController?.strSport = self.sports[indexPath.row].strSport!
        self.leaguesTableViewController?.leagues = []
        self.present(self.leaguesTableViewController!, animated: true, completion: nil)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        
        let imageView: UIImageView = cell.viewWithTag(1) as! UIImageView
        let label: UILabel = cell.viewWithTag(2) as! UILabel

        imageView.sd_setImage(with: URL(string: sports[indexPath.row].strSportThumb!), placeholderImage: UIImage(named: "1.png"))
        
        label.text = sports[indexPath.row].strSport!
                    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
        return CGSize(width: collectionView.frame.width / 2  , height: collectionView.frame.width / 2 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
