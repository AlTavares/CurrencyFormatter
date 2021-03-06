//
//  ViewController.swift
//  CurrencyFormatter
//
//  Created by henrique-morbin-ilegra on 03/27/2017.
//  Copyright (c) 2017 henrique-morbin-ilegra. All rights reserved.
//

import UIKit
import CurrencyFormatter

class ViewController: UIViewController {

    @IBOutlet weak var lblInteger: UILabel!
    @IBOutlet weak var lblDecimal: UILabel!
    @IBOutlet weak var lblString: UILabel!
    
    fileprivate lazy var formatter: CurrencyFormatter = {
        let formatter = CurrencyFormatter()
        formatter.decimalSeparator = .comma
        formatter.thousandSeparator = .dot
        formatter.prefix = .real
        formatter.prefixAttributes = self.attributes(forSize: 16, isBold: false, color: .red)
        formatter.integersAttributes = self.attributes(forSize: 24, isBold: true, color: .blue)
        formatter.decimalsAttributes = self.attributes(forSize: 16, isBold: true, color: .green)
        return formatter
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //lblString.text = formatter.string(from: -1850.98)
        lblString.attributedText = formatter.attributedString(from: -1850.98)
        //lblString.attributedText = formatter.attributedString(from: -0.01)
        //lblString.attributedText = formatter.attributedString(from: -1850.01)
        //lblString.attributedText = formatter.attributedString(from: 1850.08)
        //lblString.attributedText = formatter.attributedString(from: "-10,x1")
        //lblString.text = formatter.string(from: "-10,x1")
        //lblString.text = "\(formatter.double(from: "-10,x1"))" //101
    }
    
    // MARK: Methods

    fileprivate final func attributes(forSize size: Double, isBold: Bool, color: UIColor) -> [NSAttributedString.Key : Any]? {
        let font = isBold ? UIFont.boldSystemFont(ofSize: CGFloat(size)) : UIFont.systemFont(ofSize: CGFloat(size))
        
        return [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color,
        ]
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        lblString.text = "\(formatter.string(from: textField, shouldChangeCharactersIn: range, replacementString: string))"
        
        textField.attributedText = formatter.attributedString(from: textField, shouldChangeCharactersIn: range, replacementString: string)
        
        return false
    }
}
