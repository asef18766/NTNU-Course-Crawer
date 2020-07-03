import SwiftUI

struct EntryView: View {
    @State var logined = true
    
    var body: some View {
        VStack {
            if logined {
                MainView()
            } else {
                LoginView(logined: $logined)
            }
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
