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
import FirebaseFirestore

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
                let user = Auth.auth().currentUser
                var cond: String = "\(user?.email ?? "a@a")"
                let condArray = cond.components(separatedBy: "@")
                let username: String = condArray[0]
                cond = condArray[1]
                if (cond != "umbc.edu") {
                    self.authFail()
                    return
                } else {
                    let userID = Auth.auth().currentUser?.uid
                    let db = Firestore.firestore()
                    let ref = db.collection("users").document(userID!)
                    
                    ref.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data: \(dataDescription)")
                        } else {
                            print("Document does not exist")
                            let newUser = db.collection("user")
                            newUser.document(userID!).setData([
                                "blocked": false,
                                "email": "\(user?.email ?? "a@a")",
                                "first": "",
                                "graduating": 2020,
                                "major": "",
                                "username": username,
                            ])
                        }
                    }

                    let homeInstance = HomeViewController()
                    homeInstance.activeUser = username
                    self.navigationController?.pushViewController(homeInstance, animated: true)
              
                }
            }
        }
    }
    
    @objc func authFail() -> Void {
        let alert = UIAlertController(title: "Unable to Log in",message: "Paw Chat is only available to users via xxx@umbc.edu addresses.",preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    
}

