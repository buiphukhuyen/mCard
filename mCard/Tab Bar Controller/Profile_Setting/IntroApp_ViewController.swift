//
//  IntroApp_ViewController.swift
//  mCard
//
//  Created by Bui Phu Khuyen on 10/20/18.
//  Copyright © 2018 Bui Phu Khuyen. All rights reserved.
//

import UIKit

class IntroApp_ViewController: UIViewController {

    @IBOutlet weak var imgKhuyen: UIImageView!
    @IBOutlet weak var imgSon: UIImageView!
    @IBOutlet weak var lblAdmin: UILabel!
    @IBOutlet weak var lblUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background_Non")!)
        imgKhuyen.layer.cornerRadius = imgKhuyen.frame.width/2
        imgKhuyen.clipsToBounds = true
        imgKhuyen.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        imgKhuyen.layer.borderWidth = 2
        
        
        imgSon.layer.cornerRadius = imgSon.frame.width/2
        imgSon.clipsToBounds = true
        imgSon.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
        imgSon.layer.borderWidth = 2
        
        lblAdmin.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lblAdmin.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        lblAdmin.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        lblAdmin.layer.borderWidth = 2
        lblAdmin.layer.cornerRadius = 6
        lblAdmin.clipsToBounds = true
        
        lblUser.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lblUser.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
        lblUser.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
        lblUser.layer.borderWidth = 2
        lblUser.layer.cornerRadius = 6
        lblUser.clipsToBounds = true
        
        //Hàm ẩn bàn phím khi chạm bất kì ngoài bàn phím
        hideKeyboardWhenTappedAround()
        
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
