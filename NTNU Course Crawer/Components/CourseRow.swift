import SwiftUI

struct CourseRow: View {
    var course: Course
    
    var body: some View {
        VStack {
            HStack {
                Text("\(course.courseCode) \(course.chnName)")
                Spacer()
                Text("\(course.v_stfseld_auth) / \(course.v_reserve_count)")
            }
            HStack {
                Text(course.v_deptChiabbr)
                    .padding(.trailing, 10)
                Text(course.teacher)
                Spacer()
            }
            HStack {
                Text(course.timeInfo)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.black)
                        .frame(width: 20, height: 20)
                }
            }
        }
    }
}

struct CourseRow_Previews: PreviewProvider {
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
        
        return CourseRow(course: loadSampleCourse()!)
    }
}
