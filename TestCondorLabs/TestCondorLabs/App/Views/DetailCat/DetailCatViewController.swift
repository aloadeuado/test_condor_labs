//
//  DetailCatViewController.swift
//  TestExito
//
//  Created by Pedro Alonso Daza B on 16/02/21.
//

import UIKit

class DetailCatViewController: UIViewController {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contryLabel: UILabel!
    @IBOutlet weak var smartLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var catsPhotoView: PhotoView!
    
    var selectCat: CatModel?
    var detailCatViewModel: DetailCatViewModel?
    var listDetailCatElement = [DetailCatElement]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        // Do any additional setup after loading the view.
    }
    
    func initComponent(){
        catsPhotoView.listUrlImage = ["https://cdn2.thecatapi.com/images/xnzzM6MBI.jpg", "https://cdn2.thecatapi.com/images/xnzzM6MBI.jpg", "https://cdn2.thecatapi.com/images/xnzzM6MBI.jpg", "https://cdn2.thecatapi.com/images/xnzzM6MBI.jpg", "https://cdn2.thecatapi.com/images/xnzzM6MBI.jpg"]
        detailCatViewModel = DetailCatViewModel(detailCatViewModelDelegate: self)
        guard let catModel = selectCat else {return}
        guard let image = catModel.image else {return}
        guard let urlImage = image.url else {return}
        
        
        guard let nameCat = catModel.name else {return}
        guard let origeCat = catModel.origin else {return}
        guard let temperamentCat = catModel.temperament else {return}
        guard let detailCat = catModel.description else {return}
        detailCatViewModel?.getDetailCat(idBread: catModel.id ?? "")
        if !listDetailCatElement.isEmpty {
            guard let urlImageURL = URL(string: listDetailCatElement[0].url) else {return}
            catImageView.load(url: urlImageURL)
            nameLabel.text = nameCat
            contryLabel.text = origeCat
            smartLabel.text = temperamentCat
            detailLabel.text = detailCat
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailCatViewController: DetailCatViewModelDelegate {
    func successgetListCats(succesGetCat listCats: [DetailCatElement]) {
        self.listDetailCatElement = listCats
        //initComponent()
    }
    
    func error(error: String) {
        
    }
    
    
}
