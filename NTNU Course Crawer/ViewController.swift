//
//  ViewController.swift
//  NTNU Course Crawer
//
//  Created by asef18766 on 2020/3/8.
//  Copyright © 2020 Normal OJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func login(_ username: String , _ passwd: String){
        print("try to login")
        let url = URL(string: "http://cos3.ntnu.edu.tw/AasEnrollStudent/LoginCheckCtrl")
        var request : URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            data,response,error in
            print("anything")
            do {
                if let d = data{
                    print(String(data: d, encoding: .utf8)!)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    func raiseError(_ error: String) {
        let controller = UIAlertController(title: "菜雞", message: error, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    @IBOutlet weak var studentID: UITextField!
    
    @IBOutlet weak var studentPasswd: UITextField!
    
    @IBAction func login(_ sender: Any) {
        if let id = studentID.text , let passwd = studentPasswd.text{
            if id.isEmpty || passwd.isEmpty{
                raiseError("please enter your info")
            }
            self.login(id, passwd)
        }
        else{
            raiseError("please enter your info")
        }
    }
}

