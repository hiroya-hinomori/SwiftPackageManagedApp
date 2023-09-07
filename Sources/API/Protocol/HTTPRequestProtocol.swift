//
//  HTTPRequestProtocol.swift
//  
//
//  Created by 日野森 寛也（Hiroya Hinomori） on 2023/09/07.
//

import Foundation
import APIKit

public protocol HTTPRequestProtocol: Request where Response: Decodable {
    var sample: Data { get }
}

struct DecodableDataParser<Response: Decodable>: DataParser {
    var contentType: String?

    func parse(data: Data) throws -> Any {
        #if DEBUG
        print(String(data: data, encoding: .utf8) ?? "")
        #endif
        if let decoded = try? JSONDecoder().decode(ServerErrorReason.self, from: data) {
            throw SessionError.serverError(decoded)
        } else {
            do {
                if data.isEmpty {
                    return data
                } else {
                    return try JSONDecoder().decode(Response.self, from: data)
                }
            } catch {
                throw SessionError.unexpectedObject
            }
        }
    }
}

struct EncodableJSONBodyParameters<RequestBody: Encodable>: BodyParameters {
    let JSONObject: RequestBody

    init(JSONObject: RequestBody) {
        self.JSONObject = JSONObject
    }

    var contentType: String {
        "application/json"
    }

    func buildEntity() throws -> RequestBodyEntity {
        guard let encoded = try? JSONEncoder().encode(JSONObject) else {
            throw SessionError.unexpectedObject
        }
        return .data(encoded)
    }
}

extension HTTPRequestProtocol {
    public var dataParser: DataParser {
        DecodableDataParser<Response>()
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        if let object = object as? Data, object.isEmpty, let res = (NoContent() as? Self.Response) {
            return res
        } else if let res = object as? Response {
            return res
        } else {
            throw SessionError.unexpectedObject
        }
    }

    #if DEBUG
    public func intercept(urlRequest: URLRequest) throws -> URLRequest {
        print(Self.generateCURL(urlRequest))
        return urlRequest
    }
    #endif

    public func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            guard let error = object as? ServerErrorReason else {
                throw SessionError.unexpectedObject
            }
            throw SessionError.serverError(error)
        }
        return object
    }
}

extension HTTPRequestProtocol {
    static func generateCURL(_ urlRequest: URLRequest) -> String {
        guard let url = urlRequest.url else { return "" }
        var baseCommand = "$ curl -v"
        if urlRequest.httpMethod == "HEAD" {
            baseCommand += " --head"
        }
        var command = [baseCommand]
        if let method = urlRequest.httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }
        if let headers = urlRequest.allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }
        if let data = urlRequest.httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }
        command.append("\"\(url.absoluteString)\"")
        return command.joined(separator: " \\\n\t")
    }
}
