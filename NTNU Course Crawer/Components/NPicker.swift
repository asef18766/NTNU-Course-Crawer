import SwiftUI

struct NPicker: View {
    @Binding var isPresented: Bool
    @Binding var choiceIndex: Int
    let choices: [String]
    let label: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(label)
                .font(.headline)
            Picker(
                selection: $choiceIndex,
                label: EmptyView()
            ) {
                ForEach(0..<choices.count) {
                    Text(self.choices[$0])
                }
            }.labelsHidden()
                .frame(height: 100)
                .clipped()
            HStack {
                Spacer()
                NButton(label: "確定", action: {
                    self.isPresented = false
                })
            }.padding(.horizontal)
        }.padding(.horizontal)
    }
}

struct NPicker_Previews: PreviewProvider {
    @State static var idx = 0
    @State static var isPresented = true
    static var previews: some View {
        NPicker(
            isPresented: $isPresented,
            choiceIndex: $idx,
            choices: ["資工系", "物理系", "數學系"],
            label: "系所"
        )
    }
}
