//
//  DetailCatViewController.swift
//  TestExito
//
//  Created by Pedro Alonso Daza B on 16/02/21.
//

import UIKit
import TTGSnackbar
class DetailCatViewController: UIViewController {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contryLabel: UILabel!
    @IBOutlet weak var smartLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var catsPhotoView: PhotoView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateView: CustomView!
    
    var selectCat: CatModel?
    var detailCatViewModel: DetailCatViewModel?
    var listDetailCatElement = [DetailCatElement]()
    var listTinderItem = [TinderItem]()
    var indexSelect = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        // Do any additional setup after loading the view.
    }
    
    func initComponent(){
        catsPhotoView.delegate = self
        detailCatViewModel = DetailCatViewModel(detailCatViewModelDelegate: self)
        guard let catModel = selectCat else {return}
        detailCatViewModel?.getDetailCat(idBread: catModel.id ?? "")
        setInfo()
        var t = CGAffineTransform.identity
        t = t.rotated(by: -45 * (CGFloat.pi / 180))
        self.stateView.transform = t
    }
    
    func setInfo() {
        guard let catModel = selectCat else {return}
        guard let image = catModel.image else {return}
        guard let urlImage = image.url else {return}
        
        
        guard let nameCat = catModel.name else {return}
        guard let origeCat = catModel.origin else {return}
        guard let temperamentCat = catModel.temperament else {return}
        guard let detailCat = catModel.description else {return}
        
        if !listDetailCatElement.isEmpty {
            guard let urlImageURL = URL(string: listDetailCatElement[0].url) else {return}
            catImageView.load(url: urlImageURL)
            nameLabel.text = nameCat
            contryLabel.text = origeCat
            smartLabel.text = temperamentCat
            detailLabel.text = detailCat
        }
    }
    
    func setPhotosDetail() {
        var listPhotosText = [String]()
        listDetailCatElement.forEach { (detailCatElement) in
            listPhotosText.append(detailCatElement.url)
        }
        catsPhotoView.listUrlImage = listPhotosText
    }

    func setLikeDislike(image: UIImage, listTinderItem: [TinderItem]) {
        let firstÇitem = listTinderItem.first { (item) -> Bool in
            return item.image == image
        }
        
        if let firstItem = firstÇitem {
            stateView.isHidden = false
            if firstItem.isLike {
                stateView.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                stateLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                stateLabel.text = "LIKE"
            } else {
                stateView.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                stateLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                stateLabel.text = "DISLIKE"
            }
        } else {
            stateView.isHidden = true
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    @IBAction func showPopOver(button: UIButton) {
        var listImages = [UIImage]()
        catsPhotoView.listImages.forEach { (imageView) in
            if let image = imageView.image {
                listImages.append(image)
            }
        }
        PopLikeAndDislikeViewController.show(controller: self, listImages: listImages) { (listTinderItem) in
            self.listTinderItem = listTinderItem
            if let image = self.catsPhotoView.listImages[self.indexSelect].image {
                self.setLikeDislike(image: image, listTinderItem: self.listTinderItem)
            }
            
        }
    }
    

}

extension DetailCatViewController: DetailCatViewModelDelegate {
    func successgetListCats(succesGetCat listCats: [DetailCatElement]) {
        self.listDetailCatElement = listCats
        //initComponent()
        setInfo()
        setPhotosDetail()
    }
    
    func error(error: String) {
        let snackbar = TTGSnackbar(message: error, duration: .short)
        snackbar.show()
    }
    
    
}
extension DetailCatViewController: PhotoViewDelegate {
    func photoView(didSelect index: Int, image: UIImage) {
        indexSelect = index
        setLikeDislike(image: image, listTinderItem: listTinderItem)
    }
    
    
}
