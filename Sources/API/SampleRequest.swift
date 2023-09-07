//
//  SampleRequest.swift
//  
//
//  Created by 日野森 寛也（Hiroya Hinomori） on 2023/09/07.
//

import APIKit
import Foundation

public struct SampleRequest: GraphQLRequestProtocol {
    public var baseURL: URL
    
    public typealias Response = Sample

    public var query: String {
        """
        query {
            sample(email: "\(email)", password: "\(password)") {
                accessToken
                refreshToken
            }
        }
        """
    }

    public var sample: Data {
        """
        {
            "accessToken": "__ACCESS_TOKEN__",
            "refreshToken": "__REFRESH_TOKEN__"
        }
        """.data(using: .utf8)!
    }

    public var path: String = "/api/backend/graphql"

    let email: String
    let password: String

    public init(baseURL: URL, email: String, password: String) {
        self.baseURL = baseURL
        self.email = email
        self.password = password
    }
}
