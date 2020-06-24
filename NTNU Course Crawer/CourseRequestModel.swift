//
// Created by asef18766 on 2020/4/19.
// Copyright (c) 2020 Normal OJ. All rights reserved.
//

import Foundation

func NetworkRequest(_ urlSrc:String , _ method:String = "GET" , _ body:String = "")->String
{
    let url = URL(string: urlSrc)
    var request : URLRequest = URLRequest(url: url!)
    let semaphore = DispatchSemaphore(value: 0)
    request.httpMethod = method
    request.httpBody = body.data(using: .utf8)
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
    return result
}
struct CourseObject : Codable
{
    let abnScore:String
    let acadmTerm:String
    let acadmYear:String
    let applyCode:String
    let authorizeCode:String
    let chnName:String
    let class1:String
    let courseCode:String
    let courseGroup:String
    let courseKind:String
    let deptCode:String
    let deptGroup:String
    let domain:String
    let formS:String
    let moeCredit:Int
    let normalScore:String
    let optionCode:String
    let phase:Int
    let priority:Int
    let stage:Int
    let stdNo:String
    let stdNoOthSchl:String
    let summerPhase:String
    let v_CHN_NAME:String
    let v_ENG_NAME:String
    let v_ROOM_NAME:String
    let v_SECTION:String
    let v_WEEK_NO:String
    let v_class1:String
    let v_comment:String
    let v_deptChiabbr:String
    let v_deptChiabbr988:String
    let v_deptGroup:String
    let v_domain:String
    let v_engTeach:String
    let v_limitCountH:Int
    let v_limitCourse:String
    let v_moocs:String
    let v_normalScore:String
    let v_phase:String
    let v_priority:String
    let v_serialNo:String
    let v_stage:String
    let v_stdChnName:String
    let v_teacher:String
    let v_timeInfo:String
    let v_totalCredit:String
}
struct RawCourseQuery : Codable
{
    let Count:Int
    let List:[CourseObject]
}
func QueryCurrentCourse() -> RawCourseQuery?
{
    let qResult = NetworkRequest("http://cos3.ntnu.edu.tw/AasEnrollStudent/StfseldListCtrl?action=showGrid&page=1&start=0")
    let decoder = JSONDecoder()
    do
    {
         let result = try decoder.decode(RawCourseQuery.self, from: qResult.data(using: .utf8)!)
        return result
    }
    catch
    {
        return nil
    }
}
