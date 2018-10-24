//
//  ViewController.swift
//  mCard_iOS
//
//  Created by Bui Phu Khuyen on 9/27/18.
//  Copyright © 2018 Bui Phu Khuyen. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

var UserName: String = ""

// Đoạn Code cho phép chạm màn hình bất kỳ để ẩn bàn phím
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLoginFB: UIButton!
    @IBOutlet weak var iconFB: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControllerIntro: UIPageControl!
    @IBOutlet weak var icoLoading: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
      /*  // Hàm kiểm tra đã đăng nhập trước đó chưa
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                let sb = UIStoryboard(name: "AppStoryBoard", bundle: nil)
                let pushViewMainApp = sb.instantiateViewController(withIdentifier: "MainApp") as! MainApp_ViewController
                self.present(pushViewMainApp, animated: false, completion: nil)
            }
            else {
                print("Chưa đăng nhập")
            }
        } */
        
        // Hiện tất cả các giao diện chương trình
        
        //Hình nền
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background.png")!)
        
        //Chỉnh sửa giao diện cho Outlet Button Đăng ký
        btnRegister.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btnRegister.layer.borderWidth = 1
        btnRegister.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btnRegister.layer.cornerRadius = 6
        
        //Chỉnh sửa giao diện cho Outlet Button Đăng nhập truyền thống
        btnLogin.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.cornerRadius = 6
        
        //Chỉnh sửa giao diện cho Outlet Button, icon Đăng nhập bằng Facebook
        btnLoginFB.layer.borderColor = #colorLiteral(red: 0.1674079001, green: 0.3149680495, blue: 0.4768403769, alpha: 1)
        btnLoginFB.layer.borderWidth = 1
        btnLoginFB.layer.cornerRadius = 6
        btnLoginFB.backgroundColor = #colorLiteral(red: 0.1674079001, green: 0.3149680495, blue: 0.4768403769, alpha: 1)
        
        iconFB.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        iconFB.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        iconFB.layer.cornerRadius = 2
        
        //Hàm ẩn bàn phím khi chạm bất kì ngoài bàn phím
        hideKeyboardWhenTappedAround()
        
        //Giao diện kết hợp Page Control + ScrollView - Giới thiệu phần mềm mCard
        pageControllerIntro.numberOfPages = images.count
        for index in 0..<images.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: images[index])
            self.scrollView.addSubview(imgView)
        }
        scrollView.contentSize =  CGSize(width: (scrollView.frame.size.width * CGFloat(images.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
        
        icoLoading.isHidden = true
    }

    // Hàm Hiển thị thông báo (Dùng chung)
    func ShowAlert(title: String, massage: String)
    {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Bắt sự kiện Button Đăng nhập Facebook
    @IBAction func btnLoginFB(_ sender: Any) {
        LoginFB()
    }
    //Hình ảnh Giới thiệu app mCard, thiết lập vị trí và hàm đánh dấu trang sử dụng ScrollView
    var images: [String] = ["Intro_1.png","Intro_2.png","Intro_3.png"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber =  scrollView.contentOffset.x/scrollView.frame.size.width
        pageControllerIntro.currentPage = Int(pageNumber)
    }
    
    //Hàm Đăng nhập Facebook - Sử dụng kết hợp Facebook SDK + FireBase
    let FBLoginManager = FBSDKLoginManager()
    func LoginFB() {
        //Cho phép Đăng nhập Facebook
        FBLoginManager.logIn (withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil) {
                //Sau khi người dùng đã đăng nhập thành công, chuẩn bị trao uỷ quyền cho Firebase
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                // Xác thực với Firebase sử dụng ủy nhiệm Firebase
                Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                    if let error = error {
                        print("Login error: \(error.localizedDescription)")
                        self.ShowAlert(title: "Thông báo", massage: "Đăng nhập Facebook thất bại")
                        return
                    }
                    //Đăng nhập Facebook thành công thành công => Chuyển sang màn hình chính
                    let sb = UIStoryboard(name: "AppStoryBoard", bundle: nil)
                    let pushViewMainApp = sb.instantiateViewController(withIdentifier: "MainApp") as! MainApp_ViewController
                    self.present(pushViewMainApp, animated: false, completion: nil)
                    
                }
            }
            else {
                self.ShowAlert(title: "Thông báo", massage: "Đăng nhập thất bại")
            }
        }
    }
    /* //Hàm Login Facebook truyền thống
    func LoginFacebook() {
        FBLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, err) in
            if(err==nil) {
                print("Đăng nhập thành công")
                let FBLoginResult:FBSDKLoginManagerLoginResult = result!
                if(FBLoginResult.grantedPermissions != nil) {
                    self.GetDataFB()
                    
                }
            }
            else {
                print("Đăng nhập thất bại")
            }
        }
    }
    //Hàm lấy dữ liệu từ Facebook
  
    func GetDataFB() {
        if(FBSDKAccessToken.current() != nil) { //Đăng nhập thành công rồi
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,name"]).start(completionHandler: { (connect, result, err) in
                if(err==nil) {
                    let dict = result as! Dictionary<String,Any>
                    print(dict)
                  
                }
            })
        }
    }
}*/
    
}
