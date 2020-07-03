import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            EmptyView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("列表")
                }
            QueryCourseMotherView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("查詢")
                }
            QueryCourseMotherView()
                .tabItem {
                    Image(systemName: "star")
                    Text("最愛")
                }
            QueryCourseMotherView()
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
