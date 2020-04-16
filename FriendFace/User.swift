//
//  User.swift
//  FriendFace
//
//  Created by Philipp on 16.04.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let name: String
    let age: Int
    let company: String
    let email: String
    let about: String
    
    struct Friend: Identifiable, Codable {
        let id: UUID
        let name: String
    }
    
    let friends: [Friend]
}


func fetchUsers(completion: @escaping ([User]) -> Void) {
    
    let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!

    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        guard let response = response as? HTTPURLResponse else {
            print("Invalid response (not HTTPURLResponse")
            return
        }
        
        let statusCode = response.statusCode
        let statusText = HTTPURLResponse.localizedString(forStatusCode: statusCode)
        
        if (400...499).contains(statusCode) {
            print("Server respondend with client error: \(statusText) (\(statusCode))")
            return
        }
        else if (500..<599).contains(statusCode) {
            print("Server respondend with server error: \(statusText) (\(statusCode))")
            return
        }
        
        guard let data = data else {
            print("No data received")
            return
        }
        
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            let users = try jsonDecoder.decode([User].self, from: data)
            print("Load \(users.count) users")
            
            DispatchQueue.main.async {
                completion(users)
            }
        } catch {
            print("Error decoding data: \(error)")
        }
    }
    .resume()
}
