//
//  PillView.swift
//  KrankenCats
//
//  Created by Philip Igboba on 29/01/2025.
//

import SwiftUI

struct CatNumberView: View {
    
    let id: Int
    var body: some View {
        
        Text("#\(id)")
            .font(
                .system(.caption, design: .rounded)
                .bold()
            )
            .foregroundColor(.white)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(Theme.pill, in: Capsule())
        
    }
}

struct CatNumberView_Previews: PreviewProvider {
    static var previews: some View {
        CatNumberView(id: 0)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
