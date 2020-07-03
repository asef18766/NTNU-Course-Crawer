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
    @Binding var queryResults: [Course]
    @State var teacherName = ""
    @State var courseName = ""
    @State var courseCode = ""
    @State var domainIndex = 0
    @State var departmentIndex = 0
    @State var showDepartmentSelection = false
    @State var generalCoreIndex = 0
    @State var showGeneralCoreSelection = false
    @State var showError = false
    var sectionSelection = SectionSelection()
    
    let departments = [
        ("通識", "GU"),
        ("共同科", "CU"),
        ("師培學院", "EU"),
        ("普通體育", "PE"),
        ("全人中心", "VS"),
        ("教育學院", "E"),
        ("教育系", "EU00"),
        ("教育碩", "EM00"),
        ("教育博", "ED00"),
        ("心輔系", "EU01"),
        ("心輔碩", "EM01"),
        ("心輔博", "ED01"),
        ("心輔輔", "SA01"),
        ("社教系", "EU02"),
        ("社教碩", "EM02"),
        ("社教博", "ED02"),
        ("衛教系", "EU05"),
        ("衛教碩", "EM05"),
        ("衛教博", "ED05"),
        ("人發系", "EU06"),
        ("人發碩", "EM06"),
        ("人發博", "ED06"),
        ("公領系", "EU07"),
        ("公領碩", "EM07"),
        ("公領博", "ED07"),
        ("資訊碩", "EM08"),
        ("資訊博", "ED08"),
        ("特教系", "EU09"),
        ("特教碩", "EM09"),
        ("特教博", "ED09"),
        ("學習科學學位學程", "EU11"),
        ("圖資碩", "EM15"),
        ("圖資博", "ED15"),
        ("教政碩", "EM16"),
        ("復諮碩", "EM17"),
        ("教院不分系", "EU13"),
        ("課教碩", "EM03"),
        ("課教博", "ED03"),
        ("文學院", "L"),
        ("國文系", "LU20"),
        ("國文碩", "LM20"),
        ("英語系", "LU21"),
        ("英語碩", "LM21"),
        ("英語博", "LD21"),
        ("英語輔", "SA21"),
        ("歷史系", "LU22"),
        ("歷史碩", "LM22"),
        ("地理系", "LU23"),
        ("地理碩", "LM23"),
        ("地理博", "LD23"),
        ("翻譯碩", "LM25"),
        ("翻譯博", "LD25"),
        ("臺文系", "LU26"),
        ("臺文碩", "LM26"),
        ("臺文博", "LD26"),
        ("臺史碩", "LM27"),
        ("數學系", "SU40"),
        ("數學碩", "SM40"),
        ("數學博", "SD40"),
        ("物理系", "SU41"),
        ("物理碩", "SM41"),
        ("化學系", "SU42"),
        ("化學碩", "SM42"),
        ("化學博", "SD42"),
        ("生科系", "SU43"),
        ("生科碩", "SM43"),
        ("生科博", "SD43"),
        ("地科系", "SU44"),
        ("地科碩", "SM44"),
        ("地科博", "SD44"),
        ("科教碩", "SM45"),
        ("科教博", "SD45"),
        ("環教碩", "SM46"),
        ("環教博", "SD46"),
        ("資工系", "SU47"),
        ("資工碩", "SM47"),
        ("生物多樣學位學程", "SD50"),
        ("營養科學學位學程", "SU51"),
        ("營養碩", "SM51"),
        ("生醫碩", "SM52"),
        ("藝術學院", "T"),
        ("美術系", "TU60"),
        ("美術碩", "TM60"),
        ("美術博", "TD60"),
        ("藝史碩", "TM67"),
        ("設計系", "TU68"),
        ("設計碩", "TM68"),
        ("設計博", "TD68"),
        ("工教系", "HU70"),
        ("工教碩", "HM70"),
        ("工教博", "HD70"),
        ("科技系", "HU71"),
        ("科技碩", "HM71"),
        ("科技博", "HD71"),
        ("圖傳系", "HU72"),
        ("圖傳碩", "HM72"),
        ("機電系", "HU73"),
        ("機電碩", "HM73"),
        ("機電博", "HD73"),
        ("電機系", "HU75"),
        ("電機碩", "HM75"),
        ("車能學位學程", "HU76"),
        ("光電工程學位學程", "HU77"),
        ("光電碩", "HM77"),
        ("運休學院", "A"),
        ("體育系", "AU30"),
        ("體育碩", "AM30"),
        ("體育博", "AD30"),
        ("休旅碩", "AM31"),
        ("休旅博", "AD31"),
        ("競技系", "AU32"),
        ("競技碩", "AM32"),
        ("國社學院", "I"),
        ("歐文碩", "IM82"),
        ("東亞系", "IU83"),
        ("東亞碩", "IM83"),
        ("東亞博", "ID83"),
        ("華語系", "IU84"),
        ("華語碩", "IM84"),
        ("華語博", "ID84"),
        ("人資碩", "IM86"),
        ("政治碩", "IM87"),
        ("大傳碩", "IM88"),
        ("社工碩", "IM89"),
        ("音樂系", "MU90"),
        ("音樂碩", "MM90"),
        ("音樂博", "MD90"),
        ("民音碩", "MM91"),
        ("表演學位學程", "MU92"),
        ("表演碩", "MM92"),
        ("管理碩", "OM55"),
        ("全營碩", "OM56"),
        ("企管系", "OU57"),
        ("中英翻譯學程", "ZU65"),
        ("戶外探索領導學程", "ZU66"),
        ("科學計算學程", "ZU67"),
        ("太陽能源與工程學程", "ZU68"),
        ("文物保存修復學分學程", "ZU69"),
        ("學習與資訊學程", "ZU71"),
        ("數位人文與藝術學程", "ZU72"),
        ("運動傷害防護學程", "ZU73"),
        ("國際教師學程-華語文", "ZU74"),
        ("國際教師學程-數學", "ZU75"),
        ("國際教師學程-物理", "ZU76"),
        ("資訊科技應用學程", "ZU77"),
        ("人工智慧技術與應用學", "ZU78"),
        ("PASSION偏鄉教育學程", "ZU79"),
        ("基礎管理學程", "ZU83"),
        ("財金學程", "ZU84"),
        ("環境監測學程", "ZU89"),
        ("榮譽英語學程", "ZU92"),
        ("歐洲文化學程", "ZU93"),
        ("文學創作學程", "ZU94"),
        ("日語學程", "ZU97"),
        ("高齡學程", "ZU98"),
        ("區域學程", "ZU9A"),
        ("空間學程", "ZU9B"),
        ("學校心理學學程", "ZU9C"),
        ("社會與傳播學程", "ZU9E"),
        ("大數據學程", "ZU9K"),
        ("室內設計學程", "ZU9O"),
        ("韓語學程", "ZU9P"),
        ("社團領導學程", "ZU9Q"),
        ("國際文化學程", "ZU9R"),
        ("原民教育學程", "ZU9U"),
        ("大師創業學程", "ZU9V"),
        ("金牌書院", "ZU9W"),
        ("哲學學程", "ZU9X"),
        ("藝術產業學程", "ZU9Y"),
        ("國際教師學程-國際", "ZU9Z")
    ]
    let generalCores = [
        ("所有通識", "all"),
        ("語言與文學", "00UG"),
        ("藝術與美感", "01 UG"),
        ("哲學思維與道德推理", "02UG"),
        ("公民素養與社會探究", "03UG"),
        ("歷史與文化", "04UG"),
        ("數學與邏輯思維", "05UG"),
        ("科學與生命", "06UG"),
        ("第二外語", "07UG"),
        ("生活技能", "08UG"),
        ("自主學習", "09UG"),
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                NPickerButton(
                    isPresented: showDepartmentSelection,
                    choiceIndex: departmentIndex,
                    choices: departments.map(\.self.0),
                    label: "系所"
                )
                NLabelTextField(text: $teacherName, label: "教師姓名")
                NLabelTextField(text: $courseName, label: "課程名稱")
                NLabelTextField(text: $courseCode, label: "開課序號")
                if self.departmentIndex == 0 {
                    NPickerButton(
                        isPresented: showGeneralCoreSelection,
                        choiceIndex: generalCoreIndex,
                        choices: generalCores.map(\.self.0),
                        label: "通識核心領域"
                    )
                }
                sectionSelection
                HStack {
                    Spacer()
                    NButton(label: "查詢", action: {
                        print("query")
                        // simple query options
                        var opts = QueryCourseListOptions(
                            serialNo: "",
                            chnName: self.courseName,
                            teacher: self.teacherName
                        )
                        // cast Bool to Int
                        opts.checkWkSection = self.sectionSelection.selections.map { row in
                            row.map { cell in
                                cell ? 1 : 0
                            }
                        }
                        // convert department to code
                        opts.deptCode = self.departments[self.departmentIndex].1
                        // general core
                        if self.departmentIndex == 0 {
                            opts.generalCore = self.generalCores[self.generalCoreIndex].1
                        }
                        let courses = QueryCourseList(opts: opts)
                        print("\(courses.map(\.courseCode))")
                        if courses.count != 0 {
                            self.showError = false
                            self.queryResults = courses
                        } else {
                            self.showError = true
                        }
                    })
                }.padding(.trailing)
                if showError {
                    Text("查無課程資料，請重新輸入參數！")
                }
            }.padding(.horizontal)
        }.padding(.bottom)
    }
}

struct QueryCourseView_Previews: PreviewProvider {
    @State static var courses: [Course] = []
    static var previews: some View {
        QueryCourseView(queryResults: $courses)
    }
}
