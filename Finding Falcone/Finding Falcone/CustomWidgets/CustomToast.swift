//
//  CustomToast.swift
//  Finding Falcone
//
//  Created by chinmay on 02/09/23.
//

import Foundation
import SwiftUI

public struct SnackbarView: View {
    let message: String
    @Binding var showSnackbar: Bool
    
   public var body: some View {
        VStack {
            Spacer()
            if showSnackbar {
                Text(message)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(8)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.3))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSnackbar = false
                            }
                        }
                    }
            }
            Spacer()
                .frame(height: 30)
        }
    }
}
