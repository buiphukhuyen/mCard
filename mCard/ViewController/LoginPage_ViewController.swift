//
//  LoginPage_ViewController.swift
//  mCard_iOS
//
//  Created by Bui Phu Khuyen on 9/28/18.
//  Copyright © 2018 Bui Phu Khuyen. All rights reserved.
//

import UIKit
import Alamofire

//Biến User đăng nhập lấy từ Localhost


class LoginPage_ViewController: UIViewController {
    @IBOutlet weak var txtUser: HATextField!
    @IBOutlet weak var txtPassword: HATextField!
    @IBOutlet weak var btnLogin: UIButton!
    let LoginURL = "http://192.168.64.2/DataUserLogin/Login.php"
    
    //Nút đăng nhập đã được click
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background.png")!)
        
        txtUser.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        txtPassword.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        btnLogin.layer.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        btnLogin.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        btnLogin.layer.borderWidth = 2
        btnLogin.layer.cornerRadius = 6
    }
    
    func ShowAlert(title: String, massage: String)
    {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btn_Login(_ sender: Any) {
        let username = self.txtUser.text
        let password = self.txtPassword.text
        
        if((username?.count)! > 0 && (password?.count)! > 4)
        {
            let parameters: Parameters =  ["username": username!, "password": password!]
            Alamofire.request(self.LoginURL, method: .post, parameters: parameters, encoding: URLEncoding.default).response {
                response in
                /* Kiểm tra dữ liệu nhận về từ Server
                print("Request: \(String(describing: response.request))")
                print("Response: \(String(describing: response.response))")
                print("Error: \(String(describing: response.error))") */
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)
                {
                   // print("Data: \(utf8Text)") Success - OK
                    if(utf8Text == "SUCCESS")
                    {
                        //Đăng nhập thành công
                        self.ShowAlert(title: "Chúc mừng", massage: "Đăng nhập thành công")
                    }
                    else
                    {
                        self.ShowAlert(title: "Thông báo", massage: "Đăng nhập   thành công")
                        //Đăng nhập không thành công
                        
                    }
                }
            }
        }
        else
        {
            if((username?.count)! == 0 && (password?.count)! == 0)
            {
               self.ShowAlert(title: "Thông báo", massage: "Vui lòng nhập Tên Đăng nhập và Mật khẩu")
            }
            if((username?.count)! == 0)
            {
                self.ShowAlert(title: "Thông báo", massage: "Vui lòng nhập Tên Đăng nhập")
            }
            if((password?.count)! == 0)
            {
                self.ShowAlert(title: "Thông báo", massage: "Vui lòng nhập Mật khẩu")
            }
        }
    }

}
