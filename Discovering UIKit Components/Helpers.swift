//
//  Color.swift
//  Discovering UIKit Components
//
//  Created by Ambroise COLLON on 23/06/2017.
//  Copyright © 2017 Ambroise Collon. All rights reserved.
//

import UIKit

extension UIColor {
    static var customGray: UIColor {
        return UIColor(red: 191.0/255.0, green: 196.0/255.0, blue: 201.0/255.0, alpha: 1)
    }
    static var customDarkBlue: UIColor {
        return UIColor(red: 87.0/255.0, green: 107.0/255.0, blue: 130.0/255.0, alpha: 1)
    }
    static var customLightBlue: UIColor {
        return UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 200.0/255.0, alpha: 1)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
}
