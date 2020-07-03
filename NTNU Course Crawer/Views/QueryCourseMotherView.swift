import SwiftUI

struct QueryCourseMotherView: View {
    @State var courses: [Course] = []
    
    var body: some View {
        Group {
            if courses.count != 0 {
                CourseListView(
                    label: "查詢結果",
                    courses: $courses,
                    enableClean: true
                )
            } else {
                QueryCourseView(queryResults: $courses)
            }
        }
    }
}

struct QueryCourseMotherView_Previews: PreviewProvider {
    static var previews: some View {
        QueryCourseMotherView()
    }
}
