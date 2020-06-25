//
//  QueryModel.swift
//  NTNU Course Crawer
//
//  Created by Student on 2020/6/24.
//  Copyright © 2020 Normal OJ. All rights reserved.
//

import Foundation

struct QueryCourseListOptions
{
    var serialNo:String
    {
        didSet
        {
            chnName = ""
            teacher = ""
        }
    }
    var chnName :String
    {
        didSet
        {
            serialNo = ""
        }
    }
    var teacher :String
    {
        didSet
        {
            serialNo = ""
        }
    }
    
    var deptCode:String = "GU"
    var formS: String = ""
    var class1: String = ""
    var generalCore:String = ""
    var notFull: Int = 0
    var courseCode: String = ""
    
    /*
     
     note:
     first subscript indicate the day (range 1~6)
     second subscript indicste the section (range 0~14)
     
     */
    var checkWkSection:[[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 16), count: 7)
    
    let action = "showGrid"
    let actionButton = "query"
    let page  = 1
    let start = 0
    let limit = 999999
    
    func URLEncoded()->String
    {
        var urlComponents = URLComponents()
        urlComponents.queryItems =
        [
            URLQueryItem(name: "serialNo", value: serialNo),
            URLQueryItem(name: "chnName", value: chnName),
            URLQueryItem(name: "teacher", value: teacher),
            
            URLQueryItem(name: "deptCode", value: deptCode),
            URLQueryItem(name: "formS", value: formS),
            URLQueryItem(name: "class1", value: class1),
            URLQueryItem(name: "generalCore", value: generalCore),
            URLQueryItem(name: "notFull", value: String(notFull)),
            URLQueryItem(name: "courseCode", value: courseCode),
            
            URLQueryItem(name: "action", value: action),
            URLQueryItem(name: "actionButton", value: actionButton),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "start", value: String(start)),
            URLQueryItem(name: "courseCode", value: String(courseCode)),
            URLQueryItem(name: "limit", value: String(limit)),
        ]
        for day in 1...6
        {
            for section in 0...14
            {
                urlComponents.queryItems?.append(URLQueryItem(name: "checkWkSection\(day)\(section)", value: String(checkWkSection[day][section]) ))
            }
        }
        print("url is \(urlComponents.url?.query ?? "")")
        return urlComponents.url?.query ?? ""
    }
}

internal struct RawCourseQueryResult : Codable
{
    let Count : Int
    let List : [Course]
}
struct Course : Codable
{
    var acadmTerm: String
    var acadmYear: String
    var applyCode: String
    var authorizeP: Int
    var chnName: String
    var class1: String
    var courseCode: String
    var courseGroup: String
    var courseKind: String
    var credit: String
    var deptCode: String
    var deptGroup: String
    var domain: String
    var engName: String
    var engTeach: String
    var formS: String
    var insDeptCode: String
    var limitCountH: Int
    var moocs: String
    var optionCode: String
    var serialNo: String
    var sex_restrict: String
    var summerPhase: String
    var teacher: String
    var timeInfo: String
    var v_chn_name: String
    var v_class1: String
    var v_comment: String
    var v_deptChiabbr: String
    var v_deptGroup: String
    var v_error: String
    var v_is_Full: String
    var v_limitCourse: String
    var v_phase: String
    var v_priority: Int
    var v_release_time: String
    var v_reserve_count: Int
    var v_stage: Int
    var v_stfseld: Int
    var v_stfseld_auth: Int
    var v_stfseld_deal: Int
    var v_stfseld_exchange: Int
    var v_stfseld_undeal: Int
    var v_stfseld_unfull: Int
}

internal func SendRequest(queryUrl:String , method:String , body:String) -> Data?
{
    let semaphore = DispatchSemaphore(value: 0)
    var result: Data?
    let url = URL(string: queryUrl)
    var request : URLRequest = URLRequest(url: url!)
    request.httpMethod = method
    request.httpBody = body.data(using: .utf8)
    
    let dataTask = URLSession.shared.dataTask(with: request)
    {
        data,response,error in
        result = data
        semaphore.signal()
    }
    dataTask.resume()
    semaphore.wait()
    return result
}
func QueryCoursePrerequisite()
{
    _ = SendRequest(queryUrl: "http://cos3.ntnu.edu.tw/AasEnrollStudent/CourseQueryCtrl?action=query", method: "GET", body: "")
    _ = SendRequest(queryUrl: "http://cos3.ntnu.edu.tw/AasEnrollStudent/CourseQueryCtrl?action=showGrid", method: "POST", body: "")
}

// submit an query for avaible course , must execute QueryCoursePrerequisite
func QueryCourseList(opts:QueryCourseListOptions)->[Course]
{
    let queryUrl = "http://cos3.ntnu.edu.tw/AasEnrollStudent/CourseQueryCtrl?action=showGrid"
    
    if let rawData = SendRequest(queryUrl: queryUrl, method: "POST", body: opts.URLEncoded())
    {
        let decoder = JSONDecoder()
        if let d = try? decoder.decode(RawCourseQueryResult.self, from: rawData)
        {
            return d.List
        }
    }
    return []
}

// function that must excute when end query course
func ExitQueryCourseList()
{
    _ = SendRequest(queryUrl: "http://cos3.ntnu.edu.tw/AasEnrollStudent/StfseldListCtrl", method: "GET", body: "")
}
