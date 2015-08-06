//
//  ViewController.swift
//  Oriole
//
//  Created by Tyler Thompson on 08/04/2015.
//  Copyright (c) 2015 Tyler Thompson. All rights reserved.
//

import UIKit
import Oriole

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		print([4, 8, 15, 16, 23, 42].chunk(2))
		print([4, 8, 15, 16, 23, 42].every {$0 == 23})
		print([42, 42, 42, 42].every {$0 == 42})

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

