//
//  DetailCat.swift
//  TestCondorLabs
//
//  Created by Pedro Alonso Daza B on 26/04/21.
//

import Foundation

// MARK: - DetailCatElement
struct DetailCatElement: Codable {
    let id: String
    let url: String
    let width, height: Int
}

// MARK: DetailCatElement convenience initializers and mutators

extension DetailCatElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DetailCatElement.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(

        id: String? = nil,
        url: String? = nil,
        width: Int? = nil,
        height: Int? = nil
    ) -> DetailCatElement {
        return DetailCatElement(

            id: id ?? self.id,
            url: url ?? self.url,
            width: width ?? self.width,
            height: height ?? self.height
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
