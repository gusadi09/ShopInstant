//
//  PrimaryButton.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 05/09/24.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    var height: CGFloat = 45
    var bgColor: Color = .blue
    var textColor: Color = .white
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            
            configuration.label
                .foregroundStyle(textColor)
                .font(.system(size: 14, weight: .bold))
            
            Spacer()
        }
        .padding(.vertical, 5)
        .frame(height: height)
        .background(
            bgColor
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .scaleEffect(configuration.isPressed ? 1.2 : 1)
        .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    Button(action: {
        print("pressed")
    }, label: {
        Text("Submit")
    })
    .buttonStyle(PrimaryButton(height: 56, bgColor: .black, textColor: .orange))
    .padding()
}
