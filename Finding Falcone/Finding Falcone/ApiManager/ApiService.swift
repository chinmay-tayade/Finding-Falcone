//
//  ApiService.swift
//  Finding Falcone
//
//  Created by chinmay on 02/09/23.
//

import Foundation

struct ApiService {
    
    public static let shared = ApiService()
    
    private let urlSession = URLSession.shared
    
   
    
    // MARK: - Private Methods
    
    private func buildURLComponents(endPoint: String, queryParams: [String: Any]) -> URLComponents? {
        guard var urlComponents = URLComponents(string: AppConstants.serverURL + endPoint) else {
            return nil
        }
        
        if !queryParams.isEmpty {
            urlComponents.queryItems = queryParams.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
        }
        return urlComponents
    }
    
    private func buildRequest(url: URL, httpMethod: String, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let sessionConfig = URLSessionConfiguration.default
        request.timeoutInterval = 150
        return request
    }
    
    // MARK: - Public Methods
    
    func request(
        endPoint: String,
        method: String,
        queryParams: [String: Any] = [:],
        body: Data? = nil,
        headers: [String: String] = [:],
        completion: @escaping (BaseResponse) -> Void)
    {
        var response : BaseResponse = BaseResponse()
        
        var urlComponents = buildURLComponents(endPoint: endPoint, queryParams: queryParams)
        if var urlComponents = urlComponents {
            urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }
        var url = urlComponents?.url ?? URL(string: AppConstants.serverURL)!
        let request = buildRequest(url: url, httpMethod: method, body: body)
        
        print("url: \(url)")
        // print body
        if let body = body {
            print("body: \(String(data: body, encoding: .utf8) ?? "")")
        }
        
        var responseData: Data?
        var responseError: Error?
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            responseData = data
            responseError = error
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        // get response status code
        var statusCode: Int?

        if let httpResponse = task.response as? HTTPURLResponse {
            statusCode = httpResponse.statusCode
            print("statusCode: \(httpResponse.statusCode)")
        }
        //print url with query params
        // header
        print("header: \(headers)")
        print("response: \(String(data: responseData ?? Data(), encoding: .utf8) ?? "")")
         
        
        guard let data = responseData else {
            response = BaseResponse(
                status: false,
                data: nil,
                errorMessage: "Something went wrong,Please try again later",
                responseCode: statusCode
            )
            completion(response) // Invalid Data
           return
        }
        
        response = BaseResponse(
            data: data,
            responseCode: statusCode
        )
        
        completion(response)
    }

}

public struct BaseResponse{
    public var status:Bool?
    public var data: Any?
    public var errorMessage:String?
    public var responseCode:Int?
}


