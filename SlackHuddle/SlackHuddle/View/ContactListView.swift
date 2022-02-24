//
//  ContactListView.swift
//  SlackHuddle
//
//  Created by Mayank Gupta on 23/02/22.
//

import SwiftUI

struct ContactListView: View {
    
    @State var contacts = [UserModel(image: "Kritika", name: "Kritika"), UserModel(image: "Arpit", name: "Arpit"),  UserModel(image: "Nilay", name: "Nilay"),  UserModel(image: "Aniket", name: "Aniket"),  UserModel(image: "Kshitij", name: "Kshitij")]

    
    var body: some View {
        NavigationView {
            List(self.$contacts, rowContent: {
                contact in
                NavigationLink(destination: SlackChatView(viewModel: .init(), user: contact.wrappedValue), label: {
                    ContactListCell(user: contact.wrappedValue)
                })
            })
                .navigationBarTitle("100ms", displayMode: .inline).navigationBarItems(leading: Button(action: {}, label: {
                    ZStack {
                        Image("100ms-logo")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .leading)
                    }
                }).buttonStyle(PlainButtonStyle()).frame(width: 25, height: 25, alignment: .center), trailing: Button(action: {}, label: {
                    ZStack {
                        Image(systemName: "pencil.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }))
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}
