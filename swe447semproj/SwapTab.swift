//
//  SwapTab.swift
//  swe447semproj
//
//  Created by Jason Seaman on 10/31/19.
//  Copyright © 2019 SWE447. All rights reserved.
//

import SwiftUI

struct SwapTab: View {
    var body: some View {
        TabView {
            ContentView().tabItem {
                Text("Feed")
            }
            ProfileView().tabItem {
                Text("Profile")
            }
        }    }
}

struct SwapTab_Previews: PreviewProvider {
    static let profile = Profile()
    static var previews: some View {
        SwapTab().environmentObject(profile)
    }
}
       
