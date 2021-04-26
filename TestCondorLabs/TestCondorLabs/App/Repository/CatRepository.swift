//
//  CatRepository.swift
//  TestCondorLabs
//
//  Created by Pedro Alonso Daza B on 26/04/21.
//

import Foundation

class CatRepository {
    static func getListCats(limit: Int, page: Int, ok: @escaping (([CatModel]) -> Void), error: @escaping ((String) -> Void)) {
        let newUrl = getApi(api: .getAllBreeds).replacingOccurrences(of: "{limit}", with: "\(limit)").replacingOccurrences(of: "{page}", with: "\(page)")
        getReturnData(url: newUrl, statusCorrect: [200, 201]) { (data) in
            let listCatModel = try! JSONDecoder().decode([CatModel].self, from: data)
            ok(listCatModel)
        } error: { (err) in
            error(err)
        }

    }
}
