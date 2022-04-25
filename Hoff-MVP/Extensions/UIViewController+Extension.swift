//
//  UIViewController+Extension.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 12.04.2022.
//

import Foundation
import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
//    static func instantiateTwo() -> Self {
//        let uiNib = UINib(nibName: DetailVCViewController.identifier, bundle: nil)
//        
//    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
    
    static func instantiateFromNib<T: UIViewController>() -> T {
        // It is going to return YourAppName.YourClassName
        let classDescription = classForCoder().description()
        // Replacing YourAppName with Empty string
        let nibFileName = classDescription.replacingOccurrences(of: "\(Bundle.main.infoDictionary?["CFBundleName"] as! String).", with: String())
        return T.init(nibName: nibFileName, bundle: Bundle.init(for: Self.self))
    }
}
