//
//  ContentView.swift
//  Finding Falcone
//
//  Created by chinmay on 01/09/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var start = false
    @State private var showDialog = false
    @State private var showToast = false
    @State private var enableButton = false
    @State private var message = ""
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    
   

    var body: some View {

        NavigationStack {
            
            
            VStack {
                
                NavigationLink("",destination: SelectPlanetView(onboardingViewModel: onboardingViewModel),isActive: $start).navigationBarBackButtonHidden()
                    .navigationBarHidden(true)
                
                Text("Finding Falcone!")
                    .foregroundColor(Color.black)
                    .font(.system(size: 30,weight: .heavy))
                    .fontDesign(.rounded)
                    .font(.title)
               
                Spacer()
                
                Image("Falcon")
                    .resizable()
                    .clipped()
                    .scaledToFit()
                
                Spacer()
                   
               
                Button(action: {
                  
                    if(enableButton){
                        
                        start = true
                    }else{
                        
                        showToast = true
                        message = "button is disabled due to empty api response"
                        
                    }
                   
                   
                }) {
                    Text("Start")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .black, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                
                Spacer()
                    
            }.padding(20)
                .onAppear{
                    
                    showDialog = true
                    
                    CommonController().getToken()
                   
                    CommonController().getPlanetData { result in
                        switch result {
                        case .success(let response):
                          
                            onboardingViewModel.planetResponse = response
                            
                            onboardingViewModel.planetResponse.forEach({ planet in
                                
                                onboardingViewModel.planetList.append(planet.name)
                            })
                            
                            print(onboardingViewModel.planetList)
                            print(onboardingViewModel.planetResponse)
                            print("done")
                    
                            
                        case .failure(let error):
                            print("Error fetching planet data: \(error)")
                         
                            showToast = true
                            message = error.localizedDescription
                            
                        }
                    }
                 
                    
                 
                    CommonController().getSpacecraftsData { result in
                        switch result {
                           
                            
                        case .success(let response):
                          
                            onboardingViewModel.spacecraftResponse = response
                            
                            onboardingViewModel.spacecraftResponse.forEach({ vehicle in
                                
                                onboardingViewModel.vehicleList.append(vehicle.name!)
                            })
                            
                            print(onboardingViewModel.spacecraftResponse)
                            print(onboardingViewModel.vehicleList)
                            print("done")
                            
                        
                            showDialog = false
                            enableButton = true
                            
                        case .failure(let error):
                            print("Error fetching spacecraft data: \(error)")
                        
                            showDialog = false
                            
                            showToast = true
                            message = error.localizedDescription
                            
                            
                        
                           
                        }
                    }

                    
                   
                   
                }.overlay(content: {
                    CustomDialog(isPresented:$showDialog )
                })
                .overlay(content: {
                    SnackbarView(message: message, showSnackbar: $showToast)
                })
            
           

        }
            .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
        
    }

}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
