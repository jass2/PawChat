//
//  PostCell.swift
//  swe447semproj
//
//  Created by Jason Seaman on 11/24/19.
//  Copyright © 2019 SWE447. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class PostCell: UITableViewCell {
    
    var post : Post? {
        didSet {
            postBody.text = post?.postContent
            poster.text = post?.poster
        }
    }
    
    public let postBody : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize:16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    public let poster : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.font = UIFont.boldSystemFont(ofSize:12)
        lbl.textAlignment = .right
        return lbl
    }()
    
    public let votes : UIButton = {
        let btn = UIButton(type: .custom)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(postBody)
        addSubview(votes)
        
      // postBody.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: frame.size.width, height: 0, enableInsets: false)
        postBody.translatesAutoresizingMaskIntoConstraints = false
        postBody.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        postBody.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        postBody.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        postBody.numberOfLines = 0
        
        addSubview(poster)
        
        poster.translatesAutoresizingMaskIntoConstraints = false
        
        poster.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        poster.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        poster.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        poster.topAnchor.constraint(equalTo: postBody.bottomAnchor).isActive = true
        poster.numberOfLines = 0
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
