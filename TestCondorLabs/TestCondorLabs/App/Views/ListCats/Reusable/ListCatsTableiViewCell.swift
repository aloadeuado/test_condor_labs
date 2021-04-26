//
//  ListCatsTableiViewCell1.swift
//  TestExito
//
//  Created by Pedro Alonso Daza B on 16/02/21.
//

import Foundation
import UIKit
import URLImage
class ListCatsTableiViewCell: UITableViewCell{
    @IBOutlet weak var generalView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var contryLabel: UILabel!
    @IBOutlet weak var smartLabel: UILabel!
    
    var detail: ((CatModel) -> Void)?
    var catModel: CatModel?
    func setData(catModel: CatModel, detail: @escaping ((CatModel) -> Void)) {
        self.detail = detail
        self.catModel = catModel
        guard let image = catModel.image else {return}
        guard let urlImage = image.url else {return}
        guard let urlImageURL = URL(string: urlImage) else {return}
        
        guard let nameCat = catModel.name else {return}
        guard let origeCat = catModel.origin else {return}
        guard let temperamentCat = catModel.temperament else {return}
        
        catImageView.load(url: urlImageURL)
        titleLabel.text = nameCat
        contryLabel.text = origeCat
        smartLabel.text = temperamentCat
        
        moreLabel.text = "More.."
        
    }
    
    @IBAction func moreDatailsPressed(_ sender: UIButton) {
        if let cat = self.catModel{
            detail?(cat)
        }
        
    }
    
}
