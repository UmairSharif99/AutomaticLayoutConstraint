//
//  ListViewController.swift
//  AutomaticLayoutConstraint_Example
//
//  Created by apple on 2/20/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    var arrayOfFlags: [Bool] = [true, false, true, false, true, false, true, false]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(toggleOptions))
    }
    
    @objc func toggleOptions() {
        let newArray = arrayOfFlags.map { (value) -> Bool in
            let newFlag: Bool = value
            return !newFlag
        }
        
        arrayOfFlags = newArray
        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        
        let flag = arrayOfFlags[indexPath.row]
        
        if flag {
            cell.logoImage.image = UIImage(named: "placeholder")
        } else {
            cell.logoImage.image = nil
        }
        
        if indexPath.row % 2 == 0 {
            cell.statusImage.image = nil
        } else {
            cell.statusImage.image = UIImage(named: "placeholder")
        }
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
