//
//  ContentView.swift
//  FriendFace
//
//  Created by Philipp on 16.04.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI


struct UserRow: View {
    let user: StoredUser
    
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

    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: StoredUser.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \StoredUser.name, ascending: true)
    ]) var storedUsers: FetchedResults<StoredUser>
    
    var body: some View {
        NavigationView {
            List(storedUsers) { user in
                NavigationLink(destination: UserDetail(user: user)) {
                    UserRow(user: user)
                }
            }
            .navigationBarTitle("Users")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
