//
//  OwnerView.swift
//  Exito
//
//  Created by Pedro Alonso Daza B on 29/03/21.
//  Copyright © 2021 Pragma S.A. All rights reserved.
//

import Foundation
import UIKit
class OwnerView: UIView {
    
    var nameXib: String {
        return "AddProductView"
    }
    
    @IBOutlet weak var contentView: UIView!
    
    private var isFirstCall = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //viewSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        //viewSetup()
        
    }
    
    private func loadViewFromNib() -> UIView? {

         let nibName = nameXib
         let bundle = Bundle(for: type(of: self))
         let nib = UINib(nibName: nibName, bundle: bundle)
         return nib.instantiate(withOwner: self, options: nil).first as? UIView
     }
    
    private func viewSetup() {
        if !isFirstCall {
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
                self.addSubview(view)
                isFirstCall = true
            
            
            contentView = view
            setView()
        
        }
    }
    
    func setView() {
        
    }
}
