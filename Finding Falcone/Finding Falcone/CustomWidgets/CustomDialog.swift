//
//  CustomDialog.swift
//  Finding Falcone
//
//  Created by chinmay on 02/09/23.
//

import Foundation
import SwiftUI

struct CustomDialog: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.9).edgesIgnoringSafeArea(.all) // Translucent background
            VStack(spacing: 25) {
                Text("Please wait...")
                    .font(.headline)
                    .foregroundColor(.black)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(1.5)
            }
            .padding(.horizontal,40)
            .padding(.vertical,20)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 2)
        }
        .opacity(isPresented ? 1 : 0) // Show/hide the dialog based on isPresented
                .animation(.default) // Add animation for smooth appearance/disappearance

    }
}

