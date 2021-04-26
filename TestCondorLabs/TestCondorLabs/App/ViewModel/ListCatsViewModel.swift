//
//  ListCartsViewModel.swift
//  TestExito
//
//  Created by Pedro Alonso Daza B on 15/02/21.
//

import Foundation
import UIKit
import Alamofire
protocol ListCatsViewModelDelegate: class {
    func successgetListCats(succesGetCat listCats: [CatModel])
    func error(error: String)
    
}
class ListCatsViewModel{
    
    
    var listCatsViewModelDelegate: ListCatsViewModelDelegate?
    init(listCatsViewModelDelegate: ListCatsViewModelDelegate ){
        self.listCatsViewModelDelegate = listCatsViewModelDelegate
    }
    
    func filterCats(text:String, listCats: [CatModel]) -> [CatModel]{
        var listCats1 = [CatModel]()
        listCats.forEach { (catModel) in
            if ((catModel.name ?? "").contains(text)) {
                listCats1.append(catModel)
            }
        }
        
        return listCats1
        
    }
}

extension ListCatsViewModel{
    func getListCats(limit: Int, page: Int){

        //SwiftSpinner.show("loading...")
        CatRepository.getListCats(limit: limit, page: page) { (catsModel) in
            if !catsModel.isEmpty {
                self.listCatsViewModelDelegate?.successgetListCats(succesGetCat: catsModel)
            } else {
                self.listCatsViewModelDelegate?.error(error: TextConstants().WS_ERROR_NO_DATA)
            }
            
        } error: { (err) in
            self.listCatsViewModelDelegate?.error(error: err)
        }

            
    }
}

