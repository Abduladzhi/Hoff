//
//  UIView+Extensions.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 12.04.2022.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {return self.cornerRadius}
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
