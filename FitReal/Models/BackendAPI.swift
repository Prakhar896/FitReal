//
//  BackendAPI.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import Foundation

struct BackendAPI {
    // Backend Server URL
    let serverURLString: String = "http://localhost:8000"
    let apiKey: String = "realfit@t13.NYP2023"
    
    func createUser(appUser: FRUser) async -> Bool {
        let endpointURLString = serverURLString.appending("/create_user")
        guard let url = URL(string: endpointURLString) else {
            print("CREATEUSER ERROR: Bad URL: \(endpointURLString)")
            return false
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "APIKey")
        
        var bodyData: Data? = nil
        do {
            bodyData = try JSONEncoder().encode(appUser)
        } catch {
            print("CREATEUSER ERROR: \(error.localizedDescription)")
            return false
        }
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: bodyData!)
            
            let decodedResponse = String(data: data, encoding: .utf8) ?? "Failed to decode response."
            print("CREATEUSER BACKEND RESPONSE: \(decodedResponse)")
            return true
        } catch {
            print("CREATEUSER ERROR: \(error.localizedDescription)")
            return false
        }
    }
}
