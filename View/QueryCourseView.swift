import SwiftUI

struct QueryCourseView: View {
    @State var teacherName = ""
    @State var departmentIndex = 0
    @State var domainIndex = 0
    let domains = ["一般體育科目", "一般體育科目", "一般體育科目", ]
    let departments = ["資工系", "物理系", "數學系"]
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("科目類別")
                    .font(.headline)
                    .padding()
                HStack {
                    ForEach(domains, id: \.self) { domain in
                        NButton(label: domain)
                    }
                }
                .padding(.bottom)
                HStack {
                    ForEach(domains, id: \.self) { domain in
                        NButton(label: domain)
                    }
                }
                .padding(.bottom)
            }
            HStack() {
                Picker("系所", selection: $departmentIndex) {
                    ForEach(0..<departments.count) {
                        Text(self.departments[$0])
                    }
                }
            }
            NLabelTextField(text: $teacherName, label: "教師姓名")
            NLabelTextField(text: $teacherName, label: "課程名稱")
            NLabelTextField(text: $teacherName, label: "開課序號")
            HStack {
                Spacer()
                NButton(label: "查詢")
            }.padding(.trailing)
        }.padding(.horizontal)
    }
}

struct QueryCourseView_Previews: PreviewProvider {
    static var previews: some View {
        QueryCourseView()
    }
}
