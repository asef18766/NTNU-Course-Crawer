import SwiftUI

struct NPickerButton: View {
    @State var isPresented: Bool
    @State var choiceIndex: Int
    let choices: [String]
    let label: String
    
    var body: some View {
        Button(action: {
            self.isPresented = true
        }) {
            HStack() {
                Text(label)
                    .font(.headline)
                Spacer()
                Text(choices[choiceIndex])
            }.padding()
            .sheet(isPresented: $isPresented) {
                NPicker(
                    isPresented: self.$isPresented,
                    choiceIndex: self.$choiceIndex,
                    choices: self.choices,
                    label: self.label
                )
            }.foregroundColor(.black)
        }
    }
}

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
                NPickerButton(
                    isPresented: showDepartmentSelection,
                    choiceIndex: departmentIndex,
                    choices: ["資工系", "物理系", "數學系"],
                    label: "系所"
                )
                NLabelTextField(text: $teacherName, label: "教師姓名")
                NLabelTextField(text: $teacherName, label: "課程名稱")
                NLabelTextField(text: $teacherName, label: "開課序號")
                NPickerButton(
                    isPresented: showDepartmentSelection,
                    choiceIndex: departmentIndex,
                    choices: ["資工系", "物理系", "數學系"],
                    label: "通識核心領域"
                )
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
