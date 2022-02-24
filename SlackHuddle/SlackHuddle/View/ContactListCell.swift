//
//  ContactListCell.swift
//  SlackHuddle
//
//  Created by Mayank Gupta on 23/02/22.
//

import SwiftUI

struct ContactListCell: View {
    var user: UserModel
    var body: some View {
        HStack(spacing: 20) {
            Image(user.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            Text(user.name)
                .bold()
        }
        
    }
}

