//
//  SearchBarView.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 23/03/21.
//

import UIKit
protocol SearchBarViewDelegate {
    func searchBarView(didEdintingText text: String)
    func searchBarView(didClearText textBeforeClear: String)
}
class SearchBarView: UIView {

    @IBInspectable var isOnlyAlphaNumeric:Bool = true
    @IBInspectable var rangeText: Int = 140
    
    @IBOutlet weak var findTextField: UITextField!
    @IBOutlet weak var clearButton: CustomButton!
    @IBOutlet weak var contentView: UIView!
    
    var delegate: SearchBarViewDelegate?
    let validationAlphabetical = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ abcdefghijklmnñopqrstuvwxyz1234567890"
    
    private var isFirstCall = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //viewSetup()
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

         let nibName = "SearchBarView"
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
        setView()
    }

    func setView(){
        clearButton.isHidden = true
    }
    
    
}

//MARK: -Actions
extension SearchBarView {
    @IBAction func clearPressed(_ sender: CustomButton) {
        clearButton.isHidden = true
        delegate?.searchBarView(didClearText: findTextField.text ?? "")
        findTextField.text = ""
    }
    @IBAction func textEditingChanged(_ sender: UITextField) {
        if !(sender.text ?? "").isEmpty {
            clearButton.isHidden = false
        } else {
            clearButton.isHidden = true
        }
        delegate?.searchBarView(didEdintingText: (sender.text ?? ""))
    }
    
}
//MARK: -UITextFieldDelegate
extension SearchBarView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if isOnlyAlphaNumeric {
            let set = CharacterSet(charactersIn: validationAlphabetical).inverted
            let filtered = string.components(separatedBy: set).joined(separator: "")


            
            return (string == filtered) && (range.location < rangeText)
        }

        return (range.location < rangeText)
    }
}
