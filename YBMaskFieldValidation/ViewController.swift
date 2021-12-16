//
//  ViewController.swift
//  YBMaskFieldValidation
//
//  Created by Yani Buchkov on 16.12.21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IBOutlets & Properties
    @IBOutlet weak var txtPostalCodeExampleField: UITextField!
    @IBOutlet weak var txtCardField: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    let kPostalCode = "000-0000" // example for postal code in Japan
    let kCardField = "0000-0000-0000-0000-0000" // example for card number
    let kPhoneNumber = "+000 (000) 00 00 00" // example for phone number BG
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields()
    }
    
    // MARK: - Private:
    private func setupFields() {
        [txtPostalCodeExampleField, txtCardField, txtPhoneNumber].forEach { [weak self] field in
            guard let strongField = field else {
                return
            }
            strongField.delegate = self
        }
        
        txtPostalCodeExampleField.placeholder = "123-4556"
        txtCardField.placeholder = "1234-1234-4567-1236"
        txtPhoneNumber.placeholder = "+359"
    }
    
    private func updateTextFieldValue(_ textField: UITextField) {
        if let text = textField.text {
            if textField == txtPostalCodeExampleField {
                NSLog("Postal Code: %@", text)
            } else if textField == txtCardField {
                NSLog("Card Field: %@", text)
            } else if textField == txtPhoneNumber {
                NSLog("Phone Number: %@", text)
            }
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return false
        }
        if textField == txtPostalCodeExampleField {
            let maskFormatter = TIMask(pattern: kPostalCode)
            textField.text = maskFormatter.mask(text, range: range, replacementString: string)
            return false
        } else if textField == txtCardField {
            let maskFormatter = TIMask(pattern: kCardField)
            textField.text = maskFormatter.mask(text, range: range, replacementString: string)
            return false
        } else if textField == txtPhoneNumber {
            let maskFormatter = TIMask(pattern: kPhoneNumber)
            textField.text = maskFormatter.mask(text, range: range, replacementString: string)
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        updateTextFieldValue(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        updateTextFieldValue(textField)
    }
}

