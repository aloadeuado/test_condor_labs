//
//  TinderLikeView.swift
//  TestCondorLabs
//
//  Created by Pedro Alonso Daza B on 28/04/21.
//

import UIKit
class TinderItem {
    var image = UIImage()
    var isLike = false
    init(image: UIImage, isLike: Bool) {
        self.image = image
        self.isLike = isLike
    }
}
protocol TinderLikeViewDelegate {
    func tinderLikeView(didLike index: Int, image: UIImage)
    func tinderLikeView(didDislike index: Int, image: UIImage)
    func tinderLikeView(didDislike listTinderItem: [TinderItem])
}
class TinderLikeView: OwnerView {

    var delegate: TinderLikeViewDelegate?
    var listTinderItem = [TinderItem]()
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
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateView: CustomView!
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
            self.delegate?.tinderLikeView(didDislike: self.listTinderItem)
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
                self.likeButton.isEnabled = true
                self.disLikeButton.isEnabled = true
                self.movedButton.isHidden = false
            }
            
            delegate?.tinderLikeView(didLike: selectIndex, image: listImage[selectIndex])
            isFirstCall = false
        }
    }
    
    @IBAction func dislikePressed(_ sender: UIButton) {
        likeButton.isEnabled = false
        disLikeButton.isEnabled = false
        movedButton.isHidden = true
        seDislikeState()
        listTinderItem.append(TinderItem(image: self.listImage[self.selectIndex], isLike: false))
        self.transformView.leftArea {
            
        }
        self.transformNewItem.leftArea {
            self.moreIndex()
            if self.selectIndex < self.listImage.count {
                let imageView = UIImageView(frame: self.transformView.frame)
                imageView.image = self.listImage[self.selectIndex]
                self.transformView.viewPut = imageView
            } else {
                self.transformView.isHidden = true
            }
            if (self.selectIndex + 1) < self.listImage.count {
                //transformNewItem.isHidden = false
                let imageView1 = UIImageView(frame: self.transformView.frame)
                imageView1.image = self.listImage[self.selectIndex + 1]
                self.transformNewItem.viewPut =  imageView1
            } else {
                self.transformNewItem.isHidden = true
            }
            self.likeButton.isEnabled = true
            self.disLikeButton.isEnabled = true
            self.movedButton.isHidden = false
        }
    }
    @IBAction func likePressed(_ sender: UIButton) {
        likeButton.isEnabled = false
        disLikeButton.isEnabled = false
        movedButton.isHidden = true
        setLikeState()
        listTinderItem.append(TinderItem(image: self.listImage[self.selectIndex], isLike: true))
        self.transformView.rightArea {

        }
        
        self.transformNewItem.rightArea {
            self.moreIndex()
            if self.selectIndex < self.listImage.count {
                let imageView = UIImageView(frame: self.transformView.frame)
                imageView.image = self.listImage[self.selectIndex]
                self.transformView.viewPut = imageView
            } else {
                self.transformView.isHidden = true
            }
            if (self.selectIndex + 1) < self.listImage.count {
                //transformNewItem.isHidden = false
                let imageView1 = UIImageView(frame: self.transformView.frame)
                imageView1.image = self.listImage[self.selectIndex + 1]
                self.transformNewItem.viewPut =  imageView1
            } else {
                self.delegate?.tinderLikeView(didDislike: self.listTinderItem)
                self.transformNewItem.isHidden = true
            }
            self.likeButton.isEnabled = true
            self.disLikeButton.isEnabled = true
            self.movedButton.isHidden = false
        }
    }
    
    func setLikeState(){
        stateView.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        stateLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        stateLabel.text = "LIKE"
        stateView.isHidden = false
        var t = CGAffineTransform.identity
        t = t.scaledBy(x: 0.4, y: 0.4)

        
        self.stateView.transform = t
        UIView.animate(withDuration: 0.6, animations: {
            var t = CGAffineTransform.identity
            t = t.scaledBy(x: 1.5, y: 1.5)

            
            self.stateView.transform = t
        }) { (vara) in
            self.stateView.isHidden = true
        }
    }
    
    func seDislikeState(){
        stateView.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        stateLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        stateLabel.text = "DISLIKE"
        stateView.isHidden = false
        var t = CGAffineTransform.identity
        t = t.scaledBy(x: 0.4, y: 0.4)

        
        self.stateView.transform = t
        UIView.animate(withDuration: 0.6, animations: {
            var t = CGAffineTransform.identity
            t = t.scaledBy(x: 1.5, y: 1.5)

            
            self.stateView.transform = t
        }) { (vara) in
            self.stateView.isHidden = true
        }
    }

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
            likeButton.isEnabled = false
            disLikeButton.isEnabled = false
            movedButton.isHidden = true
            listTinderItem.append(TinderItem(image: self.listImage[self.selectIndex], isLike: false))
            seDislikeState()
            enterArea()
            return
        }
        
        if originPoint.x >= (self.frame.width - validateArea) {
            likeButton.isEnabled = false
            disLikeButton.isEnabled = false
            movedButton.isHidden = true
            listTinderItem.append(TinderItem(image: self.listImage[self.selectIndex], isLike: true))
            setLikeState()
            enterArea()
            return
        }
        transformView.touchCordinatesButton(didEnded: originPoint)
        transformNewItem.touchCordinatesButton(didEnded: originPoint)
        
    }
    

}

