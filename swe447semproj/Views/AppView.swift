//
//  AppView.swift
//  swe447semproj
//
//  Created by Jason Seaman on 10/31/19.
//  Copyright © 2019 SWE447. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        
    }
}

struct AppView_Previews: PreviewProvider {
    static let homePage = Profile()
    
    static var previews: some View {
        AppView().environmentObject(Launch)
    }
}
