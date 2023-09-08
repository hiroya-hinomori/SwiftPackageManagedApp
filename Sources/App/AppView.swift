//
//  AppView.swift
//  
//
//  Created by 日野森 寛也（Hiroya Hinomori） on 2023/09/07.
//

import SwiftUI
import API

class Ancher {}

public struct AppView: View {
    static let text = "Hello, World!"
    @State var accessToken: String?
    @State var refreshToken: String?
    @State var error: Error?
    let session: SessionProtocol
    
    public init(session: SessionProtocol = Session.stub) {
        self.session = session
    }
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Text(Self.text)
                Text(accessToken ?? "")
                Text(refreshToken ?? "")
                NavigationLink("Next") {
                    ContentView()
                }
            }
        }
        .task {
            do {
                let request = SampleRequest(
                    baseURL: .init(string: "https://example.com")!,
                    email: "test@example.com",
                    password: "password"
                )
                let result = try await session.fetch(request)
                accessToken = result.accessToken
                refreshToken = result.refreshToken
            } catch {
                self.error = error
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(session: Session.stub)
    }
}
