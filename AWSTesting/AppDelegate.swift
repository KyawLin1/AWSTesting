//
//  AppDelegate.swift
//  AWSTesting
//
//  Created by Kyaw Lin on 11/3/18.
//  Copyright © 2018 Kyaw Lin. All rights reserved.
//

import UIKit
import GoogleSignIn
import AWSCore
import AWSCognito
import AWSCognitoIdentityProvider

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate{
    
    var window: UIWindow?
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let credentialProvider = AWSCognitoCredentialsProvider(regionType: .APSoutheast1, identityPoolId: "ap-southeast-1:0922b59e-9a0a-4103-9ecb-87a5cd531601")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GIDSignIn.sharedInstance().clientID = "100225119267-3qupq2cj73nq55k76fin3e2h3ag4din0.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        let configuration = AWSServiceConfiguration(region: .APSoutheast1, credentialsProvider: credentialProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        //Changing Logging Level
        AWSDDLog.sharedInstance.logLevel = .verbose
        //Targeting Log Output
        let fileLogger = AWSDDFileLogger()
        fileLogger?.rollingFrequency = TimeInterval(60*60*24)
        fileLogger?.logFileManager.maximumNumberOfLogFiles = 7
        AWSDDLog.add(fileLogger!)
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance)
        
        return true
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error{
            print("\(error.localizedDescription)")
        }else{
//            let userID = user.userID
//            let idToken = user.authentication.idToken
//            let fullName = user.profile.name
//            let givenName = user.profile.givenName
//            let familyName = user.profile.familyName
//            let email = user.profile.email
//            if user.profile.hasImage{
//
//            }
//            credentialProvider.getIdentityId().continueWith { (task) -> Any? in
//                if task.error != nil{
//                    print("Error : \(error.localizedDescription)")
//                }else{
//                    let cognitoID = task.result!
//                    print("Cognito ID : \(cognitoID)")
//                }
//                return task
//            }
//
//
//
            let input = AWSCognitoIdentityGetOpenIdTokenInput()
            input?.logins = [AWSIdentityProviderGoogle:user.authentication.idToken]
            AWSCognitoIdentity.default().getOpenIdToken(input!)
            
            credentialProvider.clearCredentials()
            
            credentialProvider.getIdentityId().continueWith(block: { (task) -> Any? in
                if task.error != nil{
                    print("Error : \(error.localizedDescription)")
                }else{
                    let cognitoID = task.result!
                    print("Cognito ID : \(cognitoID)")
                }
                return task
            })
            
            if let mainController = storyBoard.instantiateViewController(withIdentifier: "main") as? UINavigationController{
                self.window?.rootViewController = mainController
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //Perform any operations when the user disconnects from app here.
        if let error = error{
            print("\(error.localizedDescription)")
        }else{
            
        }
    }
    
    
    func showSignIn(){
        if let signInController = storyBoard.instantiateViewController(withIdentifier: "signin") as? SignInController{
            self.window?.rootViewController = signInController
        }
    }
    
    func completeLogin(logins: [NSObject : AnyObject]?){
        var task : AWSTask<AnyObject>?
        var merge = [NSObject : AnyObject]()
        //Add existing logins
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

enum AWSCognitoLoginProviderKey:String{
    case Facebook = "graph.facebook.com"
    case Google = "accounts.google.com"
    case Amazon = "www.amazon.com"
    case Twitter = "api.twitter.com"
    case Digits = "www.digits.com"
    
}

