//
//  TestViewController.swift
//  TestCondorLabs
//
//  Created by Pedro Alonso Daza B on 27/04/21.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var tinderLikeView: TinderLikeView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tinderLikeView.listImage = [UIImage(named: "ic_arrow_rigth")!, UIImage(named: "ic_arrowleft")!,UIImage(named: "ic_arrow_rigth")!, UIImage(named: "ic_arrowleft")!,UIImage(named: "ic_arrow_rigth")!, UIImage(named: "ic_arrowleft")!,UIImage(named: "ic_arrow_rigth")!, UIImage(named: "ic_arrowleft")!]
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.view)
    }
}
