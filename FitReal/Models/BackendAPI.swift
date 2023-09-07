//
//  BackendAPI.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import Foundation

struct BackendAPI {
    // Backend Server URL
    let serverURLString: String = "http://172.26.186.149:8000"
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
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            
            bodyData = try encoder.encode(appUser)
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
    
    func fetchUser(fireAuthID: String) async -> FRUser? {
        let endpointURLString = serverURLString.appending("/fetch_user")
        guard let url = URL(string: endpointURLString) else {
            print("CREATEUSER ERROR: Bad URL: \(endpointURLString)")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "APIKey")
        
        let body = ["userID": fireAuthID]
        var bodyData: Data? = nil
        
        do {
            bodyData = try JSONEncoder().encode(body)
        } catch {
            print("FETCHUSER ERROR: \(error.localizedDescription)")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: bodyData!)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let decodedAppUser = try decoder.decode(FRUser.self, from: data)
            return decodedAppUser
        } catch {
            print("FETCHUSER ERROR: \(error.localizedDescription)")
            return nil
        }
    }
    
    func updateNextWorkout(datetime: Date, fireAuthID: String) async {
        let endpointURLString = serverURLString.appending("/next_workout")
        guard let url = URL(string: endpointURLString) else {
            print("UPDATENEXTWORKOUT ERROR: Bad URL: \(endpointURLString)")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "APIKey")
        
        struct RequestBody: Codable {
            var userID: String
            var nextWorkoutDatetime: Date
        }
        let reqeustBody = RequestBody(userID: fireAuthID, nextWorkoutDatetime: datetime)
        var bodyData: Data? = nil
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            bodyData = try encoder.encode(reqeustBody)
        } catch {
            print("UPDATENEXTWORKOUT ERROR: \(error.localizedDescription)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: bodyData!)
            
            let response = String(data: data, encoding: .utf8)
            if let response = response {
                if response == "Success" {
                    print("UPDATENEXTWORKOUT: Updated next workout trigger datetime on backend.")
                } else {
                    print("UPDATENEXTWORKOUT ERROR: Response: \(response)")
                }
            } else {
                print("UPDATENEXTWORKOUT ERROR: Failed to decode response.")
            }
        } catch {
            print("UPDATENEXTWORKOUT ERROR: \(error.localizedDescription)")
            return
        }
    }
}
