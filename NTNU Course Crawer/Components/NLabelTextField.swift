import SwiftUI

struct NLabelTextField: View {
    @Binding var text: String
    var label: String = ""
    var placeholder: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            TextField(placeholder, text: $text)
                .padding(.all)
                .background(Color.gray)
                .cornerRadius(10)
        }
        .padding(.horizontal, 15)
    
    }
}

struct NLabelTextField_Previews: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        NLabelTextField(
            text: $text,
            label: "Label",
            placeholder: "Placeholder"
        )
    }
}
