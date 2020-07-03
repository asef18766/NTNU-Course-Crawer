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
            }else{
                NTNU_Course_Crawer.login(id, passwd)
            }
        }
        else{
            raiseError("please enter your info")
        }
    }
}

