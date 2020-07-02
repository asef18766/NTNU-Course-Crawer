import SwiftUI

struct QueryCourseView: View {
    @State var teacherName = ""
    @State var departmentIndex = 0
    @State var domainIndex = 0
    @State var showDepartmentSelection = false
    let domains = ["一般體育科目", "一般體育科目", "一般體育科目", ]
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Text("科目類別")
                        .font(.headline)
                        .padding()
                    HStack {
                        ForEach(domains, id: \.self) {
                            NButton(label: $0)
                        }
                    }
                    .padding(.bottom)
                    HStack {
                        ForEach(domains, id: \.self) {
                            NButton(label: $0)
                        }
                    }
                    .padding(.bottom)
                }
                Button(action: {
                    self.showDepartmentSelection = true
                }) {
                    HStack() {
                        Text("開課系所")
                            .font(.headline)
                        Spacer()
                        Text(self.domains[departmentIndex])
                    }.padding()
                    .sheet(isPresented: $showDepartmentSelection) {
                            DepartmentSelectionView(departmentIndex: self.$departmentIndex, isPresented: self.$showDepartmentSelection)
                    }.foregroundColor(.black)
                }
                NLabelTextField(text: $teacherName, label: "教師姓名")
                NLabelTextField(text: $teacherName, label: "課程名稱")
                NLabelTextField(text: $teacherName, label: "開課序號")
                SectionSelection()
                HStack {
                    Spacer()
                    NButton(label: "查詢")
                }.padding(.trailing)
            }.padding(.horizontal)
        }.padding(.bottom)
    }
}

struct QueryCourseView_Previews: PreviewProvider {
    static var previews: some View {
        QueryCourseView()
    }
}
