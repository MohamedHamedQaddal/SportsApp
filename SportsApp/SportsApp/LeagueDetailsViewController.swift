//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by MacOSSierra on 3/5/21.
//  Copyright © 2021 MHQ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LeagueDetailsViewController: UIViewController, TeamProtocol  {

    
    var league: League?

    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var upperClass: UpperClass!
    @IBOutlet weak var middleClass: MiddleClass!
    @IBOutlet weak var lowerClass: LowerClass!{
        didSet{
            lowerClass.delegate = self
        }
    }
    
    
    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        CoreDataLayer.shared.addLeagueToStorage(league!)
    }
    
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lowerClass.leagueId = league?.idLeague
    }
    
    /*
    override func viewWillAppear(_ animated: Bool) {
        self.navBar.topItem?.title = league?.strLeague
    }
 */
    
    override func viewDidAppear(_ animated: Bool) {
        if let league = league {
            self.upperClass!.leagueId = league.idLeague!
            self.middleClass!.leagueId = league.idLeague!
            self.lowerClass!.uiViewController = self
            self.lowerClass!.leagueId = league.idLeague!
        }
    }
    

    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func display(team: Team) {
        if let teamDetailsViewController = self.storyboard!.instantiateViewController(withIdentifier: "lastViewController") as? TeamDetailsViewController{
            teamDetailsViewController.team = team
            present(teamDetailsViewController, animated: true, completion: nil)
        }
    }
    
}








    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


