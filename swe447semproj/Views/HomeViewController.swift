//
//  HomeViewController.swift
//  swe447semproj
//
//  Created by Jason Seaman on 11/5/19.
//  Copyright © 2019 SWE447. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        title.text = "Home Page"
        title.center = view.center
        view.addSubview(title)
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
