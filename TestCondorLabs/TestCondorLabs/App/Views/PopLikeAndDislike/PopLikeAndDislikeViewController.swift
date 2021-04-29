//
//  PopLikeAndDislikeViewController.swift
//  TestCondorLabs
//
//  Created by Pedro Alonso Daza B on 28/04/21.
//

import UIKit

class PopLikeAndDislikeViewController: UIViewController {

    var listImages = [UIImage]()
    var ok: (([TinderItem]) -> Void)?
    @IBOutlet weak var catsTinderLikeView: TinderLikeView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        // Do any additional setup after loading the view.
    }
    
    func initComponent() {
        catsTinderLikeView.delegate = self
        catsTinderLikeView.listImage = listImages
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func closePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PopLikeAndDislikeViewController:TinderLikeViewDelegate{
    func tinderLikeView(didDislike listTinderItem: [TinderItem]) {
        dismiss(animated: true) {
            self.ok?(listTinderItem)
        }
    }
    
    func tinderLikeView(didLike index: Int, image: UIImage) {
        
    }
    
    func tinderLikeView(didDislike index: Int, image: UIImage) {
        
    }
    
    
}
//MARK: -show
extension PopLikeAndDislikeViewController {
    static func show(controller: UIViewController, listImages: [UIImage], ok: @escaping (([TinderItem]) -> Void)) {
        let storyBoard1 = UIStoryboard(name: "PopLikeAndDislike", bundle: nil)
        if let alert = storyBoard1.instantiateInitialViewController() as? PopLikeAndDislikeViewController {
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            alert.listImages = listImages
            alert.ok = ok
            controller.present(alert, animated: true, completion: nil)
        }
    }
}
