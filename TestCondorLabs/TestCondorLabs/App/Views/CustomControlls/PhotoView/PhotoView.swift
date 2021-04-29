//
//  PhotoView.swift
//  TestCondorLabs
//
//  Created by Pedro Alonso Daza B on 27/04/21.
//

import UIKit
import URLImage
protocol PhotoViewDelegate {
    func photoView(didSelect index:Int, image: UIImage)
}
class PhotoView: OwnerView {

    var delegate: PhotoViewDelegate?
    @IBOutlet weak var generalScrollView: UIScrollView!
    @IBOutlet weak var generalView: UIView!
    @IBOutlet weak var inicatorPanelControl: UIPageControl!
    @IBOutlet weak var widhtScrollView: NSLayoutConstraint!
    private var scrollOffset = CGPoint(x: 0, y: 0)
    private var indexSelection = 0
    override var nameXib: String {
        return "PhotoView"
    }
    
    var listUrlImage = [String]() {
        didSet{
            setimages()
        }
    }
    
    var listImages = [UIImageView]()
    override func setView() {
        super.setView()
        generalScrollView.delegate = self
    }
    private func setimages() {
        inicatorPanelControl.numberOfPages = listUrlImage.count
        var xInit: CGFloat = 0
        let yInit: CGFloat = 0
        let heigthImage: CGFloat = self.frame.height
        let widhtImage: CGFloat = self.frame.width
        let spaceX: CGFloat = 1
        var tag = 0
        for text in listUrlImage {
            let imageView = UIImageView(frame: CGRect(x: xInit, y: yInit, width: widhtImage, height: heigthImage))
            
            if let urlImageURL = URL(string: text) {
                imageView.load(url: urlImageURL)
            }
            imageView.tag = tag
            generalView.addSubview(imageView)
            listImages.append(imageView)
            
            xInit += spaceX + widhtImage
            widhtScrollView.constant = xInit
            tag += 1
        }
    }
    
    func setPosition(isNextOrBefore: Bool) {
        if isNextOrBefore {
            indexSelection += 1
            if indexSelection >= (listUrlImage.count - 1) {
                indexSelection = (listUrlImage.count - 1)
            }
            
            
        } else {
            indexSelection -= 1
            if indexSelection <= 0 {
                indexSelection = 0
            }
        }
        print("==index select: \(indexSelection)")
        setView(index: indexSelection)
    }

    func setView(index: Int) {
        indexSelection = index
        if let image = listImages[indexSelection].image {
            delegate?.photoView(didSelect: indexSelection, image: image)
        }
        
        inicatorPanelControl.currentPage = index
        for imageView in listImages {
            if imageView.tag == index {
                generalScrollView.setContentOffset(CGPoint(x: imageView.frame.origin.x, y: imageView.frame.origin.y), animated: true)
            }
        }
    }
}
//MARK: -Actions
extension PhotoView {
    @IBAction func nextItemPressed(button: UIButton) {
        indexSelection += 1
        if indexSelection >= (listUrlImage.count - 1) {
            indexSelection = (listUrlImage.count - 1)
        }
        print("==index select: \(indexSelection)")
        setView(index: indexSelection)
    }
    
    @IBAction func beforeItemPressed(button: UIButton) {
        indexSelection -= 1
        if indexSelection <= 0 {
            indexSelection = 0
        }
        print("==index select: \(indexSelection)")
        setView(index: indexSelection)
    }
}
//MARK: -ScrollView
extension PhotoView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollOffset = scrollView.contentOffset
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.x >= scrollOffset.x {
            setPosition(isNextOrBefore: true)
        } else {
            setPosition(isNextOrBefore: false)
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        for imageView in listImages {
            if imageView.tag == indexSelection {
                generalScrollView.setContentOffset(CGPoint(x: imageView.frame.origin.x, y: imageView.frame.origin.y), animated: true)
            }
        }
    }
}
