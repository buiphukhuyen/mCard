//
//  ResetPasswordViewController.swift
//  mCard
//
//  Created by Bui Phu Khuyen on 10/20/18.
//  Copyright © 2018 Bui Phu Khuyen. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtMail: HATextField!
    @IBOutlet weak var btnResetPass: UIButton!

    // Hàm Hiển thị thông báo (Dùng chung)
    func ShowAlert(title: String, massage: String)
    {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            txtMail.becomeFirstResponder()
        return true
    }
    
    @IBAction func btn_ResetPass(_ sender: Any) {
        let email = txtMail.text
        Auth.auth().sendPasswordReset(withEmail: email!) { (error) in
            if error != nil {
                self.ShowAlert(title: "Thông báo", massage: "Email không tồn tại trên hệ thống\nVui lòng kiểm tra lại!")
            }
            else {
                self.ShowAlert(title: "Thông báo", massage: "Khôi phục mật khẩu thành công\nVui lòng kiểm tra lại Email\nđể xác nhận!")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background.png")!)
        
        txtMail.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        btnResetPass.layer.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        btnResetPass.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        btnResetPass.layer.borderWidth = 2
        btnResetPass.layer.cornerRadius = 6

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
