import SwiftUI

struct CourseInfoView: View {
    var course: Course
    let infoList = [
        ("開課代碼", \Course.courseCode),
        ("開課單位", \Course.v_deptChiabbr),
        ("教師", \Course.teacher),
        ("時間地點", \Course.timeInfo)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("[\(course.applyCode)] \(course.chnName)")
                .font(.title)
                .padding(.bottom)
            ForEach(infoList, id: \.0) { info in
                HStack {
                    Text(info.0)
                    Spacer()
                    Text("\(self.course[keyPath: info.1])")
                }
                .padding(.trailing, 20)
                .padding(.bottom, 5)
            }
            Text("備註")
                .padding(.top)
                .padding(.bottom, 5)
            Text(course.v_comment)
            Spacer()
        }.padding()
    }
}

struct CourseInfoView_Previews: PreviewProvider {
    static func loadSampleCourse() -> Course? {
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
    
    static var previews: some View {
        CourseInfoView(course: loadSampleCourse()!)
    }
}
