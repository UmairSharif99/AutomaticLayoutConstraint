//
//  ViewController.swift
//  AutomaticLayoutConstraint
//
//  Created by umaireureka on 02/19/2019.
//  Copyright (c) 2019 umaireureka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var isShowElementes = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isShowElementes.toggle()
        if isShowElementes {
            label.text = "some text"
        } else {
            label.text = ""
        }
    }

}

