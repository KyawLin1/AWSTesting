//
//  HomeController.swift
//  AWSTesting
//
//  Created by Kyaw Lin on 16/3/18.
//  Copyright © 2018 Kyaw Lin. All rights reserved.
//

import UIKit
import AWSAuthCore

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Logout(_ sender: UIBarButtonItem) {
        AWSSignInManager.sharedInstance().logout { (success, error) in
            if let error = error{
                print("\(error.localizedDescription)")
            }else{
                print("Successfully logged out")
                if let appdelegate = UIApplication.shared.delegate as? AppDelegate{
                    appdelegate.presentSignInController()
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
