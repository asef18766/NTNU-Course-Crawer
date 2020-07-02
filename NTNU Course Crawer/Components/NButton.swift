//
//  NButton.swift
//  NTNU Course Crawer
//
//  Created by Student on 2020/6/25.
//  Copyright © 2020 Normal OJ. All rights reserved.
//

import SwiftUI

struct NButton: View {
    var label: String
    var action: () -> () = {}
    var color: Color = .gray
    var textColor: Color = .white
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .foregroundColor(textColor)
                .font(.caption)
                .padding(.all)
        }
        .background(color)
        .cornerRadius(20)
    }
}

struct NButton_Previews: PreviewProvider {
    static var previews: some View {
        NButton(label: "Button")
    }
}
