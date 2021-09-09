//
//  UpperClass.swift
//  SportsApp
//
//  Created by MacOSSierra on 3/6/21.
//  Copyright © 2021 MHQ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class UpperClass: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    var events: Array<Event> = []
    
    
    @IBOutlet weak var upperClass: UICollectionView!
    
    
    var leagueId:String?{
        didSet{
            self.events = []
            let request = Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=\(leagueId!)")
            
            
            
            request.validate().responseJSON { response in
                
                switch response.result {
                    
                case .success:
                    let result = try? JSON (data: response.data!)
                    
                    let events = result!["events"]
                    
                    for event in events.arrayValue {
                        
                        print(event["strEvent"].string!)
                        
                        self.events.append(
                            Event(
                                strEvent: event["strEvent"].string ?? "",
                                dateEvent: event["dateEvent"].string ?? "",
                                strTime: event["strTime"].string ?? ""))
                    }
                    
                    
                    self.upperClass.reloadData()
                    
                    
                    
                case .failure(_):
                    print("error")
                }
                
            }
        }
    }
    
    //
    //
    //    override func didAddSubview(_ subview: UIView) {
    //        print("hello")
    //    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(self.events.count)
        return self.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = upperClass.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
//        let strEventLabel: UILabel = cell.viewWithTag(1) as! UILabel
//        let dateEventLabel: UILabel = cell.viewWithTag(2) as! UILabel
//        let strTimeLabel: UILabel = cell.viewWithTag(3) as! UILabel
        
//        if events.count > indexPath.row && events.count > 0 {
//            strEventLabel.text = events[indexPath.row].strEvent
//            strTimeLabel.text = events[indexPath.row].strTime
//            dateEventLabel.text = events[indexPath.row].dateEvent
//        }
        
//        cell.layer.masksToBounds = true
//        cell.layer.cornerRadius = 10
//        cell.clipsToBounds = true
//
//        cell.backgroundColor = UIColor(red: 197/255, green: 98/255, blue: 0, alpha: 1)
//
//        cell.backgroundColor = UIColor(red: 1, green: 194/255, blue: 70/255, alpha: 1)
    
        
        if let upperCell = cell as? UpperClassCollectionViewCell{
            upperCell.firstLabel.text = events[indexPath.row].strEvent
            upperCell.secondLabel.text = events[indexPath.row].dateEvent
            upperCell.thirdLabel.text = events[indexPath.row].strTime
        }
        
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width * 0.75 , height: collectionView.frame.height - 16)
    }
    


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
