//
//  ContentView.swift
//  
//
//  Created by 日野森 寛也（Hiroya Hinomori） on 2023/09/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("face", bundle: .module)
                .resizable()
                .scaledToFit()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
