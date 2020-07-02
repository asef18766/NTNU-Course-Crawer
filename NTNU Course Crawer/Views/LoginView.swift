import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "n.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            Text("另一個師大選課系統")
                .font(.largeTitle)
            Spacer()
            NLabelTextField(text: $username, label: "帳號")
                .padding(.horizontal)
            NLabelTextField(text: $password, label: "密碼")
                .padding([.leading, .bottom, .trailing])
            NButton(label: "登入", action: {})
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
