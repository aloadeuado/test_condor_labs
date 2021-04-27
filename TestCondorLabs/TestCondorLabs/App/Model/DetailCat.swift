//
//  DetailCat.swift
//  TestCondorLabs
//
//  Created by Pedro Alonso Daza B on 26/04/21.
//

import Foundation

// MARK: - DetailCatElement
struct DetailCatElement: Codable {
    let breeds: [Breed]
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
        breeds: [Breed]? = nil,
        id: String? = nil,
        url: String? = nil,
        width: Int? = nil,
        height: Int? = nil
    ) -> DetailCatElement {
        return DetailCatElement(
            breeds: breeds ?? self.breeds,
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

// MARK: - Breed
struct Breed: Codable {
    let weight: Weight
    let id, name, temperament, origin: String
    let countryCodes, countryCode, breedDescription, lifeSpan: String
    let indoor, lap: Int
    let altNames: String
    let adaptability, affectionLevel, childFriendly, dogFriendly: Int
    let energyLevel, grooming, healthIssues, intelligence: Int
    let sheddingLevel, socialNeeds, strangerFriendly, vocalisation: Int
    let experimental, hairless, natural, rare: Int
    let rex, suppressedTail, shortLegs: Int
    let wikipediaURL: String
    let hypoallergenic: Int
    let referenceImageID: String

    enum CodingKeys: String, CodingKey {
        case weight, id, name, temperament, origin
        case countryCodes = "country_codes"
        case countryCode = "country_code"
        case breedDescription = "description"
        case lifeSpan = "life_span"
        case indoor, lap
        case altNames = "alt_names"
        case adaptability
        case affectionLevel = "affection_level"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case grooming
        case healthIssues = "health_issues"
        case intelligence
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case vocalisation, experimental, hairless, natural, rare, rex
        case suppressedTail = "suppressed_tail"
        case shortLegs = "short_legs"
        case wikipediaURL = "wikipedia_url"
        case hypoallergenic
        case referenceImageID = "reference_image_id"
    }
}

// MARK: Breed convenience initializers and mutators

extension Breed {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Breed.self, from: data)
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
        weight: Weight? = nil,
        id: String? = nil,
        name: String? = nil,
        temperament: String? = nil,
        origin: String? = nil,
        countryCodes: String? = nil,
        countryCode: String? = nil,
        breedDescription: String? = nil,
        lifeSpan: String? = nil,
        indoor: Int? = nil,
        lap: Int? = nil,
        altNames: String? = nil,
        adaptability: Int? = nil,
        affectionLevel: Int? = nil,
        childFriendly: Int? = nil,
        dogFriendly: Int? = nil,
        energyLevel: Int? = nil,
        grooming: Int? = nil,
        healthIssues: Int? = nil,
        intelligence: Int? = nil,
        sheddingLevel: Int? = nil,
        socialNeeds: Int? = nil,
        strangerFriendly: Int? = nil,
        vocalisation: Int? = nil,
        experimental: Int? = nil,
        hairless: Int? = nil,
        natural: Int? = nil,
        rare: Int? = nil,
        rex: Int? = nil,
        suppressedTail: Int? = nil,
        shortLegs: Int? = nil,
        wikipediaURL: String? = nil,
        hypoallergenic: Int? = nil,
        referenceImageID: String? = nil
    ) -> Breed {
        return Breed(
            weight: weight ?? self.weight,
            id: id ?? self.id,
            name: name ?? self.name,
            temperament: temperament ?? self.temperament,
            origin: origin ?? self.origin,
            countryCodes: countryCodes ?? self.countryCodes,
            countryCode: countryCode ?? self.countryCode,
            breedDescription: breedDescription ?? self.breedDescription,
            lifeSpan: lifeSpan ?? self.lifeSpan,
            indoor: indoor ?? self.indoor,
            lap: lap ?? self.lap,
            altNames: altNames ?? self.altNames,
            adaptability: adaptability ?? self.adaptability,
            affectionLevel: affectionLevel ?? self.affectionLevel,
            childFriendly: childFriendly ?? self.childFriendly,
            dogFriendly: dogFriendly ?? self.dogFriendly,
            energyLevel: energyLevel ?? self.energyLevel,
            grooming: grooming ?? self.grooming,
            healthIssues: healthIssues ?? self.healthIssues,
            intelligence: intelligence ?? self.intelligence,
            sheddingLevel: sheddingLevel ?? self.sheddingLevel,
            socialNeeds: socialNeeds ?? self.socialNeeds,
            strangerFriendly: strangerFriendly ?? self.strangerFriendly,
            vocalisation: vocalisation ?? self.vocalisation,
            experimental: experimental ?? self.experimental,
            hairless: hairless ?? self.hairless,
            natural: natural ?? self.natural,
            rare: rare ?? self.rare,
            rex: rex ?? self.rex,
            suppressedTail: suppressedTail ?? self.suppressedTail,
            shortLegs: shortLegs ?? self.shortLegs,
            wikipediaURL: wikipediaURL ?? self.wikipediaURL,
            hypoallergenic: hypoallergenic ?? self.hypoallergenic,
            referenceImageID: referenceImageID ?? self.referenceImageID
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
