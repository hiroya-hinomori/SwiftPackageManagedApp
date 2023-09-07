//
//  SessionProtocol.swift
//  
//
//  Created by 日野森 寛也（Hiroya Hinomori） on 2023/09/07.
//

import APIKit
import Foundation

public protocol SessionProtocol {
    func fetch<Request: HTTPRequestProtocol>(_ request: Request) async throws -> Request.Response
}

extension SessionProtocol {
    func send<Request>(
        _ request: Request,
        with adapter: SessionAdapter? = nil
    ) async throws -> Request.Response where Request: HTTPRequestProtocol {
        try await withCheckedThrowingContinuation { continuation in
            APIKit
                .Session(adapter: adapter ?? URLSessionAdapter(configuration: .default))
                .send(request) { response in
                    do {
                        continuation.resume(returning: try response.get())
                    } catch APIKit.SessionTaskError.responseError(let error) {
                        continuation.resume(throwing: error)
                    } catch APIKit.SessionTaskError.connectionError {
                        continuation.resume(throwing: SessionError.connectionError)
                    } catch {
                        continuation.resume(throwing: SessionError.unexpectedObject)
                    }
                }
        }
    }
}
