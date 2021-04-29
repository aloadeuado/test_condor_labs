//
//  PhotoView.swift
//  TestCondorLabs
//
//  Created by Pedro Alonso Daza B on 27/04/21.
//

import UIKit
import URLImage

class TransformView: OwnerView {

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
            //photoImageView.isHidden = false
        }
    }
    private var imagePut = UIImage()
    private var isDidMoved = false
    var initFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var initPositionCursePoint = CGPoint(x: 0, y: 0)
    var initCGAffineTransform = CGAffineTransform(scaleX: 0, y: 0)
    override var nameXib: String {
        return "TransformView"
    }

    func rightArea(complete: @escaping (() -> Void)) {
        //finishState()
        var t = CGAffineTransform.identity
        t = t.translatedBy(x: 0, y: 0)
        t = t.rotated(by: 0 * (CGFloat.pi / 180))
        self.contentPhotoImageView.transform = t
        self.contentPhotoImageView.alpha = 1
        UIView.animate(withDuration: 1.0, animations: {
            var t = CGAffineTransform.identity
            t = t.translatedBy(x: self.frame.width, y: self.frame.height / 2)
            t = t.rotated(by: 20 * (CGFloat.pi / 180))
            
            self.contentPhotoImageView.transform = t
            self.contentPhotoImageView.alpha = 0.3
        }) { (vara) in
            var t = CGAffineTransform.identity
            t = t.translatedBy(x: 0, y: 0)
            t = t.rotated(by: 0 * (CGFloat.pi / 180))
            self.contentPhotoImageView.transform = t
            self.contentPhotoImageView.alpha = 1
            complete()
        }
    }
    
    func leftArea(complete: @escaping (() -> Void)) {
        //finishState()
        var t = CGAffineTransform.identity
        t = t.translatedBy(x: 0, y: 0)
        t = t.rotated(by: 0 * (CGFloat.pi / 180))
        self.contentPhotoImageView.transform = t
        self.contentPhotoImageView.alpha = 1
        UIView.animate(withDuration: 1.0, animations: {
            var t = CGAffineTransform.identity
            t = t.translatedBy(x: -self.frame.width, y: self.frame.height / 2)
            t = t.rotated(by: -20 * (CGFloat.pi / 180))
            
            self.contentPhotoImageView.transform = t
            self.contentPhotoImageView.alpha = 0.3
        }) { (vara) in
            var t = CGAffineTransform.identity
            t = t.translatedBy(x: 0, y: 0)
            t = t.rotated(by: 0 * (CGFloat.pi / 180))
            self.contentPhotoImageView.transform = t
            self.contentPhotoImageView.alpha = 1
            complete()
        }
    }
}
//MARK: -TouchCordinatesButtonDelegate
extension TransformView {
    func touchCordinatesButton(didBegan originPoint: CGPoint) {
        isDidMoved = true
        initFrame = contentPhotoImageView.frame
        initPositionCursePoint = originPoint
        initCGAffineTransform = contentPhotoImageView.transform
    }
    
    func touchCordinatesButton(didMoved originPoint: CGPoint) {
        if isDidMoved {
            let positionX = originPoint.x - initPositionCursePoint.x
            let positionY = originPoint.y - initPositionCursePoint.y
            
            let widthMig = self.frame.width / 2
            var degrees:CGFloat = 0;
            var alpha:CGFloat = 0;
            let positionMigX = originPoint.x - widthMig
            degrees = (positionMigX * initDegree) / widthMig
            
            //print("==Diff alpha position: \(((positionMigX * (finalAlphaTransform - initAlphaTransform)) / widthMig))")
            if initPositionCursePoint.x > widthMig {
                alpha = initAlphaTransform + ((positionMigX * (finalAlphaTransform - initAlphaTransform)) / widthMig)
            } else {
                alpha = (initAlphaTransform + (((-1 * positionMigX) * (finalAlphaTransform - initAlphaTransform)) / widthMig))
            }

            var t = CGAffineTransform.identity
            t = t.translatedBy(x: positionX, y: positionY)
            t = t.rotated(by: degrees * (CGFloat.pi / 180))
            
            contentPhotoImageView.transform = t
            contentPhotoImageView.alpha = alpha
            
        }
    }
    
    func touchCordinatesButton(didEnded originPoint: CGPoint) {
        isDidMoved = false
        contentPhotoImageView.frame = initFrame
        UIView.animate(withDuration: 0.25, animations: {
            self.contentPhotoImageView.transform = self.initCGAffineTransform
            })
        
        contentPhotoImageView.alpha = 1
    }
    
    func finishState(){
        self.contentPhotoImageView.transform = self.initCGAffineTransform
        self.contentPhotoImageView.alpha = 1
    }
    
}

