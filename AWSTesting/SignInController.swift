//
//  MainController.swift
//  AWSTesting
//
//  Created by Kyaw Lin on 12/3/18.
//  Copyright © 2018 Kyaw Lin. All rights reserved.
//

import UIKit
import AWSAuthCore
import AWSAuthUI

class SignInController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if AWSSignInManager.sharedInstance().isLoggedIn{
            if let appdelegate = UIApplication.shared.delegate as? AppDelegate{
                appdelegate.presentHomeController()
            }
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.refreshCredentials()
    }
    
    @IBAction func googleSignIn(_ sender: UIButton) {
        if !AWSSignInManager.sharedInstance().isLoggedIn{
            AWSAuthUIViewController.presentViewController(with: self.navigationController!, configuration: nil, completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                if error != nil{
                    print("Error occured: \(String(describing: error?.localizedDescription))")
                }else{
                    print("Sign in successfully")
                    self.refreshCredentials()
                    if let appdelegate = UIApplication.shared.delegate as? AppDelegate{
                        appdelegate.presentHomeController()
                    }
                }
            })
        }
    }
    
    private func refreshCredentials(){
        AWSIdentityManager.default().credentialsProvider.credentials().continueWith(block: { (task : AWSTask<AWSCredentials>) -> Any? in
            if let result = task.value(forKey: "result") as? AWSCredentials{
                Constant.secretKey = result.secretKey
                Constant.accessKey = result.accessKey
                Constant.sessionKey = result.sessionKey
            }
            print("SessinoKey: \(Constant.sessionKey!)")
            print("SecretKey: \(Constant.secretKey!)")
            print("AccessKey:\(Constant.accessKey!)")
            return task
        })
    }
    
    @IBAction func annonymousSignIn(_ sender: UIButton) {
        
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
