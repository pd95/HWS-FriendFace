//
//  UserDetail.swift
//  FriendFace
//
//  Created by Philipp on 16.04.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI

struct InformationView: View {

    let header: String
    let information: String
    
    init(_ header: String, _ information: String) {
        self.header = header
        self.information = information
    }
    
    var body: some View {
        HStack {
            Text(header)
                .font(.headline)
            Text(information)
                .font(.body)
            Spacer()
        }
    }
}

struct UserDetail: View {
    @EnvironmentObject var model: Model

    let user: User
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                InformationView("Working for", user.company)
                    .padding(.bottom, 20)
                InformationView("Age:", "\(user.age)")
                    .padding(.bottom, 20)
                InformationView("Email:", "\(user.email)")
                    .padding(.bottom, 20)
                
                Text("About:")
                    .font(.headline)
                Text(user.about)
                    .font(.body)
                    .padding(.bottom, 20)
                
                Text("Friends:")
                    .font(.headline)
                ForEach(user.friends) { friend in
                    NavigationLink(destination: UserDetail(user: self.model.user(for: friend.id)!)) {
                        Text(friend.name)
                    }
                }
                Spacer()
            }
        }
        .padding()
        .navigationBarTitle(user.name)
    }
}

struct UserDetail_Previews: PreviewProvider {
    static var users: [User] = Bundle.main.decode("friendface.json")
    
    static var previews: some View {
        NavigationView {
            UserDetail(user: users.first!)
        }
    }
}
