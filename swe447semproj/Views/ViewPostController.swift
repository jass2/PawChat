//
//  ViewPostController.swift
//  swe447semproj
//
//  Created by Jason Seaman on 12/8/19.
//  Copyright © 2019 SWE447. All rights reserved.
//

import UIKit
import SwiftUI
import Foundation
import FirebaseFirestore

class ViewPostController: UIViewController {
 
    var poster:String = ""
    var mainBody:String = ""
    var comments:Array<String> = []
    var commentPoster:Array<String> = []
    var commentsView = UITableView()
    var topPost = UILabel()
    var userLoggedIn:String = ""
    let db = Firestore.firestore()
    var postID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let commentsQuery = db.collection("comment").whereField("post", isEqualTo: self.postID).order(by: "time", descending: true)
        
        commentsQuery.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting comments: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.comments.append(document.data()["text"] as! String)
                    self.commentPoster.append(document.data()["poster"] as! String)
                }
                self.setTableView()
                self.buildNewCommentButton()
            }
        }
    }
    
    @objc func setTableView() {
           commentsView.frame = self.view.frame
           commentsView.backgroundColor = UIColor.white
           commentsView.delegate = self
           commentsView.dataSource = self
           commentsView.estimatedRowHeight = 100
           commentsView.rowHeight = UITableView.automaticDimension
           commentsView.register(PostCell.self, forCellReuseIdentifier: "Header")
           commentsView.register(UITableViewCell.self, forCellReuseIdentifier: "EmptyCell")

        if (comments.count > 0) {
            for index in 1...comments.count {
                       commentsView.register(PostCell.self, forCellReuseIdentifier:"PostCell\(index)")
                }
        }
           
           self.view.addSubview(commentsView)
           
           commentsView.translatesAutoresizingMaskIntoConstraints = false
           
           commentsView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
           commentsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
           commentsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
           commentsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
}

extension ViewPostController: UITableViewDelegate, UITableViewDataSource {
func tableView(_ commentsView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (comments.count > 0) {
        return comments.count
    } else {
        return 1;
    }
}

    
func tableView(_ commentsView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if (comments.count > 0) {
    
    let cell = commentsView.dequeueReusableCell(withIdentifier: "PostCell\(indexPath.row + 1)", for: indexPath) as! PostCell
    
    let post = Post(postContent: comments[indexPath.row], poster: commentPoster[indexPath.row], postID: postID)

    cell.post = post
    return cell
    
    } else {
        let cell = commentsView.dequeueReusableCell(withIdentifier: "EmptyCell")!
        cell.textLabel?.text = "No comments yet."
        return cell
    }
}

    internal func tableView(_ commentsView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = commentsView.dequeueReusableCell(withIdentifier: "Header") as? PostCell
                
        headerView?.backgroundColor = .yellow
        headerView?.postBody.text = mainBody
        headerView?.poster.text = poster
    
        return headerView
    }

    internal func tableView(_ commentsView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }

    
    private func buildNewCommentButton() -> Void {
        let button = UIBarButtonItem(barButtonSystemItem: .compose,
                                     target: self,
                                     action: #selector(click))
        navigationItem.setRightBarButton(button, animated: false)
    }
    
    @objc func click() -> Void {
        let alert = UIAlertController(title: mainBody,message: "Add your comment",preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = nil
            textField.placeholder = "Be respectful."
        }

        alert.addAction(UIAlertAction(title: "Add Comment", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]

            if (textField?.hasText)! {
                self.postComment(comment: (textField?.text)!)
            }
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func postComment(comment: String) -> Void {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        let postDate = calendar.date(from: components)!
        self.db.collection("comment").document().setData([
            "post": "\(self.postID)",
            "poster": "\(self.userLoggedIn)",
            "text": "\(comment)",
            "time": "\(postDate)"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                self.comments.append(comment)
                self.commentPoster.append(self.userLoggedIn)
                self.commentsView.register(PostCell.self, forCellReuseIdentifier:"PostCell\(self.comments.count)")
                self.commentsView.reloadData()
                print("Document successfully written!")
            }
        }
      
        
    }

}
