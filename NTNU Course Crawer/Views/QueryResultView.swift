//
//  QueryResultView.swift
//  NTNU Course Crawer
//
//  Created by Bogay Chuang on 2020/7/2.
//  Copyright © 2020 Normal OJ. All rights reserved.
//

import SwiftUI

struct QueryResultView: View {
    var courses: [Course]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(courses, id: \.applyCode) { course in
                    NavigationLink(destination: CourseInfoView(course: course)) {
                        CourseRow(course: course)
                    }
                }
            }.navigationBarTitle("查詢結果")
        }
    }
}

struct QueryResultView_Previews: PreviewProvider {
    static var previews: some View {
        func loadSampleCourse() -> Course? {
            if let path = Bundle.main.path(forResource: "sampleCourse", ofType: "json") {
                do {
                      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let course = try? JSONDecoder().decode(Course.self, from: data)
                    return course
                  } catch {
                       print("Can not read sample course data!")
                  }
            }
            return nil
        }
        return QueryResultView(courses: [Course](repeating:  loadSampleCourse()!, count: 1))
    }
}
