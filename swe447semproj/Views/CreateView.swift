//
//  CreateView.swift
//  swe447semproj
//
//  Created by Jason Seaman on 11/10/19.
//  Copyright © 2019 SWE447. All rights reserved.
//

import SwiftUI

struct CreateView: View {
    @State private var textBody = ""
    @State private static var limit = 256
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $textBody)
            }
        
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
