//
//  TouchCordinatesButton.swift
//  TestCondorLabs
//
//  Created by Pedro Alonso Daza B on 27/04/21.
//

import Foundation
import UIKit

class TouchCordinatesButton: UIButton {
    var delegate: TouchCordinatesButtonDelegate?
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        delegate?.touchCordinatesButton(didBegan: location)
    }
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        delegate?.touchCordinatesButton(didMoved: location)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        delegate?.touchCordinatesButton(didEnded: location)
    }
}

protocol TouchCordinatesButtonDelegate {
    func touchCordinatesButton(didBegan originPoint: CGPoint)
    func touchCordinatesButton(didMoved originPoint: CGPoint)
    func touchCordinatesButton(didEnded originPoint: CGPoint)
}
