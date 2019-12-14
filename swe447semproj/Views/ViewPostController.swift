//
//  ViewPostController.swift
//  swe447semproj
//
//  Created by Jason Seaman on 12/8/19.
//  Copyright © 2019 SWE447. All rights reserved.
//

import UIKit

class ViewPostController: UIViewController {
 
    var poster:String = ""
    var mainBody:String = ""
    @Published var comments:[String]!
    var commentsView = UITableView()
    var topPost = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (comments.count > 0) {
            setTableView()
        } else {
            let post = PostCell()
            post.poster.text = poster
            post.postBody.text = mainBody
            self.view.addSubview(post)
        }
        buildNewCommentButton()
    }
    
    @objc func setTableView() {
           commentsView.frame = self.view.frame
           commentsView.backgroundColor = UIColor.white
           commentsView.delegate = self
           commentsView.dataSource = self
           commentsView.estimatedRowHeight = 100
           commentsView.rowHeight = UITableView.automaticDimension
           commentsView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
           commentsView.register(CommentButton.self, forCellReuseIdentifier: "CommentButton")

           
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
    return comments.count
}

    
func tableView(_ commentsView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = commentsView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
    
    let post = Post(postContent: comments[indexPath.row], poster: "")

    cell.post = post
    
    return cell
}

    internal func tableView(_ commentsView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = commentsView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell
        
        headerView?.backgroundColor = .green
        headerView?.postBody.text = mainBody
        headerView?.poster.text = poster
        
        return headerView
    }

    internal func tableView(_ commentsView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
//    internal func tableView(_ commentsView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let headerView = commentsView.dequeueReusableCell(withIdentifier: "CommentButton") as? CommentButton
//
//        return headerView
//    }
    
    
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
        self.comments.append(comment)
        print("Test")
        print(self.comments.count)
        commentsView.reloadData()
    }

}
