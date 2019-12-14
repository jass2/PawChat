//
//  HomeViewController.swift
//  swe447semproj
//
//  Created by Jason Seaman on 11/5/19.
//  Copyright © 2019 SWE447. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var tableView = UITableView()
    let posters = ["Jason Seaman", "Devon Adams", "Professor McDonald", "Freeman Hrabowski"]
    let posts = ["Is anyone going to the basketball game tonight? They're giving away free glowsticks.", "How is everyone today?", "When is the last day of finals?", "H.A.G.S"]
    let comments = [["Not me", "Maybe"],["Bad"],["I don't know"],[]]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Paw Feed"
        setTableView()
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
        
        let post = Post(postContent: posts[indexPath.row], poster: posters[indexPath.row])

        cell.post = post
        
        return cell
    }
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pvc = ViewPostController()
        pvc.mainBody = posts[indexPath.row]
        pvc.poster = posters[indexPath.row]
        pvc.comments = comments[indexPath.row]
        pvc.topPost.text = posts[indexPath.row]
        self.navigationController?.pushViewController(pvc, animated: true)
    }

}
