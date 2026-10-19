//
//  IGTextFieldModifier.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import Foundation
import SwiftUI

struct IGTextFieldModifier:ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.gray.opacity(0.2))
            .foregroundStyle(Color.black)
            .cornerRadius(20)
            .padding(.horizontal,20)
    }
}
