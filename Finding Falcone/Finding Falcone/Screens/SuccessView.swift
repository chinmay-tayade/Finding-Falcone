//
//  SuccessView.swift
//  Finding Falcone
//
//  Created by chinmay on 02/09/23.
//

import Foundation
import SwiftUI

struct SuccessView: View {
    
    
    @ObservedObject var viewModel: SelectPlanetViewModel
    
    init(viewModel: SelectPlanetViewModel) {
        self.viewModel = viewModel
    }
    
    
    @State private var startAgain = false

    var body: some View {
        
        
        
        
        NavigationStack {
            
          
            
            ZStack{
                
                Image("background")
                              .resizable()
                              .aspectRatio(contentMode: .fill)
                              .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                
                Text(viewModel.successMessage)
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                if(viewModel.status=="success"){
                    
                    Text("Time Taken : \(viewModel.timeTaken) seconds")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                        
                        
                    
                    
                    Text("Planet Found : \(viewModel.planetFound)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                }
                
               
                
                Spacer()
                
                NavigationLink(destination: OnboardingView(), isActive: $startAgain) {
                    
                    Button(action: {
                        
                        startAgain = true
                        
                    }) {
                        Text("Start Again")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .black, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                            .background(Color.black)
                            .cornerRadius(10)
                            .padding(30)
                    }
                    .padding(.top, 20)
                }
            }.onAppear{
                print(viewModel.timeTaken)
                print(viewModel.planetFound)
                print(viewModel.successMessage)
            }
            .padding(20)
        }

        }
            
        
    }
}

struct SuccessViewPreview: PreviewProvider {
    static var previews: some View {
        SuccessView(viewModel: SelectPlanetViewModel())
    }
}

