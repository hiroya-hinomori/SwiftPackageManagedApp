//
//  SampleRequestTests.swift
//  
//
//  Created by 日野森 寛也（Hiroya Hinomori） on 2023/09/07.
//

import XCTest
@testable import API

final class SampleRequestTests: XCTestCase {

    func testExample() async throws {
        let request = SampleRequest(
            baseURL: .init(string: "http://localhost")!,
            email: "hoge@hoge.com",
            password: "passw0RD"
        )
        
        let session = StubSession()
        let result = try await session.fetch(request)
        XCTAssertEqual(result.accessToken, "__ACCESS_TOKEN__")
        XCTAssertEqual(result.refreshToken, "__REFRESH_TOKEN__")
    }

}
