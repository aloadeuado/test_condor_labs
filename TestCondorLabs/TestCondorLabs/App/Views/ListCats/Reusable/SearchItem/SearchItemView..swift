//
//  SearchItemView..swift
//  TestExito
//
//  Created by Pedro Alonso Daza B on 16/02/21.
//

import Foundation
import UIKit
protocol SearchItemViewDelegate {
    func fetchField(text: String)
}
class SearchItemView: UIView{
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    var delegate: SearchItemViewDelegate?
    
    @IBOutlet weak var contentView: UIView!

    private var isFirstCall = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //viewSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        viewSetup()
        
    }
    
    private func loadViewFromNib() -> UIView? {

         let nibName = "SearchItemView"
         let bundle = Bundle(for: type(of: self))
         let nib = UINib(nibName: nibName, bundle: bundle)
         return nib.instantiate(withOwner: self, options: nil).first as? UIView
     }
    
    private func viewSetup() {
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        if !isFirstCall {
            self.addSubview(view)
            isFirstCall = true
        }
        
        contentView = view
        initComponent()
    }
    
    func initComponent(){
        searchTextField.delegate = self
    }
    
    @IBAction func clearFieldPressed(button: UIButton){
        searchTextField.text = ""
        self.delegate?.fetchField(text: "")
    }
}

extension SearchItemView: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.delegate?.fetchField(text: textField.text ?? "" + string)
        return true
    }
}
