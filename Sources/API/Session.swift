//
//  Session.swift
//  
//
//  Created by 日野森 寛也（Hiroya Hinomori） on 2023/09/07.
//

import APIKit
import Foundation

public enum Session {
    public static var stub: SessionProtocol {
        StubSession()
    }
}

struct StubSession: SessionProtocol {
    struct Adapter: SessionAdapter {
        let data: Data?
        let error: Error?

        func createTask(
            with URLRequest: URLRequest,
            handler: @escaping (Data?, URLResponse?, Error?) -> Void
        ) -> APIKit.SessionTask {
            handler(
                error == nil ? data : nil,
                HTTPURLResponse(),
                error
            )
            class Task: SessionTask {
                func resume() {}
                func cancel() {}
            }
            return Task()
        }

        func getTasks(with handler: @escaping ([APIKit.SessionTask]) -> Void) { }
    }

    var error: Error?

    func fetch<Request>(_ request: Request) async throws -> Request.Response where Request: HTTPRequestProtocol {
        try? await Task.sleep(nanoseconds: UInt64(0.5) * 1_000_000_000)
        return try await send(request, with: Adapter(data: request.sample, error: error))
    }
}
