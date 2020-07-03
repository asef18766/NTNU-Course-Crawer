import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            QueryCourseView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("列表")
                }
            QueryCourseView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("查詢")
                }
            QueryCourseView()
                .tabItem {
                    Image(systemName: "star")
                    Text("最愛")
                }
            QueryCourseView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("設定")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
