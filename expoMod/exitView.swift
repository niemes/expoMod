//
//  exitView.swift
//  expodMod
//
//  Created by Kévin Niemeskern on 14/05/2022.
//

import Foundation
import SwiftUI
import LaunchAtLogin

struct exitView: View {

  @Binding var showExitView: Bool

  func Quit(){
      NSApplication.shared.terminate(self)
      exit(0)
  }

    var body: some View {
      Color.red.edgesIgnoringSafeArea(.all).opacity(1)
        ZStack {
            Spacer()
          if (showExitView) {
            VStack() {
              VStack {
                Text("Would you like to stop ExpoMod ?")
                  .font(.system(size: 20, weight: .bold, design: .rounded))
                  .foregroundColor(Color.black.opacity(0.8))
//                Text("(All options will be set back to your default configuration)")
//                  .font(.system(size: 10, weight: .thin, design: .rounded))
//                  .foregroundColor(Color.black.opacity(0.7))
              }.padding(.horizontal, 15)

              HStack {

                Button {
                  Quit()
                } label: {
                  Text("Yes").padding(17)
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.8))
                    .animation(nil)
                }.padding(22)
                
                Button {
                  showExitView.toggle()
                } label: {
                    Text("No").padding(17).font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.8))
                    .animation(nil)
                }
              }
                
            }.padding(.horizontal, 10)
              .padding(.top, 10)
          }
        }
          .fixedSize(horizontal: false, vertical: false)
          //.background(Color.purple)
    }
        
}

