//
//  OIDC.swift
//  AWSTesting
//
//  Created by Kyaw Lin on 12/3/18.
//  Copyright © 2018 Kyaw Lin. All rights reserved.
//

import Foundation
import AWSCore

class OIDCProvider: NSObject, AWSIdentityProviderManager {
    func logins() -> AWSTask<NSDictionary> {
        let completion = AWSTaskCompletionSource<NSString>()
        getToken(tokenCompletion: completion)
        return completion.task.continueOnSuccessWith { (task) -> AWSTask<NSDictionary>? in
            //login.provider.name is the name of the OIDC provider as setup in the Cognito console
            return AWSTask(result:[AWSCognitoLoginProviderKey.Google:task.result!])
            } as! AWSTask<NSDictionary>
        
    }
    
    func getToken(tokenCompletion: AWSTaskCompletionSource<NSString>) -> Void {
        //get a valid oidc token from your server, or if you have one that hasn't expired cached, return it
        
        //TODO code to get token from your server
        //...
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .APSoutheast1, identityPoolId: "ap-southeast-1:0922b59e-9a0a-4103-9ecb-87a5cd531601", identityProviderManager: OIDCProvider())
        
        credentialProvider.getIdentityId().continueWith { (task) -> Any? in
            if task.error != nil{
                tokenCompletion.trySet(error:NSError(domain: "OIDC Login", code: -1 , userInfo: ["Unable to get OIDC token" : "Details about your error"]))
            }else{
                _ = task.result!
                tokenCompletion.trySet(result:"\(String(describing: task.result))" as NSString)
            }
            return task
        }
        
        //if error getting token, set error appropriately
        
        //else
        
    }
}
