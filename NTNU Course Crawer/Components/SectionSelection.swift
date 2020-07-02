import SwiftUI

struct SectionSelection: View {
    let weekdays = ["", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat"]
    var sections = [[Section]](repeating: [Section](repeating: Section(), count: 6), count: 15)
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack(spacing: 0.0) {
                ForEach(weekdays, id: \.self) { weekday in
                    Text(weekday)
                        .frame(maxWidth: .infinity)
                }
            }
            ForEach(0..<15) { row in
                HStack(spacing: 0.0) {
                    Text("\(row + 1)")
                        .frame(maxWidth: .infinity)
                    ForEach(0..<6) { col in
                        self.sections[row][col]
                    }
                }
            }.padding(.horizontal, 0)
        }.padding(.horizontal, 5)
    }
}

struct Section: View {
    @State var selected = false
    
    var body: some View {
        Rectangle()
            .fill(selected ? Color.green : .white)
            .border(Color.black)
            .frame(maxWidth: .infinity)
            .onHover(perform: {hover in
                print(hover)
                self.selected = true
            })
            .onTapGesture {
                print("toggle")
                self.selected.toggle()
            }
    }
}

struct SectionSelection_Previews: PreviewProvider {
    static var previews: some View {
        SectionSelection()
    }
}
