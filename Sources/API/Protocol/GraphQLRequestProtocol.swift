//
//  File.swift
//  
//
//  Created by 日野森 寛也（Hiroya Hinomori） on 2023/09/07.
//

import Foundation
import APIKit

public protocol GraphQLRequestProtocol: HTTPRequestProtocol {
    var query: String { get }
}

extension GraphQLRequestProtocol {
    public var method: APIKit.HTTPMethod {
        .post
    }

    public var bodyParameters: BodyParameters? {
        JSONBodyParameters(JSONObject: ["query": query.replacingOccurrences(of: "\n", with: "")])
    }
}

