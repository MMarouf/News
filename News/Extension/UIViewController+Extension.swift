//
//  UIViewController+Extension.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import UIKit

extension UIViewController {
    static var className: String {
        return String(describing: self)
    }
}
