import SwiftUI

struct CourseListView: View {
    var label: String
    @Binding var courses: [Course]
    var enableClean = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(courses, id: \.applyCode) { course in
                    NavigationLink(destination: CourseInfoView(course: course)) {
                        CourseRow(course: course)
                    }
                }
            }.navigationBarTitle(label)
            .navigationBarItems(
                trailing: Button(action: {
                    self.courses = []
                }) {
                    if enableClean {
                        Image(systemName: "plus")
                    } else {
                        EmptyView()
                    }
                })
        }
    }
}

struct CourseListView_Previews: PreviewProvider {
    @State static var courses = [Course](
        repeating: loadSampleCourse()!,
        count: 1
    )
    
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
        return CourseListView(
            label: "查詢結果",
            courses: $courses
        )
    }
}
