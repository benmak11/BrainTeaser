//
//  CustomTextField.swift
//  BrainTeaser
//
//  Created by Baynham Makusha on 7/20/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit


@IBDesignable
class CustomTextField: UITextField {
    
    @IBInspectable var inset: CGFloat = 0
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setUpView()
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
        
    }
    
    func setUpView(){
        self.layer.cornerRadius = cornerRadius
    }
}
