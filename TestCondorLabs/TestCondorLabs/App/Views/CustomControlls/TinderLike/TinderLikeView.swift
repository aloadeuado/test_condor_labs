//
//  TinderLikeView.swift
//  TestCondorLabs
//
//  Created by Pedro Alonso Daza B on 28/04/21.
//

import UIKit
protocol TinderLikeViewDelegate {
    func tinderLikeView(didLike index: Int, image: UIImage)
    func tinderLikeView(didDislike index: Int, image: UIImage)
}
class TinderLikeView: OwnerView {

    var delegate: TinderLikeViewDelegate?
    var listImage = [UIImage]() {
        didSet{
            loadImages()
        }
    }
    
    @IBInspectable var initDegree: CGFloat = 20 {
        didSet{
            transformView.initDegree = initDegree
            transformNewItem.initDegree = initDegree
        }
    }
    @IBInspectable var validateArea: CGFloat = 50{
        didSet{
            transformView.validateArea = validateArea
            transformNewItem.validateArea = validateArea
        }
    }
    @IBInspectable var initAlphaTransform: CGFloat = 0.7{
        didSet{
            transformView.initAlphaTransform = initAlphaTransform
            transformNewItem.initAlphaTransform = initAlphaTransform
        }
    }
    @IBInspectable var finalAlphaTransform: CGFloat = 0.3{
        didSet{
            transformView.finalAlphaTransform = finalAlphaTransform
            transformNewItem.finalAlphaTransform = finalAlphaTransform
        }
    }
    @IBOutlet weak var transformView: TransformView!
    @IBOutlet weak var transformNewItem: TransformNewItem!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var disLikeButton: UIButton!
    @IBOutlet weak var movedButton: TouchCordinatesButton!
    
    var isFirstCall = true
    override var nameXib: String {
        return "TinderLikeView"
    }
    
    var selectIndex = 0
    override func setView() {
        super.setView()
        movedButton.delegate = self
        
    }
    func loadImages() {
        selectIndex = 0
        setInitIndex()
        setFinalIndex()
    }
    
    func setInitIndex() {
        if selectIndex < listImage.count {
            transformView.isHidden = false
            let imageView = UIImageView(frame: transformView.frame)
            imageView.image = listImage[selectIndex]
            transformView.viewPut = imageView
        } else {
            transformView.isHidden = true
        }
        
        
    }
    
    func setFinalIndex(){
        if (selectIndex + 1) < listImage.count {
            //transformNewItem.isHidden = false
            let imageView1 = UIImageView(frame: transformView.frame)
            imageView1.image = listImage[selectIndex + 1]
            transformNewItem.viewPut =  imageView1
        } else {
            transformNewItem.isHidden = true
        }
    }
    
    func moreIndex() {
        selectIndex += 1
        if selectIndex >= (listImage.count - 1) {
            selectIndex = (listImage.count - 1)
        }
        setInitIndex()
    }
    
    func enterArea(){
        if isFirstCall {
            transformView.isHidden = true
            transformNewItem.finishShow {
                self.moreIndex()
                self.setInitIndex()
                self.transformView.finishState()
                self.setFinalIndex()
                /*self.moreIndex()
                
                self.transformView.isHidden = false
                self.setFinalIndex()*/
                //
            }
            
            delegate?.tinderLikeView(didLike: selectIndex, image: listImage[selectIndex])
            isFirstCall = false
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
//MARK: -TouchCordinatesButtonDelegate
extension TinderLikeView: TouchCordinatesButtonDelegate {
    func touchCordinatesButton(didBegan originPoint: CGPoint) {
        transformView.touchCordinatesButton(didBegan: originPoint)
        transformNewItem.touchCordinatesButton(didBegan: originPoint)
    }
    
    func touchCordinatesButton(didMoved originPoint: CGPoint) {
        transformView.touchCordinatesButton(didMoved: originPoint)
        transformNewItem.touchCordinatesButton(didMoved: originPoint)
        
        
    }
    
    func touchCordinatesButton(didEnded originPoint: CGPoint) {
        isFirstCall = true
        
        //transformView.isHidden = false
        //
        if originPoint.x <= validateArea {
            enterArea()
            return
        }
        
        if originPoint.x >= (self.frame.width - validateArea) {
            enterArea()
            return
        }
        transformView.touchCordinatesButton(didEnded: originPoint)
        transformNewItem.touchCordinatesButton(didEnded: originPoint)
        
    }
    

}

