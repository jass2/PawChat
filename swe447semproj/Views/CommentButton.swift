//
//  CommentButton.swift
//  swe447semproj
//
//  Created by Jason Seaman on 12/9/19.
//  Copyright © 2019 SWE447. All rights reserved.
//

import UIKit

class CommentButton: UITableViewCell {
        
        
        public let btn : UIButton = {
            let lbl = UIButton()
            lbl.backgroundColor = .black
            lbl.setTitle("Add Comment", for: .normal)
            lbl.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
            return lbl
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addSubview(btn)
            
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
            btn.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
            btn.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
            
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    @IBAction func buttonAction(sender: UIButton!) {
      print("Button tapped")
    }
        
    }
