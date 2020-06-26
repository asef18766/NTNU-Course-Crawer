//
//  LoginModel.swift
//  NTNU Course Crawer
//
//  Created by asef18766 on 2020/4/10.
//  Copyright © 2020 Normal OJ. All rights reserved.
//

import Foundation

enum NetworkErrors:Error
{
    case SecondLoginError
}
extension String {

    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
        .urlQueryAllowed)
        return encodeUrlString ?? ""
    }

    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}
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
            if let d = data
            {
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
func getRandImage()
{
    print("try to getRandImage")
    let semaphore = DispatchSemaphore(value: 0)
    let url = URL(string: "http://cos3.ntnu.edu.tw/AasEnrollStudent/RandImage")
    var request : URLRequest = URLRequest(url: url!)
    request.httpMethod = "GET"
    let dataTask = URLSession.shared.dataTask(with: request)
    {
        data,response,error in
        semaphore.signal()
    }
    dataTask.resume()
    semaphore.wait()
}
func getImageBox()->String{
    print("try to getImageBox")
    let semaphore = DispatchSemaphore(value: 0)
    let url = URL(string: "http://cos3.ntnu.edu.tw/AasEnrollStudent/ImageBoxFromIndexCtrl")
    var authCode = ""
    var request : URLRequest = URLRequest(url: url!)
    request.httpMethod = "GET"
    let dataTask = URLSession.shared.dataTask(with: request)
    {
        data,response,error in
        if let d = data
        {
            let str = String(data: d, encoding: .utf8)!
            print("raw auth code:\(str)")
            
            if str.count != 25
            {
                authCode = ""
            }
            else if let range = str.range(of: "msg:\"")
            {
                let fi = str.index(range.upperBound , offsetBy: 0)
                let ei = str.index(range.upperBound , offsetBy: 4)
                authCode = String(str[fi ..< ei])
            }
        }
        semaphore.signal()
    }
    dataTask.resume()
    semaphore.wait()
    return authCode
}
func login(_ username:String, _ passwd:String)->Bool
{
    let token = getToken()
    getRandImage()
    let auth = getImageBox()
    
    let semaphore = DispatchSemaphore(value: 0)
    var result = ""
    let url = URL(string: "http://cos3.ntnu.edu.tw/AasEnrollStudent/LoginCheckCtrl?action=login&id=\(token)")
    var request : URLRequest = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.httpBody = "userid=\(username)&password=\(passwd)&validateCode=\(auth)&checkTW=1".data(using: .utf8)
    let dataTask = URLSession.shared.dataTask(with: request)
    {
        data,response,error in
        if let d = data
        {
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
internal func getSecondLoginData()->(String)
{
    let url = URL(string: "http://cos3.ntnu.edu.tw/AasEnrollStudent/IndexCtrl?language=TW")
    let request : URLRequest = URLRequest(url: url!)
    let semaphore = DispatchSemaphore(value: 0)
    var result = ""

    let dataTask = URLSession.shared.dataTask(with: request)
    {
        data,response,error in
        if let d = data
        {
            result = String(data: d , encoding: .utf8)!
        }
        semaphore.signal()
    }
    dataTask.resume()
    semaphore.wait()

    let targetStID = "fieldLabel: '姓名'"
    if let range = result.range(of: targetStID)
    {
        let fi = result.index(range.upperBound , offsetBy: 0)
        let ei = result.index(range.upperBound , offsetBy: 400)

        let str = String(result[fi ..< ei]).filter { !$0.isNewline && !$0.isWhitespace }
        print("raw truncation:")
        print(str)
        if let h = str.range(of: "value:'") , let e = str.range(of: "'},")
        {
            let hi = str.index(h.upperBound , offsetBy: 0)
            let ei = str.index(e.lowerBound , offsetBy: 0)
            let s = String(str[hi ..< ei])
            print("name:")
            print(s)
            return s
        }
    }
    return ""
}
func secondLogin(_ stdID : String) throws
{
    let name = getSecondLoginData()
    if(name == "")
    {
        throw NetworkErrors.SecondLoginError
    }
    let url = URL(string: "http://cos3.ntnu.edu.tw/AasEnrollStudent/LoginCtrl")
    var request : URLRequest = URLRequest(url: url!)
    let semaphore = DispatchSemaphore(value: 0)
    request.httpMethod = "POST"
    request.httpBody = "userid=\(stdID.uppercased())&stdName=\(name.urlEncoded())&checkTW=1".data(using: .utf8)
    var result = ""
    let dataTask = URLSession.shared.dataTask(with: request)
    {
        data,response,error in
        if let d = data
        {
            result = String(data: d , encoding: .utf8)!
        }
        semaphore.signal()
    }
    dataTask.resume()
    semaphore.wait()

    if(result == "{success:true,msg:\"ok\"}")
    {
        print("login success")
    }
    else
    {
        print("got second login msg: \(result)")
        throw  NetworkErrors.SecondLoginError
    }
    
    _ = SendRequest(queryUrl: "http://cos3.ntnu.edu.tw/AasEnrollStudent/EnrollCtrl?action=go", method: "GET", body: "")
    _ = SendRequest(queryUrl: "http://cos3.ntnu.edu.tw/AasEnrollStudent/StfseldListCtrl", method: "GET", body: "")
    
}
