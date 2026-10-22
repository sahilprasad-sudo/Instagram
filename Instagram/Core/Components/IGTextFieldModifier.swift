//
//  IGTextFieldModifier.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Custom TextField Modifier
/// Login aur Sign-Up screens ke saare TextFields ko ek jaisa Instagram style dene ke liye custom modifier.
/// Bar-bar `.padding()`, `.background()`, `.cornerRadius()` likhne ki jagah sirf `.modifier(IGTextFieldModifier())` use kar sakte hain.
struct IGTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.gray.opacity(0.2))
            .foregroundStyle(Color.black)
            .cornerRadius(20)
            .padding(.horizontal, 20)
    }
}

// MARK: - Custom Primary Button Modifier
/// Login aur Sign-Up ke blue buttons ke liye reusable styling modifier.
struct IGPrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.blue)
            .cornerRadius(20)
            .padding(.horizontal, 20)
    }
}
