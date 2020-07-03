import SwiftUI

struct LoginView: View {
    @Binding var logined: Bool
    @State var username = ""
    @State var password = ""
    @State var loginFail = false
    
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
                .frame(maxWidth: 500)
            NLabelTextField(text: $password, label: "密碼")
                .padding()
                .frame(maxWidth: 500)
            NButton(label: "登入", action: {
                if login(self.username, self.password) {
                    self.logined = true
                } else {
                    self.loginFail = true
                }
            }).padding(.bottom, 5)
            HStack(spacing: 0.0) {
                Text("還沒有帳號嗎？建議你可以先考上")
                Text("師大")
                    .underline()
                    .foregroundColor(.blue)
                    .onTapGesture {
                        let url = URL(string: "https://www.ntnu.edu.tw")
                        UIApplication.shared.open(url!)
                    }
            }
            if(loginFail) {
                Text("登入失敗！")
                    .font(.headline)
                    .foregroundColor(.red)
            }
            Spacer()
        }.padding()
        .keyboardAdaptive()
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var logined = false
    static var previews: some View {
        return LoginView(logined: $logined)
    }
}
