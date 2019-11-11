//
//  SignInViewController.swift
//  swe447semproj
//
//  Created by Jason Seaman on 11/5/19.
//  Copyright © 2019 SWE447. All rights reserved.
//
import GoogleSignIn
import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()

        let googleButton = GIDSignInButton()
        view.addSubview(googleButton)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
