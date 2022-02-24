//
//  SheetView.swift
//  SlackHuddle
//
//  Created by Mayank Gupta on 24/02/22.
//

import Foundation
import SwiftUI



class HomeModel: ObservableObject{
    @Published var showSheet = false
    @Published var tapped = false
}


struct SheetView: View{
    
    @EnvironmentObject var homeModel: HomeModel
    
    var body: some View{
        
        ZStack{
            homeModel.tapped ? Color.blue : Color.orange
            
            VStack{
                
                Text(homeModel.tapped ? "Tap Me Again" : "Tap Me")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .onTapGesture {
                        homeModel.tapped.toggle()
                    }
                
                Button {
                    homeModel.showSheet.toggle()
                } label: {
                    Text("End Room")
                        .foregroundColor(.white)
                }
                .padding(10)

            }
        }
        .ignoresSafeArea()
    }
}
