//
//  MainMenuViewController.swift
//  NTNU Course Crawer
//
//  Created by asef18766 on 2020/4/19.
//  Copyright © 2020 Normal OJ. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        do
        {
            let res = try DownLoadCourseSchedule("schedule.pdf")
            print("res path \(res)")
        }
        catch
        {
            print("error when downloading file")
        }
        // Do any additional setup after loading the view.
        let opts: QueryCourseListOptions = QueryCourseListOptions(serialNo: "", chnName: "", teacher: "")
        print("try to query")
        let c = QueryCourseList(opts: opts)
        print("end query")
        print("course : \(c.count)")
        
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
