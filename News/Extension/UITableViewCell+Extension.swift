//
//  UITableViewCell+Extension.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import UIKit

extension UITableViewCell {
    static var resueIdentifier: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: resueIdentifier, bundle: nil)
    }
}
