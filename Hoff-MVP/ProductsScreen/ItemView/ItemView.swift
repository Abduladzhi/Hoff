//
//  ItemView.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 12.04.2022.
//

import Foundation
import Foundation
import UIKit

class ItemView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 8
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.1
        cornerRadius = 10
    }
}
