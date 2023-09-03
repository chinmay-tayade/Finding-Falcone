//
//  SelectPlanetView.swift
//  Finding Falcone
//
//  Created by chinmay on 01/09/23.
//

import Foundation
import SwiftUI

struct SelectPlanetView: View {
    
    //
    //    @State private var destinationOptions = ["Donlon", "Enchai", "Jebing", "Sapir", "Lerbin", "Pingasor"]
    //    @State private var vehicleOptions = ["Space Pod", "Space Rocket", "Space Shuttle", "Space Ship"]
    //
    @ObservedObject var onboardingViewModel :OnboardingViewModel
    
    init(onboardingViewModel :OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    
    
    @State private var vehicleSelected1 :String? = ""
    @State private var vehicleSelected2 :String? = ""
    @State private var vehicleSelected3 :String? = ""
    @State private var vehicleSelected4 :String? = ""
    @State private var errorMessage :String? = ""
    @State private var vehicleSelectedArray = Array(repeating: "", count: 4)
    @State private var planetSelectedArray = Array(repeating: "", count: 4)

    
    @State private var selectedDestination1 :String? = ""
    @State private var selectedDestination2 :String? = ""
    @State private var selectedDestination3 :String? = ""
    @State private var selectedDestination4 :String? = ""
    @State private var  showSnackBar  = false
    
    
    
    
    @State private var isButtonClicked :Bool = false
    @State private var gotoHomeScreen :Bool = false
    @State private var showError :Bool = false
    @State private var showSuccessScreen :Bool = false
    @State private var responseSuccess :FindResponse = FindResponse(planetName: nil, status: nil, error: nil)
    
    @StateObject private var viewModel = SelectPlanetViewModel()
    @State private var timeTaken :String = ""
    
    
    
    
    
    
    
    var body: some View {
        NavigationStack {
            
            
            
            HStack(spacing:10) {
                
                NavigationLink(destination: OnboardingView(), isActive: $gotoHomeScreen) {
                    EmptyView()
                }.navigationBarHidden(true)
                
                
                Button(action: {
                    
                    gotoHomeScreen = true
                    
                }) {
                    Image(systemName: "house.fill") // You can use any home icon you prefer
                        .foregroundColor(.black)
                        .font(.system(size: 20,weight: .medium))
                    
                }
                
                Spacer()
                
                Text("Finding Falcone!")
                    .foregroundColor(Color.black)
                    .font(.system(size: 20,weight: .heavy))
                    .fontDesign(.rounded)
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    selectedDestination1 = ""
                    selectedDestination2 = ""
                    selectedDestination3 = ""
                    selectedDestination4 = ""
                    vehicleSelected1 = ""
                    vehicleSelected2 = ""
                    vehicleSelected3 = ""
                    vehicleSelected4  = ""
                }) {
                    Text("Reset")
                        .foregroundColor(.black)
                        .font(.system(size: 16,weight: .black))
                        .fontDesign(.rounded)
                    
                }
            }
            .padding(.horizontal)
            .onAppear{
                
                
            }
            
            ScrollView{
                
                
                
                VStack(alignment: .leading, spacing: 13) {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Select Planets you want to search in.... :")
                    }
                    
                    VStack(alignment:.leading){
                        
                        
                        Text("Destination 1 :")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .medium))
                            .fontDesign(.rounded)
                        
                        
                        CustomDropdown(title: "Planet :", options: onboardingViewModel.planetList, selectedOption: $selectedDestination1)
                            .onChange(of: selectedDestination1) { newValue in
                                
                                if(checkPlanetIsAvialable(planet: selectedDestination1 ?? "")){
                                    planetSelectedArray[0] = newValue ?? ""
                                }else{
                                    
                                    selectedDestination1 = ""
                                    showError = true
                                    errorMessage = "Planet Already Selected"
                                }
                                
                            }
                        
                        CustomDropdown(title: "Vehicle :", options: onboardingViewModel.vehicleList, selectedOption: $vehicleSelected1)
                            .onChange(of: vehicleSelected1) { newValue in
                                
                               
                                print("selectedDestination1\(selectedDestination1)")
                                print("vehicle1\(newValue)")
                                
                                    checkAvialable(vehicle: newValue,planet:selectedDestination1) { boolValue in
                                        
                                        if(boolValue){
                                            
                                            vehicleSelectedArray[0] =  newValue!
                                        }
                                        else{
                                            
                                            vehicleSelected1 = ""
                                            
                                        }
                                    }
   
                        }
                    }
                    
                    
                    
