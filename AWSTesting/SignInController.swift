//
//  ViewController.swift
//  AWSTesting
//
//  Created by Kyaw Lin on 11/3/18.
//  Copyright © 2018 Kyaw Lin. All rights reserved.
//

import UIKit
import GoogleSignIn

class SignInController: UIViewController, GIDSignInUIDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        //TODO(developer) Configure the sign-in button look/feel
        //...
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

