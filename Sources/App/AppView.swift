//
//  AppView.swift
//  
//
//  Created by 日野森 寛也（Hiroya Hinomori） on 2023/09/07.
//

import SwiftUI

public struct AppView: View {
    static let text = "Hello, World!"
    
    public init() {}
    
    public var body: some View {
        Text(Self.text)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
