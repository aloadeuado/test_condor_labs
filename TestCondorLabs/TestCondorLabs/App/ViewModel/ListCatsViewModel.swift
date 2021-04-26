//
//  ListCartsViewModel.swift
//  TestExito
//
//  Created by Pedro Alonso Daza B on 15/02/21.
//

import Foundation
import UIKit
import Alamofire
protocol ListCatsViewModelDelegate {
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
    func getListCats(controller: UIViewController){

        //SwiftSpinner.show("loading...")
        AF.request("https://api.thecatapi.com/v1/breeds", method: .get).response { (respose) in
            //SwiftSpinner.hide()
            if let respo = respose.response{
                if respo.statusCode == 200 || respose.response?.statusCode == 201 {
                    
                    let listCatModel = try! JSONDecoder().decode([CatModel].self, from: respose.data ?? Data())
                    self.listCatsViewModelDelegate?.successgetListCats(succesGetCat: listCatModel)
                } else {
                    self.listCatsViewModelDelegate?.error(error: respose.error?.localizedDescription ?? "no data encode")
                }
            } else {
                self.listCatsViewModelDelegate?.error(error: respose.error?.localizedDescription ?? "no data encode")
            }
            
        }
              
                
            
    }
}

