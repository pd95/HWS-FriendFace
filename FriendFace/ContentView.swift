//
//  ContentView.swift
//  FriendFace
//
//  Created by Philipp on 16.04.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI


struct UserRow: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(user.name)
                    .font(.headline)
                Spacer()
                Text("\(user.age)")
            }
            Text(user.company)
                .font(.subheadline)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        NavigationView {
            List(model.allUsers) { user in
                NavigationLink(destination: UserDetail(user: user)) {
                    UserRow(user: user)
                }
            }
            .navigationBarTitle("Users")
            .onAppear(perform: { self.model.fetchUsers() })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
