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
    
    @State var post = 0
    
    var body: some View {
        NavigationView {
            Form {
                Text("contentView")
                Button("Sign In \(post)") {
                    self.post += 1 % 2
                }
            }
        }.navigationBarTitle("Login")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
