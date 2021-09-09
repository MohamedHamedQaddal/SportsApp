//
//  LeaguesTableViewCell.swift
//  SportsApp
//
//  Created by MacOSSierra on 3/6/21.
//  Copyright © 2021 MHQ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LeaguesTableViewCell: UITableViewCell {
    
    
    var leagueId: String?{
        didSet{
            if let id = leagueId {
                fetchLeague(idLeague: id)
            }
        }
    }
    
    var strYoutube: URL?
    var cellHandler:((String,String)->())?

    @IBOutlet weak var uiImage: UIImageView!{
        didSet{
            
            print()
            uiImage.layer.masksToBounds = true
            uiImage.layer.cornerRadius = (150) / 2.0
            uiImage.layer.borderWidth = 4
            uiImage.layer.borderColor = UIColor.black.cgColor
            uiImage.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func buttonAction(_ sender: Any) {
        print("\n \(strYoutube!) \n")
        
        if let url = strYoutube {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fetchLeague(idLeague: String) {
        let request = Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id=\(idLeague)")
        
        
                    
        request.validate().responseJSON { response in
            
            
            switch response.result {
            
            case .success:
                let result = try? JSON (data: response.data!)
                
                let leagues = result!["leagues"]
                
                for leagueDetail in leagues.arrayValue {
                    self.label.text =  leagueDetail["strLeague"].string ?? ""
                    
                    self.uiImage.sd_setImage(with: URL(string: leagueDetail["strBadge"].string ?? ""), placeholderImage: UIImage(named: "1.png"))
                    
                    
                    if let strBadge = leagueDetail["strBadge"].string, let strYoutube = leagueDetail["strYoutube"].string{
                        self.cellHandler?(strBadge,strYoutube)
                    }
                    
                    
                    self.strYoutube =  URL(string: "http://" + leagueDetail["strYoutube"].string! )
                   
                    
                }

            case .failure(_):
                print("error")
            }
            
        }
        
    }
    
    func loadStoredImage(urlStr:String){
        self.uiImage.sd_setImage(with: URL(string:urlStr), placeholderImage: UIImage(named: "1.png"))
    }
    
    static func nib() -> UINib{
            return UINib(nibName:"LeaguesTableViewCell", bundle: nil)
        }
    
}
