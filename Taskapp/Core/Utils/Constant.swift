//
//  Constant.swift
//  Taskapp
//
//  Created by Benjamin on 04/07/2022.
//

import SwiftUI

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter;
}()

var backgroundGradient: LinearGradient {
    return LinearGradient(colors: [Color.pink, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
}
