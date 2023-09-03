//
//  DataController.swift
//  Finding Falcone
//
//  Created by chinmay on 02/09/23.
//

import Foundation


public struct CommonController{
    
    func getToken() {
          ApiService.shared.request(endPoint: Endpoint.token, method: HttpMethod.POST, body: nil, headers: [
              "content-type": "application/json"
          ]) { apiResponse in
              if(apiResponse.responseCode == 200){
                  guard let tokenResponse = try? JSONDecoder().decode(TokenResponse.self, from: apiResponse.data as! Data) else {
                      print("Failed to decode token response")
                      return
                  }
                  let token = tokenResponse.token
                  SharedPreferences.saveToken(value: token)
                  print("Token: \(token)")
              }else{
                  print("Error")
                  print("Failed to fetch token")
              }
          }
      }
    
    func getPlanetData(completion: @escaping (Result<PlanetsResponse, Error>) -> Void) {
        ApiService.shared.request(endPoint: Endpoint.planets, method: HttpMethod.GET, body: nil, headers: [
            "content-type": "application/json"
        ],completion: { apiResponse in
            
            if(apiResponse.responseCode == 200){
                
                do {
                    let planetData = try JSONDecoder().decode(PlanetsResponse.self, from: apiResponse.data as! Data)
                    completion(.success(planetData))
                } catch {
                    completion(.failure(error))
                }
            }else{
                
                let error = NSError(domain: "YourErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                
                completion(.failure(error))
               
                
            }
        })
    }

    func getSpacecraftsData(completion: @escaping (Result<SpacecraftsResponse, Error>) -> Void) {
        ApiService.shared.request(endPoint: Endpoint.vehicles, method: HttpMethod.GET, body: nil, headers: [
            "content-type": "application/json"
        ],completion: { apiResponse in
            
            if(apiResponse.responseCode == 200){
                
                
                do {
                    let spacecraftsData = try JSONDecoder().decode(SpacecraftsResponse.self, from: apiResponse.data as! Data)
                    completion(.success(spacecraftsData))
                } catch {
                    completion(.failure(error))
                }
            }else{

                let error = NSError(domain: "YourErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                completion(.failure(error))

            }
        }) 
    }

    
    func find(planetNames :[String],vehicleNames :[String],completion :@escaping (Result<FindResponse,Error>) -> Void){
        
        var findingResponse  = FindResponse(planetName: nil, status: nil, error: nil)
        
        let findingRequest = FindRequest(token: SharedPreferences.getToken() ?? "empty token", planetNames: planetNames, vehicleNames:vehicleNames )
        
        let encodedBody = try! JSONEncoder().encode(findingRequest)
        
        ApiService.shared.request(endPoint: Endpoint.find, method: HttpMethod.POST, body: encodedBody, headers: [
            "content-type": "application/json"
        ]) { apiResponse in
            
            if(apiResponse.responseCode == 200){
                
                findingResponse = try! JSONDecoder().decode(FindResponse.self, from: apiResponse.data as! Data)

                print("findingResponse: \(findingResponse)")
                
                completion(.success(findingResponse))
                
            }else{
                let error = NSError(domain: "YourErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                completion(.failure(error))

            }
            
            
        }
    }

}
