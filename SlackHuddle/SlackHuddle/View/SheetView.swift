//
//  SheetView.swift
//  SlackHuddle
//
//  Created by Mayank Gupta on 24/02/22.
//

import Foundation
import SwiftUI
import HMSSDK



class HomeModel: ObservableObject{
    @Published var showSheet = false
    @Published var tapped = false
}

struct SheetView: View{
    var hmsSDK: HMSSDK
    var user: UserModel
    @Binding var isMute : Bool
    @EnvironmentObject var homeModel: HomeModel
    
    var body: some View{
        
        ZStack{
            Color.gray
            
            VStack{
                HStack {
                    Image(user.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80, alignment: .leading)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.white))
                        .padding()
                    Image("Mayank")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80, alignment: .trailing)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.white))
                        .padding()
                }
                HStack {
                    Button {
                        muteMic()
                    } label: {
                        Image(systemName: isMute ? "mic" : "mic.slash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                            .foregroundColor(.black)
                            .padding()
                    }
                    .frame(width: 35, height: 35, alignment: .center)
                    .background(Color.white)
                    .clipShape(Circle())
                    
                    Button {
                        homeModel.showSheet.toggle()
                    } label: {
                        Image(systemName: "person.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                            .foregroundColor(.black)
                            .padding()
                    }
                    .frame(width: 35, height: 35, alignment: .center)
                    .background(Color.white)
                    .clipShape(Circle())
                    
                    Button {
                        homeModel.showSheet.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18, alignment: .center)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(width: 35, height: 35, alignment: .center)
                    .background(Color.red)
                    .clipShape(Circle())
                }
            }
        }
        .ignoresSafeArea()
    }
    
    
    func muteMic() {
        self.hmsSDK.localPeer?.localAudioTrack()?.setMute(isMute)
        isMute.toggle()
    }
}
