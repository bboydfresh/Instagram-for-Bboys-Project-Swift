//
//  Extensions.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
