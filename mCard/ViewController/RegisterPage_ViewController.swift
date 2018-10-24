//
//  RegisterPage_ViewController.swift
//  mCard
//
//  Created by Bui Phu Khuyen on 9/28/18.
//  Copyright © 2018 Bui Phu Khuyen. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseAuth

class RegisterPage_ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtUser: HATextField!
    @IBOutlet weak var txtEmail: HATextField!
    @IBOutlet weak var txtPassword: HATextField!
    @IBOutlet weak var txtPasswordAgain: HATextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtUser {
          txtEmail.becomeFirstResponder()
        }
        else if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        }
        else if textField == txtPassword {
            txtPasswordAgain.becomeFirstResponder()
        }
        else {
            txtPasswordAgain.resignFirstResponder()
        }
        return true
    }
    
    func ShowAlert(title: String, massage: String) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
   
    @IBAction func btn_Register(_ sender: Any) {
        
        let email = self.txtEmail.text
        let username = self.txtUser.text
        let password = self.txtPassword.text
        let passwordagain = self.txtPasswordAgain.text
        
        if((username?.count)! > 0 && (email?.count)! > 5 && (password?.count)! > 4 && (passwordagain?.count)! > 4) {
            if(password == passwordagain) { //Kiểm tra mật khẩu nhập có trùng khớp hay không?
                Auth.auth().createUser(withEmail: email!, password: password!) { (authResult, error) in
                    if(error == nil) {
                        
                        //Đăng ký thành công
                        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
                            
                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.displayName = username
                            changeRequest?.commitChanges { (error) in
                                if(error == nil) {
                                    print("Cập nhật tài khoản thành công")
                                }
                                else {
                                    print("Lỗi cập nhật tài khoản")
                                }
                                
                            }
                        }
                        
                        let alert = UIAlertController(title: "Chúc mừng", message: "Đăng ký thành công.\nBạn có thể dùng thông tin đã đăng ký để đăng nhập.", preferredStyle: UIAlertController.Style.alert)
                        
                        // Chuyển sang màn hình đăng nhập
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (noti) in
                            let SB = UIStoryboard(name: "Main", bundle: nil)
                            let pushLogin = SB.instantiateViewController(withIdentifier: "LoginSB") as! LoginPage_ViewController
                            self.present(pushLogin, animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil )
                        

                        
                        
                    }
                    else {
                        let alert = UIAlertController(title: "Thông báo", message: "Email đã sử dụng trên hệ thống", preferredStyle: .actionSheet)
                        
                        alert.addAction(UIAlertAction(title: "Đăng nhập", style: .default, handler: { (push) in
                                let sb = UIStoryboard(name: "Main", bundle: nil)
                                let pushLogin = sb.instantiateViewController(withIdentifier: "LoginSB") as! LoginPage_ViewController
                                self.present(pushLogin, animated: true, completion: nil)
                        }))
                        
                        alert.addAction(UIAlertAction(title: "Quên mật khẩu", style: .default, handler: { (push) in
                            let sb = UIStoryboard(name: "Main", bundle: nil)
                            let pushLogin = sb.instantiateViewController(withIdentifier: "ResetPass") as! ResetPasswordViewController
                            self.present(pushLogin, animated: true, completion: nil)
                        }))
                        
                        alert.addAction(UIAlertAction(title: "Huỷ bỏ", style: .cancel, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            else {
                ShowAlert(title: "Thông báo", massage: "Mật khẩu nhập phải trùng nhau")
            }
        }
        else {
            ShowAlert(title: "Thông báo", massage: "Thông tin đăng ký không hợp lệ")
        }
    }
    
    /* Đăng ký PHP sử dụng SQL
     let RegisterURL = "http://mcard.site/Register.php"
    
    func ShowAlert(title: String, massage: String)
    {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func btn_Register(_ sender: Any) {
        let email = self.txtEmail.text
        let username = self.txtUser.text
        let password = self.txtPassword.text
        let passwordagain = self.txtPasswordAgain.text
        if((username?.count)! > 0 && (email?.count)! > 5 && (password?.count)! > 4 && (passwordagain?.count)! > 4)
        {
            if(password == passwordagain)
            {
                let parameters: Parameters =  ["username": username!, "email": email!, "password": password!]
                Alamofire.request(self.RegisterURL, method: .post, parameters: parameters, encoding: URLEncoding.default).response
                {
                    response in
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)
                    {
                        if(utf8Text == "SUCCESS")
                        {
                            
                           //Đăng ký thành công
                            
                            let alert = UIAlertController(title: "Chúc mừng", message: "Đăng kí thành công.\nBạn có thể dùng thông tin đã đăng ký để đăng nhập.", preferredStyle: UIAlertController.Style.alert)
                            
                            // Chuyển sang màn hình đăng nhập
                            
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (noti) in
                                let pushViewLogin = self.storyboard?.instantiateViewController(withIdentifier: "LoginSB")as!LoginPage_ViewController
                                self.present(pushViewLogin, animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil )
                            
                            
                        }
                        else
                        {
                            self.ShowAlert(title: "Thông báo", massage: "Đăng ký không thành công")
                            //Đăng ký không thành công
                            
                        }
                    }
                }
            }
            else
            {
                self.ShowAlert(title: "Thông báo", massage: "Mật khẩu không trùng khớp!")
            }
        }
        else
        {
             self.ShowAlert(title: "Thông báo", massage: "Vui lòng nhập vào các thông tin đăng ký cho phù hợp!")
        }
     
 
    }
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background.png")!)
       
        txtUser.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        txtPassword.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        txtEmail.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        txtPasswordAgain.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        btnRegister.layer.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        btnRegister.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        btnRegister.layer.borderWidth = 2
        btnRegister.layer.cornerRadius = 6
        
        //Hàm ẩn bàn phím khi chạm bất kì ngoài bàn phím
        hideKeyboardWhenTappedAround()
        
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
