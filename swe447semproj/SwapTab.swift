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
            CreateView().tabItem {
                Text("Post")
            }
        }    }
}

struct SwapTab_Previews: PreviewProvider {
    static var previews: some View {
        SwapTab()
    }
}
       
