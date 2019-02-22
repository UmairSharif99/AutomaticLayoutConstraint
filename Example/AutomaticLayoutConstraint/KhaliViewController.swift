//
//  KhaliViewController.swift
//  AutomaticLayoutConstraint_Example
//
//  Created by apple on 2/22/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class MyView: UIView {
    var showAnimation: Bool? = false
    func toggle() {
        if showAnimation == nil {
            showAnimation = true
        }else {
            showAnimation = nil
        }
    }
}

class KhaliViewController: UIViewController {

    @IBOutlet weak var locationView: MyView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationView.showAnimation = false
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        locationView.toggle()
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
