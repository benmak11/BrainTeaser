//
//  ViewController.swift
//  BrainTeaser
//
//  Created by Baynham Makusha on 7/20/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginConstraint: NSLayoutConstraint!
    
    var animEngine: AnimationEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.animEngine = AnimationEngine(constraints: [emailConstraint, passwordConstraint, loginConstraint])

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.animEngine.animateOnScreen(1)
    }


}

