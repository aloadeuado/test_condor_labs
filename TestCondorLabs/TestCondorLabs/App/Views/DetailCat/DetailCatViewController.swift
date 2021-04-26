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
    
    var selectCat: CatModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        // Do any additional setup after loading the view.
    }
    
    func initComponent(){
        guard let catModel = selectCat else {return}
        guard let image = catModel.image else {return}
        guard let urlImage = image.url else {return}
        guard let urlImageURL = URL(string: urlImage) else {return}
        
        guard let nameCat = catModel.name else {return}
        guard let origeCat = catModel.origin else {return}
        guard let temperamentCat = catModel.temperament else {return}
        guard let detailCat = catModel.description else {return}
        
        catImageView.load(url: urlImageURL)
        nameLabel.text = nameCat
        contryLabel.text = origeCat
        smartLabel.text = temperamentCat
        detailLabel.text = detailCat
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
