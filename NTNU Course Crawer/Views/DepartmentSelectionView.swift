//
//  DepartmentSelectionView.swift
//  NTNU Course Crawer
//
//  Created by Bogay Chuang on 2020/6/26.
//  Copyright © 2020 Normal OJ. All rights reserved.
//

import SwiftUI

struct DepartmentSelectionView: View {
    @Binding var departmentIndex: Int
    @Binding var isPresented: Bool
    let departments = ["資工系", "物理系", "數學系"]
    
    var body: some View {
        VStack(alignment: .center) {
            Text("系所")
                .font(.headline)
            Picker(selection: $departmentIndex, label: EmptyView()) {
                ForEach(0..<departments.count) {
                    Text(self.departments[$0])
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

struct DepartmentSelectionView_Previews: PreviewProvider {
    @State static var idx = 0
    @State static var isPresented = true
    static var previews: some View {
        DepartmentSelectionView(departmentIndex: $idx, isPresented: $isPresented)
    }
}
