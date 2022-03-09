//
//  SlackChatView.swift
//  SlackHuddle
//
//  Created by Mayank Gupta on 23/02/22.
//

import SwiftUI
import HMSSDK

struct SlackChatView: View {
    
    var hmsSDK = HMSSDK.build()
    @State var localTrack : HMSAudioTrack?
    @State var friendTrack : HMSAudioTrack?
    let tokenProvider = TokenProvider()
    @StateObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    
    @State var isMuted: Bool = false
    @State var user: UserModel?
    @State var chatText: String = ""
    @StateObject var homeModel = HomeModel()
    
    var body: some View {
        Spacer()
        audioRoomOptions
            .padding(.bottom, 10)
        
    }

    func muteMic() {
        self.hmsSDK.localPeer?.localAudioTrack()?.setMute(isMuted)
        isMuted.toggle()
    }
    
    func leaveRoom() {
        hmsSDK.leave { didEnd, error in
            if didEnd {
                self.presentationMode.wrappedValue.dismiss()
            } else {
                
            }
        }
    }

    func endRoom() {
        hmsSDK.endRoom(lock: false, reason: "Meeting has ended") { didEnd, error in
            if didEnd {
                self.presentationMode.wrappedValue.dismiss()
            } else {
                
            }
        }
    }
    
    func listen() {
        self.viewModel.addAudioView = {
            track in
            hmsSDK.localPeer?.localAudioTrack()?.setMute(false)
            self.localTrack = hmsSDK.localPeer!.localAudioTrack()!
            self.friendTrack = track
        }
        
        self.viewModel.removeAudioView = {
            track in
            self.friendTrack = track
        }
    }
    
    
    func joinRoom() {
        tokenProvider.getToken(for: "6215f1897a9d04e28c60b260", role: "speaker") {
            token, error in
            let config = HMSConfig(userName: "Mayank", authToken: token!)
            hmsSDK.join(config: config, delegate: self.viewModel)
        }
    }

    
    var audioRoomOptions: some View {
        ZStack(alignment: .bottom){
            chatBottomBar
                .background(Color(.systemBackground).ignoresSafeArea())
        }

        .navigationBarTitle(user?.name ?? "", displayMode: .inline).navigationBarItems(trailing: Button(action: {homeModel.showSheet.toggle()
            joinRoom()
            listen()
        }, label: {
            ZStack {
                Image(systemName: "beats.headphones").resizable()
            }
        }).buttonStyle(PlainButtonStyle()).frame(width: 25, height: 25, alignment: .center))
        .halfSheet(showSheet: $homeModel.showSheet) {
            SheetView(user: user!, isMute: $isMuted)
                .environmentObject(homeModel)
            
            
        } onEnd: {
            endRoom()
            print("Dismissed")
        }
    }
    
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))
            ZStack {
                DescriptionPlaceholder()
                TextEditor(text: $chatText)
                    .opacity(chatText.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)
            
            Button {
                
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .cornerRadius(4)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }

    
}


private struct DescriptionPlaceholder: View {
    var body: some View {
        HStack {
            Text("Description")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
                .padding(.leading, 5)
                .padding(.top, -4)
            Spacer()
        }
    }
}

extension SlackChatView {
    class ViewModel: ObservableObject, HMSUpdateListener {
        
        @Published var addAudioView: ((_ audioView: HMSAudioTrack) -> ())?
        @Published var removeAudioView: ((_ audioView: HMSAudioTrack) -> ())?
        
        func on(join room: HMSRoom) {
            
        }
        
        func on(room: HMSRoom, update: HMSRoomUpdate) {
            
        }
        
        func on(peer: HMSPeer, update: HMSPeerUpdate) {
            
        }
        
        func on(track: HMSTrack, update: HMSTrackUpdate, for peer: HMSPeer) {
            switch update {
            case .trackAdded:
                if let audioTrack = track as? HMSAudioTrack {
                    addAudioView?(audioTrack)
                }
            case .trackRemoved:
                if let audioTrack = track as? HMSAudioTrack {
                    removeAudioView?(audioTrack)
                }
            default:
                break
            }
        }
        
        func on(error: HMSError) {
            
        }
        
        func on(message: HMSMessage) {
            
        }
        
        func on(updated speakers: [HMSSpeaker]) {
            
        }
        
        func onReconnecting() {
            
        }
        
        func onReconnected() {
            
        }
        
    }
}

