import SwiftUI

struct CourseListView: View {
    var label: String
    var courses: [Course]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(courses, id: \.applyCode) { course in
                    NavigationLink(destination: CourseInfoView(course: course)) {
                        CourseRow(course: course)
                    }
                }
            }.navigationBarTitle(label)
        }
    }
}

struct CourseListView_Previews: PreviewProvider {
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
        return CourseListView(
            label: "查詢結果",
            courses: [Course](
                repeating: loadSampleCourse()!,
                count: 1
            )
        )
    }
}
