//
//  LazyView.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 1/14/25.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