                    VStack(alignment:.leading){
                        
                        
                        Text("Destination 2 :")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .medium))
                            .fontDesign(.rounded)
                        
                        
                        CustomDropdown(title: "Planet :", options: onboardingViewModel.planetList, selectedOption: $selectedDestination2)
                            .onChange(of: selectedDestination2) { newValue in
                            
                                if(checkPlanetIsAvialable(planet: selectedDestination2 ?? "")){
                                    planetSelectedArray[1] = newValue ?? ""
                                }else{
                                    
                                    showError = true
                                    selectedDestination2 = ""
                                    errorMessage = "Planet Already Selected"
                                }
                                
                        }
                        
                        CustomDropdown(title: "Vehicle :", options: onboardingViewModel.vehicleList, selectedOption: $vehicleSelected2).onChange(of: vehicleSelected2) { newValue in
                          
                            checkAvialable(vehicle: newValue,planet: selectedDestination2) { boolValue in

                                if(boolValue){
                                    
                                    vehicleSelectedArray[1] =  newValue!
                                }
                                else{
                                    
                                    vehicleSelected2 = ""
  
                                }
                            }
                            
                           
                        }
                    }
                    
                    
                    
                    VStack(alignment:.leading){
                        
                        
                        Text("Destination 3 :")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .medium))
                            .fontDesign(.rounded)
                        
                        
                        CustomDropdown(title: "Planet :", options: onboardingViewModel.planetList, selectedOption: $selectedDestination3)
                            .onChange(of: selectedDestination3) { newValue in
                                
                                if(checkPlanetIsAvialable(planet: selectedDestination3 ?? "")){
                                    planetSelectedArray[2] = newValue ?? ""
                                }else{
                                    
                                    showError = true
                                    selectedDestination3 = ""
                                    errorMessage = "Planet Already Selected"
                                }
                                
                            }
                        
                        CustomDropdown(title: "Vehicle :", options: onboardingViewModel.vehicleList, selectedOption: $vehicleSelected3)
                            .onChange(of: vehicleSelected3) { newValue in
                            
                                checkAvialable(vehicle: newValue,planet: selectedDestination3) { boolValue in
                                    
                                    if(boolValue){
                                        
                                        vehicleSelectedArray[2] =  newValue!
                                    }
                                    else{

                                        vehicleSelected3 = ""
                                        
                                    }
                                }
                                
                    
                            }
                    }
                    
                    
                    
                    VStack(alignment:.leading){
                        
                        
                        Text("Destination 4 :")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .medium))
                            .fontDesign(.rounded)
                        
                        
                        CustomDropdown(title: "Planet :", options: onboardingViewModel.planetList, selectedOption: $selectedDestination4)
                            .onChange(of: selectedDestination4) { newValue in
                                
                                if(checkPlanetIsAvialable(planet: selectedDestination4 ?? "")){
                                    planetSelectedArray[3] = newValue ?? ""
                                }else{
                                    
                                    showError = true
                                    selectedDestination4 = ""
                                    errorMessage = "Planet Already Selected"
                                }
                                
                            }
                        
                        CustomDropdown(title: "Vehicle :", options: onboardingViewModel.vehicleList, selectedOption: $vehicleSelected4).onChange(of: vehicleSelected4) { newValue in
                           
                            checkAvialable(vehicle: newValue,planet: selectedDestination4) { boolValue in

                                if(boolValue){
                                    
                                    vehicleSelectedArray[3] =  newValue!
                                }
                                else{

                                    vehicleSelected4 = ""
                                    
                                }
                            }
                       
                        }
                    }
                    
                    
                    Text("Time Taken: \(timeTaken)")
                    
                    
                    
                    NavigationLink(destination: SuccessView(viewModel: viewModel),isActive: $showSuccessScreen) {
                        
                        Button(action: {
                            
                            findFalcone()
                            
                        }) {
                            Text("Find Falcone!")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .black, design: .rounded))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        .padding(.top, 20)
                    }
                    
                    
                    
                }.padding(20).onAppear{
                    
                    print(onboardingViewModel.planetList)
                    print(onboardingViewModel.vehicleList)
                    print(onboardingViewModel.planetResponse)
                    print(onboardingViewModel.spacecraftResponse)
                    
                }.alert(isPresented: $showError) {
                    Alert(title: Text("Ohh No.."), message: Text(errorMessage ?? "Unknown Error"), dismissButton: .default(Text("OK")))
                }
                .overlay {
                    SnackbarView(message: "Please plan for all destinations..", showSnackbar: $showSnackBar)
                }
                
            }
            
            
        }
        
    }
    
    private func checkPlanetIsAvialable(planet:String)->Bool{
        
        var returnBool = true
      
        if(planet.isEmpty){
            
            return true
        }else{
            
            
            planetSelectedArray.forEach { element in
                if(element == planet){
                    returnBool = false
                }
            }
            
            
            return returnBool
        }
    }
    
    private func findFalcone(){

            var disable = false
            
            vehicleSelectedArray.forEach { element in
                
                if(element==""){
                    disable = true
                }
            }
            
            if(disable){
                
               showSnackBar = true
                
                
            }else{

                    CommonController().find(planetNames: planetSelectedArray, vehicleNames: vehicleSelectedArray, completion: { result in
                        
                        switch result{
                            
                        case .success(let response) :
                            
                            if(response.status == "success"){
                                
                                viewModel.successMessage = "Success! Congratulations on Finding Falcone. King Shan is mighty pleased."
                                
                                viewModel.planetFound = response.planetName ?? "NO PLANET FOUND"
                                
                               
                                viewModel.status = "success"
                                
                                showSuccessScreen = true
                                
                            }else {
                                
                                viewModel.successMessage = "Ohh no! Lets Try Again..."
                                viewModel.status = "false"
                                
                                showSuccessScreen = true
                            }
                            
                        case .failure(let error) :
                            
                            viewModel.successMessage = "Ohh no! Lets Try Again..."
                            viewModel.status = "false"
                            
                            showSuccessScreen = true
                            
                        }
    
                    })
   
            }
  
    }
    
    private func checkAvialable(vehicle :String?,planet:String?,onCompletion:@escaping (Bool)->Void){

        if(vehicle == ""){

            onCompletion(false)
            
        }else if(planet == ""){
            
            showError = true
            errorMessage = "First select a Planet"
            onCompletion(false)
            
        }else{
            
            
            
            var selectedSpacecraft = Spacecraft(name: nil, totalNo:nil , maxDistance: nil, speed:nil)
            
            var selectedPlanet = Planet(name: "", distance: 0)
            
            var seletedcount = 0
            
            onboardingViewModel.planetResponse.forEach { element in
                if(element.name ==  planet){
                    selectedPlanet = element
                }
            }
            
            onboardingViewModel.spacecraftResponse.forEach { spacecraft in
                if(spacecraft.name == vehicle){
                    selectedSpacecraft = spacecraft
                }
            }

            vehicleSelectedArray.forEach { craft in
                if(craft == vehicle){
                    seletedcount = seletedcount + 1
                }
            }
     
            if(selectedPlanet.distance > selectedSpacecraft.maxDistance!){
                
                errorMessage = "this spacecraft will not reach the planet"
                showError = true
                onCompletion(false)
                
                
            }else if (selectedSpacecraft.totalNo ?? 0 <= seletedcount ){
                
                errorMessage = "Spacecraft out of stock"
                showError = true
                
               onCompletion(false)
                
            }else{
                
                calculateTotalTimeTaken()
                
                onCompletion(true)
            }
        }
    }
    
   
    
    private func calculateTotalTimeTaken() -> String {
        var totalTime: Double = 0.0

        // Define a function to calculate time for a given destination and vehicle
        func calculateTime(destination: String, vehicle: String) -> Double {
            var distance = 0
            var speed = 0

            // Find the distance for the selected destination

            onboardingViewModel.planetResponse.forEach { planet in
                distance = planet.distance
            }


            onboardingViewModel.spacecraftResponse.forEach { spacecraft in
                speed = spacecraft.speed!
                
            }

            // Check if either distance or speed is zero (invalid selection)
            if distance == 0 || speed == 0 {
                // Handle invalid selection here, you can return an error message or a placeholder value
                return 0.0
            }

            // Calculate time for this combination
            return Double(distance) / Double(speed)
        }

        // Calculate times for t1, t2, t3, and t4 only when both selectedDestination and vehicleSelected are not empty
        if !(selectedDestination1?.isEmpty ?? false) && !(vehicleSelected1?.isEmpty ?? false) {
            let t1 = calculateTime(destination: selectedDestination1!, vehicle: vehicleSelected1!)
            totalTime += t1
        }

        if !(selectedDestination2?.isEmpty ?? false) && !(vehicleSelected2?.isEmpty ?? false) {
            let t2 = calculateTime(destination: selectedDestination2!, vehicle: vehicleSelected2!)
            totalTime += t2
        }

        if !(selectedDestination3?.isEmpty ?? false) && !(vehicleSelected3?.isEmpty ?? false) {
            let t3 = calculateTime(destination: selectedDestination3!, vehicle: vehicleSelected3!)
            totalTime += t3
        }
        
        if !(selectedDestination4?.isEmpty ?? false) && !(vehicleSelected4?.isEmpty ?? false) {
            let t4 = calculateTime(destination: selectedDestination4!, vehicle: vehicleSelected4!)
            totalTime += t4
        }

        timeTaken = String(totalTime)
        viewModel.timeTaken = String(totalTime)
        return String(format: "%.2f", totalTime)
    }

    
}



struct SelectPlanetView_Previews: PreviewProvider {
    static var previews: some View {
       SelectPlanetView(onboardingViewModel: OnboardingViewModel())
    }
}
