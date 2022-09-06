//
//  HideKeyboard.swift
//  Taskapp
//
//  Created by Benjamin on 05/09/2022.
//

import SwiftUI

#if canImport(UIKit)
extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
