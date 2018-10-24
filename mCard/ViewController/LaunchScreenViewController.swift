//
//  LaunchScreenViewController.swift
//  mCard
//
//  Created by Bui Phu Khuyen on 10/20/18.
//  Copyright © 2018 Bui Phu Khuyen. All rights reserved.
//

import UIKit
import Firebase

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hàm kiểm tra đã đăng nhập trước đó chưa
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                let sb = UIStoryboard(name: "AppStoryBoard", bundle: nil)
                let pushViewMainApp = sb.instantiateViewController(withIdentifier: "MainApp") as! MainApp_ViewController
                self.present(pushViewMainApp, animated: false, completion: nil)
            }
            else {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let pushViewMainApp = sb.instantiateViewController(withIdentifier: "Main") as! ViewController
                self.present(pushViewMainApp, animated:  false, completion: nil)
            }
        }
    }
}
