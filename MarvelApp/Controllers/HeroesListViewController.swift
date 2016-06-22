//
//  HeroesListViewController.swift
//  MarvelApp
//
//  Created by Danial Zahid on 3/20/16.
//  Copyright © 2016 Danial Zahid. All rights reserved.
//

import UIKit

class HeroesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCharacters()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Setup Methods
    
    
    
    //MARK: - Tableview Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HeroesListTableViewCell.identifier, forIndexPath: indexPath) as! HeroesListTableViewCell
        
        return cell
    }
    
    //MARK: - Web API Methods
    
    func getCharacters() {
        RequestManager.getCharacters(["limit":20], successBlock: { (response: [String: AnyObject]) -> () in
            print(response)
            }) { (error) -> () in
                
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
