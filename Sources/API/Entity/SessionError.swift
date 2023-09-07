//
//  SessionError.swift
//  
//
//  Created by 日野森 寛也（Hiroya Hinomori） on 2023/09/07.
//

import Foundation

public enum SessionError: Error, Equatable {
    case unexpectedObject
    case connectionError
    case serverError(ServerErrorReason)
}

public struct ServerErrorReason: Error, Decodable, Equatable {
    enum CodingKeys: String, CodingKey {
        case errors
    }

    struct Content: Decodable {
        let subCode: String
    }

    public let code: String

    public init(from decoder: Decoder) throws {
        let root = try decoder.container(keyedBy: CodingKeys.self)
        let content = try root.decode(Content.self, forKey: .errors)
        self.code = content.subCode
    }
}
