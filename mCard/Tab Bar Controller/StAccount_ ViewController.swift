//
//  StAccount_ ViewController.swift
//  mCard
//
//  Created by Bui Phu Khuyen on 10/16/18.
//  Copyright © 2018 Bui Phu Khuyen. All rights reserved.
//

import UIKit
import Firebase

class StAccount__ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var tabUser: UITableView!
    @IBOutlet weak var tabInfo: UITableView!
    
    var Arr1:[String]!
    var Arr2:[String]!
    var ArrImg1:[String]!
    var ArrImg2:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hình nền viền ẩn - không xanh
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background_Non.png")!)
        
        //Hiển thị tên người dùng
        lblName.text = user?.displayName
        
        //Chỉnh sửa giao diện Button Đăng xuất
        btnLogout.layer.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        btnLogout.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        btnLogout.layer.borderWidth = 2
        btnLogout.layer.cornerRadius = 6
        
        //Hàm ẩn bàn phím khi chạm bất kì ngoài bàn phím
        hideKeyboardWhenTappedAround()
        
        //Chỉnh sửa ảnh Avatar - bo viền tròn
        imgUser.layer.cornerRadius = imgUser.frame.size.width/2
        imgUser.clipsToBounds = true
        
        // Tạo 2 mảng String chứa các tên trong 2 chức năng trong TableView (Người dùng - Thông tin ứng dụng)
        Arr1 = ["Chỉnh sửa thông tin Cá nhân", "Quản lý thẻ"]
        Arr2 = ["Giới thiệu", "Liên hệ & Hỗ trợ", "Góp ý", "Hướng dẫn/Trợ giúp"]
        ArrImg1 = ["1","2"]
        ArrImg2 = ["3","4","5","6"]
        
        // Bắt sự kiện 2 hàm DataSource và Delegate cho 2 TableView
        tabUser.dataSource = self
        tabInfo.dataSource = self
        tabInfo.delegate = self
        tabUser.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // Hàm Hiển thị thông báo (Dùng chung)
    func ShowAlert(title: String, massage: String)
    {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Trả về số Cell trong mỗi Table View (2 TableView: Người dùng và Thông tin ứng dụng) - Hàm UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView.tag == 0) {
            return Arr1.count
        }
        if(tableView.tag == 1) {
            return Arr2.count
        }
        return 0
    }
    
     //Trả về dữ liệu của từng TableView (Tên Cell kèm Hình ảnh) - Hàm UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if(tableView.tag == 0) {
            cell?.imageView?.image = UIImage(named: ArrImg1[indexPath.row])
            cell?.textLabel?.text = Arr1[indexPath.row]
        }
        if(tableView.tag == 1) {
            cell?.imageView?.image = UIImage(named: ArrImg2[indexPath.row])
            cell?.textLabel?.text = Arr2[indexPath.row]
        }
        return cell!
    }
    
    //Bắt sự kiện Table View - Hàm UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        //TableView Người dùng
        if(tableView.tag == 0) {
            
            //Cell Chỉnh sửa thông tin người dùng
            if(indexPath.row == 0) {
                let sb = UIStoryboard(name: "AppStoryBoard", bundle: nil)
                let push = sb.instantiateViewController(withIdentifier: "ChangeInfoUser") as! ChangeInfoUser_ViewController
                self.navigationController?.pushViewController(push, animated: true)
            
            }
        }
        
        //TableView Thông tin ứng dung
        if(tableView.tag == 1) {
            
            //Cell Giới thiệu App
            if(indexPath.row == 0) {
                let sb = UIStoryboard(name: "AppStoryBoard", bundle: nil)
                let push = sb.instantiateViewController(withIdentifier: "Intro_App") as! IntroApp_ViewController
                self.navigationController?.pushViewController(push, animated: true)
            }
            
            //Cell Liên hệ & Hỗ trợ
            if(indexPath.row == 1) {
                
                //Tạo thông báo hỗ trợ
                let alert = UIAlertController(title: "Liên hệ", message: "Chọn hình thức Liên hệ", preferredStyle: UIAlertController.Style.actionSheet)
                
                //Cho phép gọi đến số điện thoại Hỗ trợ
                alert.addAction(UIAlertAction(title: "Gọi điện thoại", style: .default, handler: { (noti) in
                    let url = URL(string: "tel:0333093935")
                    if UIApplication.shared.canOpenURL(url!) {
                        UIApplication.shared.open(url!)
                    }
                    else {
                        self.ShowAlert(title: "Lỗi", massage: "Không thể gọi đến Số Hỗ trợ")
                    }
                }))
                
                //Cho phép gửi Mail Hỗ trợ
                alert.addAction(UIAlertAction(title: "Gửi địa chỉ Email", style: .default, handler: { (noti) in
                    let url = URL(string: "mailto:khuyenpb@gmail.com")
                    if UIApplication.shared.canOpenURL((url!)) {
                        UIApplication.shared.open(url!)
                    }
                    else {
                        self.ShowAlert(title: "Lỗi", massage: "Không thể gửi Mail Hỗ trợ")
                    }
                }))
                alert.addAction(UIAlertAction(title: "Huỷ bỏ", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            }
            //Cell Góp ý
            
            if(indexPath.row == 2) {
                //Tạo thông báo Góp ý
                let alert = UIAlertController(title: "Góp ý", message: "Cảm ơn bạn đã góp ý\nBạn sẽ được kết nối trên Messenger!", preferredStyle: UIAlertController.Style.actionSheet)
                
                //Cho phép chuyển sang ứng dụng Messenger
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (noti) in
                    if let url = URL(string: "fb-messenger://user-thread/boysmarts98") {
                        // Cho phép liên hệ Messenger Bùi Phú Khuyên (nếu đã cài ứng dụng Messenger)
                        UIApplication.shared.open(url, options: [:], completionHandler: {
                            (success) in
                            if success == false {
                               
                                // Cho phép liên hệ chạy trên trình duyệt (chưa cài ứng dụng Messenger)
                                let url = URL(string: "https://m.me/boysmarts98")
                                if UIApplication.shared.canOpenURL(url!) {
                                    UIApplication.shared.open(url!)
                                }
                            }
                        } )
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Huỷ bỏ", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //Sự kiện Button Đăng xuất ứng dụng
    @IBAction func btn_Logout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        let alert = UIAlertController(title: "Thông báo", message: "Bạn có muốn Đăng xuất", preferredStyle: .actionSheet)
       
        alert.addAction(UIAlertAction(title: "Đăng xuất", style: .destructive, handler: { (logout) in
            do {
                // Bắt lỗi có thể Logout được không?
                try firebaseAuth.signOut()
                
                //Chuyển về màn hình chính
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let pushViewMainApp = sb.instantiateViewController(withIdentifier: "Main") as! ViewController
                self.present(pushViewMainApp, animated: true, completion: nil)
                
            } catch
                let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Huỷ bỏ", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
