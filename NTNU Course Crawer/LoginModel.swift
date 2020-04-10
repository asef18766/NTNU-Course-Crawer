//
//  LoginModel.swift
//  NTNU Course Crawer
//
//  Created by asef18766 on 2020/4/10.
//  Copyright © 2020 Normal OJ. All rights reserved.
//

import Foundation

func getToken()->String{
    print("try to login")
    let semaphore = DispatchSemaphore(value: 0)
    let url = URL(string: "http://cos3.ntnu.edu.tw/AasEnrollStudent/LoginCheckCtrl")
    var request : URLRequest = URLRequest(url: url!)
    request.httpMethod = "GET"
    var xssToken = ""
    let dataTask = URLSession.shared.dataTask(with: request) {
        data,response,error in
        print("anything")
        do {
            if let d = data{
                let str = String(data: d, encoding: .utf8)!
                let tokenStr = "url:'LoginCheckCtrl?action=login&id=' + '"
                if let range = str.range(of: tokenStr) {
                    let fi = str.index(range.upperBound , offsetBy: 0)
                    let ei = str.index(range.upperBound , offsetBy: 14)
                    xssToken = String(str[fi ..< ei])
                    
                    if(xssToken.last! == ",")
                    {
                        _ = xssToken.popLast()
                    }
                    if(xssToken.last! == "'")
                    {
                        _ = xssToken.popLast()
                    }
                    print("here xssToken: \(xssToken)")
                }
                else {
                  print("String not present")
                }
            }
        }
        semaphore.signal()
    }
    dataTask.resume()
    semaphore.wait()
    return xssToken
}
func getRandImage(){
    print("try to getRandImage")
    let semaphore = DispatchSemaphore(value: 0)
    let url = URL(string: "http://cos3.ntnu.edu.tw/AasEnrollStudent/RandImage")
    var request : URLRequest = URLRequest(url: url!)
    request.httpMethod = "GET"
    let dataTask = URLSession.shared.dataTask(with: request){
        data,response,error in
        semaphore.signal()
    }
    dataTask.resume()
    semaphore.wait()
}
func getImagebox()->String{
    print("try to getImagebox")
    let semaphore = DispatchSemaphore(value: 0)
    let url = URL(string: "http://cos3.ntnu.edu.tw/AasEnrollStudent/ImageBoxFromIndexCtrl")
    var authcode = ""
    var request : URLRequest = URLRequest(url: url!)
    request.httpMethod = "GET"
    let dataTask = URLSession.shared.dataTask(with: request) {
        data,response,error in
        if let d = data{
            let str = String(data: d, encoding: .utf8)!
            print("raw auth code:\(str)")
            
            if str.count != 25{
                authcode = ""
            }
            else if let range = str.range(of: "msg:\"") {
                let fi = str.index(range.upperBound , offsetBy: 0)
                let ei = str.index(range.upperBound , offsetBy: 4)
                authcode = String(str[fi ..< ei])
            }
        }
        semaphore.signal()
    }
    dataTask.resume()
    semaphore.wait()
    return authcode
}
func login(_ username:String, _ passwd:String)->Bool{
    let token = getToken()
    getRandImage()
    let auth = getImagebox()
    
    let semaphore = DispatchSemaphore(value: 0)
    var result = ""
    let url = URL(string: "http://cos3.ntnu.edu.tw/AasEnrollStudent/LoginCheckCtrl?action=login&id=\(token)")
    var request : URLRequest = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.httpBody = "userid=\(username)&password=\(passwd)&validateCode=\(auth)&checkTW=1".data(using: .utf8)
    let dataTask = URLSession.shared.dataTask(with: request) {
        data,response,error in
        if let d = data{
            result = String(data: d , encoding: .utf8)!
            print("raw result:\(result)")
        }
        semaphore.signal()
    }
    dataTask.resume()
    semaphore.wait()
    
    let checkerString = "success:true"
    if let _ = result.range(of: checkerString)
    {
        print("return true")
        return true
    }
    print("return false")
    return false
}
