//
//  ContentView.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 03/09/24.
//

import SwiftUI

struct MainContainerView: View {
    
    @StateObject var viewModel = MainContainerViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(LocalizableString.General.helloWorld)
        }
        .padding()
    }
}

#Preview {
    MainContainerView()
}
