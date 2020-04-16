//
//  Model.swift
//  FriendFace
//
//  Created by Philipp on 16.04.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import Foundation
import SwiftUI

class Model: ObservableObject {

    @Published var allUsers = [User]()
    
    init() {
        allUsers = Bundle.main.decode("friendface.json")
    }
    
    func user(for id: UUID) -> User? {
        let user = allUsers.first { $0.id == id }
        if user == nil {
            print("No user found for id \(id)")
        }
        return user
    }
    
    func fetchUsers() {
        
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
                    self.allUsers = users
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        .resume()
    }
}

