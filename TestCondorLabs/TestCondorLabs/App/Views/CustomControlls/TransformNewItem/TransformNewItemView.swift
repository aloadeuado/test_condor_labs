//
//  PhotoView.swift
//  TestCondorLabs
//
//  Created by Pedro Alonso Daza B on 27/04/21.
//

import UIKit
import URLImage
class TransformNewItem: OwnerView {

    @IBInspectable var initDegree: CGFloat = 20
    @IBInspectable var validateArea: CGFloat = 50
    @IBInspectable var initAlphaTransform: CGFloat = 0.7
    @IBInspectable var finalAlphaTransform: CGFloat = 0.3
    @IBOutlet weak var contentPhotoImageView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var selctButton: TouchCordinatesButton!

    var viewPut = UIView() {
        didSet{
            photoImageView.image = viewPut.asImage()
        }
    }
    private var isDidMoved = false
    var initFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var initPositionCursePoint = CGPoint(x: 0, y: 0)
    var initCGAffineTransform = CGAffineTransform(scaleX: 0, y: 0)
    override var nameXib: String {
        return "TransformNewItem"
    }

    @IBAction func slectDownPressed(_ sender: UIButton) {
        isDidMoved = true
    }
    @IBAction func selectUpPressed(_ sender: Any) {
        isDidMoved = false
    }
}
//MARK: -TouchCordinatesButtonDelegate
extension TransformNewItem {
    func touchCordinatesButton(didBegan originPoint: CGPoint) {
        isDidMoved = true
        initFrame = contentPhotoImageView.frame
        initPositionCursePoint = originPoint
        initCGAffineTransform = contentPhotoImageView.transform
    }
    
    func touchCordinatesButton(didMoved originPoint: CGPoint) {
        if isDidMoved {
            var scala:CGFloat = 0
            var alpha:CGFloat = 0;
            
            if initPositionCursePoint.x <= originPoint.x {
                alpha = (originPoint.x * 1.0) / initFrame.width
                scala = (originPoint.x * 1.0) / initFrame.width
            } else {
                alpha = ((initFrame.width - originPoint.x) * 1.0) / initFrame.width
                scala = ((initFrame.width - originPoint.x) * 1.0) / initFrame.width
            }

            
            var t = CGAffineTransform.identity
            t = t.scaledBy(x: scala, y: scala)
            
            contentPhotoImageView.transform = t
            contentPhotoImageView.alpha = alpha
            //
        }
    }
    
    func touchCordinatesButton(didEnded originPoint: CGPoint) {
        isDidMoved = false
        contentPhotoImageView.frame = initFrame
        UIView.animate(withDuration: 0.45, animations: {
            var t = CGAffineTransform.identity
            t = t.scaledBy(x: 0, y: 0)
            
            self.contentPhotoImageView.transform = t
            
        }) { (vara) in
            self.contentPhotoImageView.transform = self.initCGAffineTransform
        }
        contentPhotoImageView.alpha = 1
    }
    
    func finishShow(complete: @escaping (() -> Void)){
        UIView.animate(withDuration: 0.45, animations: {
            self.contentPhotoImageView.transform = self.initCGAffineTransform
            self.contentPhotoImageView.alpha = 1
        }) { (state) in
            complete()
        }
        
    }
    
    
}

