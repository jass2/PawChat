//
//  Post.swift
//  swe447semproj
//
//  Created by Jason Seaman on 11/24/19.
//  Copyright © 2019 SWE447. All rights reserved.
//

import Foundation

class Post {
    var postContent: String = "e";
    var poster: String = "f";
    
    init() {
        
    }
    
    init(postContent: String, poster: String) {
        self.postContent = postContent
        self.poster = poster
    }
}
