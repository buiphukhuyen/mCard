//
//  ChangeInfoUser_ViewController.swift
//  mCard
//
//  Created by Bui Phu Khuyen on 10/21/18.
//  Copyright © 2018 Bui Phu Khuyen. All rights reserved.
//

import UIKit
import Firebase



class ChangeInfoUser_ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtNewUsername: HATextField!
    @IBOutlet weak var txtNewMail: HATextField!
    @IBOutlet weak var txtPasswordNew: HATextField!
    @IBOutlet weak var txtPasswordNewagain: HATextField!
    @IBOutlet weak var btnUpdateInfoUser: UIButton!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtNewUsername {
            txtNewMail.becomeFirstResponder()
        }
        else if textField == txtNewMail {
            txtPasswordNew.becomeFirstResponder()
        }
        else if textField == txtPasswordNew {
            txtPasswordNewagain.becomeFirstResponder()
        }
        else {
            txtPasswordNewagain.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func btnChangeInfoUser(_ sender: Any) {
        let alert = UIAlertController(title: "Thông báo", message: nil, preferredStyle: .actionSheet)
      
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = txtNewUsername.text
        changeRequest?.commitChanges { (error) in
            if(error == nil) {
                alert.addAction(UIAlertAction(title: "Cập nhật Tên người dùng thành công", style: .default, handler: nil))
            }
            else {
                 alert.addAction(UIAlertAction(title: "Lỗi cập nhật Tên người dùng", style: .default, handler: nil))
            }
            
        }
        
        user?.updateEmail(to: txtNewMail.text!, completion: { (err) in
            if err != nil {
                print("Lỗi cập nhật email:\(String(describing: err?.localizedDescription))")
                alert.addAction(UIAlertAction(title: "Lỗi cập nhật địa chỉ Email", style: .default, handler: nil))
            }
            else {
                alert.addAction(UIAlertAction(title: "Cập nhật Email thành công", style: .default, handler: nil))
            }
        })
        
        user?.updatePassword(to: txtNewMail.text!, completion: { (err) in
            if(self.txtPasswordNew.text != self.txtPasswordNewagain.text) {
               alert.addAction(UIAlertAction(title: "Mật khẩu phải trùng khớp", style: .default, handler: nil))
            }
            
            if err != nil {
                print("Lỗi cập nhật mật khẩu: \(String(describing: err?.localizedDescription))")
                alert.addAction(UIAlertAction(title: "Lỗi cập nhật Mật khẩu", style: .default, handler: nil))
            }
            else {
                alert.addAction(UIAlertAction(title: "Cập nhật Mật khẩu thành công", style: .default, handler: nil))
            }
        })
        
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Background_Non")!)
        txtNewUsername.placeholder = user?.displayName
        txtNewMail.placeholder = user?.email
        
        //Hàm ẩn bàn phím khi chạm bất kì ngoài bàn phím
        hideKeyboardWhenTappedAround()
        
    
        btnUpdateInfoUser.layer.cornerRadius = 7
        
        
    }
}
