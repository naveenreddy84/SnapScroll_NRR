//
//  Extensions.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 11/9/24.
//

import UIKit
extension UIApplication{
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
