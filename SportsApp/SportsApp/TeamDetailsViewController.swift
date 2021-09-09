//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by MacOSSierra on 3/6/21.
//  Copyright © 2021 MHQ. All rights reserved.
//

import UIKit
import SDWebImage

class TeamDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var sportNameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!

    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var team:Team?
    
    
//    func loadImage(From:String){
//          self.teamImageView.sd_setImage(with: URL(string: team!.strTeamBadge!), placeholderImage: UIImage(named: "1.png"))
//    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.teamImageView.sd_setImage(with: URL(string: team!.strTeamBadge!), placeholderImage: UIImage(named: "1.png"))
        
        self.navBar.topItem?.title = team!.strTeam!
        self.sportNameLabel.text = team!.strTeam!
        self.nicknameLabel.text = team!.strTeamAlternate
    }
        // Do any additional setup after loading the view.
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


