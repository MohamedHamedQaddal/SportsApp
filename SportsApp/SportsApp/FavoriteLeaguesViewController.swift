//
//  FavoriteLeaguesViewController.swift
//  SportsApp
//
//  Created by MacOSSierra on 2/23/21.
//  Copyright © 2021 MHQ. All rights reserved.
//

import UIKit



class FavoriteLeaguesViewController: UITableViewController, UIAlertViewDelegate {

    var storedLeaguesManager = CoreDataLayer.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(CoreDataLayer.shared.StoredLeaguess[0].leagueName)
        print(CoreDataLayer.shared.StoredLeaguess[0].badge)
        print(CoreDataLayer.shared.StoredLeaguess[0].leagueID)
        print(CoreDataLayer.shared.StoredLeaguess[0].sportName)
        print(CoreDataLayer.shared.StoredLeaguess[0].youtubeLink)
        print(CoreDataLayer.shared.StoredLeaguess.count)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
                tableView.register(LeaguesTableViewCell.nib(), forCellReuseIdentifier: "leagueCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return storedLeaguesManager.StoredLeaguess.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leaguesTableViewCell: LeaguesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeaguesTableViewCell

        leaguesTableViewCell.label?.text = storedLeaguesManager.StoredLeaguess[indexPath.row].leagueName

        leaguesTableViewCell.strYoutube = URL(string: storedLeaguesManager.StoredLeaguess[indexPath.row].youtubeLink!
        )

        leaguesTableViewCell.loadStoredImage(urlStr: storedLeaguesManager.StoredLeaguess[indexPath.row].badge!)
        
        return leaguesTableViewCell
    }
    
    
    
    
    /*
    //to check internet connection...
    class Connectivity {
        class func isConnectedToInternet() ->Bool {
                if Connectivity.isConnectedToInternet() {
                //redirect user to league details
                }else{//no internet connection
                    
                    // create the alert
                    
                    let alert = UIAlertView(title: "Alert", message: "No internet connetion. Try again.", delegate: self, cancelButtonTitle: nil, otherButtonTitles: nil)
                    
                    alert.show()
                    
                    
                    /*
                    let alert = UIAlertController(title: "Alert", message: "No internet connetion. Try again.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    */
            }
        }}
 */

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
