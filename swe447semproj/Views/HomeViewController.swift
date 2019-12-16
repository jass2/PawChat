//
//  HomeViewController.swift
//  swe447semproj
//
//  Created by Jason Seaman on 11/5/19.
//  Copyright © 2019 SWE447. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseDatabase
import Firebase
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    var tableView = UITableView()
    var posts:[String]! = []
    var posters:[String]! = []
    var postIDs:[String]! = []
    var activeUser = ""
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Paw Feed"
        let postsRef = db.collection("posts")
        let getFeed = postsRef.order(by: "time", descending: true).limit(to: 20)
        getFeed.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for post in querySnapshot!.documents {
                    self.posts.append(post.data()["text"] as! String)
                    self.posters.append(post.data()["poster_id"] as! String)
                    self.postIDs.append(post.documentID)
                }
                self.setTableView()
            }
        }
        buildNewCommentButton()
    }
    
    
    
    func setTableView() {
        tableView.frame = self.view.frame
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let post = Post(postContent: posts[indexPath.row], poster: posters[indexPath.row], postID: postIDs[indexPath.row])

        cell.post = post
        
        return cell
    }
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pvc = ViewPostController()
        pvc.mainBody = posts[indexPath.row]
        pvc.poster = posters[indexPath.row]
        pvc.topPost.text = posts[indexPath.row]
        pvc.postID = postIDs[indexPath.row]
        pvc.userLoggedIn = self.activeUser
        self.navigationController?.pushViewController(pvc, animated: true)
    }
    
    private func buildNewCommentButton() -> Void {
           let button = UIBarButtonItem(barButtonSystemItem: .compose,
                                        target: self,
                                        action: #selector(click))
           navigationItem.setRightBarButton(button, animated: false)
    }

    @objc func click() -> Void {
        let alert = UIAlertController(title: "Post to Paw Chat",message: "",preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = nil
            textField.placeholder = "Be respectful."
        }

        alert.addAction(UIAlertAction(title: "Post", style: .default, handler: { [weak alert] (_) in
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
        let ref = self.db.collection("posts").document()
        ref.setData([
                "poster_id": "\(self.activeUser)",
                "text": "\(comment)",
                "comments_allowed": "true",
                "time": "\(postDate)"
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    self.posts.insert(comment, at: 0)
                    self.posters.insert(self.activeUser, at: 0)
                    self.postIDs.insert(ref.documentID, at: 0)
                    self.tableView.register(PostCell.self, forCellReuseIdentifier:"PostCell\(self.posts.count)")
                    self.tableView.reloadData()
                    print("Document successfully written!")
                }
            }
    }
    
}
