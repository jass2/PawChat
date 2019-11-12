//
//  Screen.swift
//  swe447semproj
//
//  Created by Jason Seaman on 11/10/19.
//  Copyright © 2019 SWE447. All rights reserved.
//

import UIKit
import GoogleSignIn
import SwiftUI
import Firebase

class Screen: UIViewController, UIWindowSceneDelegate, GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        let loginButton = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        loginButton.center = view.center
        view.addSubview(loginButton)
        view.backgroundColor = .yellow
        
        // Do any additional setup after loading the view.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
                return
            } else {
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
            }
        }
    }
    
}

