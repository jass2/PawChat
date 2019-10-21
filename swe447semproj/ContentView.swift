//
//  ContentView.swift
//  swe447semproj
//
//  Created by Jason Seaman on 10/10/19.
//  Copyright © 2019 SWE447. All rights reserved.
//

import SwiftUI
import GoogleSignIn

struct ContentView: View {
    var body: some View {
        let googleButton = GIDSignInButton()
               view.addSubview(googleButton)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
