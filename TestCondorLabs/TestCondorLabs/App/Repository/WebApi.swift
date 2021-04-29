//
//  WebApi.swift
//  TestCondorLabs
//
//  Created by Pedro Alonso Daza B on 26/04/21.
//

import Foundation
import Alamofire

enum Api {
    case getAllBreeds
    case getBreadsForSearch
}

func getStringInfoPList(key: String) -> String {
    return Bundle.main.object(forInfoDictionaryKey: key) as? String ?? ""
}

func getApi(api: Api) -> String{
    switch api {
    case .getAllBreeds:
        let url = getStringInfoPList(key: "KURL_BASE") + "/v1/breeds?limit={limit}&page={page}&order=Desc"
        return url
    case .getBreadsForSearch:
        let url = getStringInfoPList(key: "KURL_BASE") + "/v1/images/search?breed_ids={idBread}&limit=10"
        return url
    default:
        return "/sites"
    }
}

import Foundation
import Alamofire

func getReturnData(url: String, statusCorrect: [Int], ok: @escaping((Data) -> Void), error: @escaping ((String) -> Void)) {

    let request = AF.request(url)
    
    request.response { (response) in
        guard let responseData = response.response else {
            error(TextConstants().WS_ERROR_NO_RESPONSE)
            return
        }
        
        if statusCorrect.contains(responseData.statusCode) {
            guard let data = response.data else {
                error(TextConstants().WS_ERROR_NO_RESPONSE)
                return
            }
            
            ok(data)
        }else {
            guard let responseError = response.error else {
                error(TextConstants().WS_ERROR_NO_RESPONSE)
                return
            }
            error(responseError.localizedDescription)
        }
    }
        
        
}
