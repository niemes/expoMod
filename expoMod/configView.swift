//
//  Options.swift
//  expodMod
//
//  Created by Kévin Niemeskern on 3/5/22.
//

import Foundation
import SwiftUI
import LaunchAtLogin

let version = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

struct configView: View {

    @Binding var showConfigView: Bool
    
    func showConfigViewBack() {
      showConfigView.toggle()
    }

    var body: some View {
      if #available(macOS 12.0, *) {
        Color.indigo.edgesIgnoringSafeArea(.all)
      } else {
        Color.orange.edgesIgnoringSafeArea(.all)
      }

      ZStack(alignment: .center) {
            Spacer()
          if (showConfigView) {
            VStack() {

                if #available(macOS 12.0, *) {
                    Button(action: showConfigViewBack, label: {
                            Circle()
                        .fill(Color.black.opacity(0.2))
                                .frame(width: 45, height: 45)
                                .overlay(
                                    Image(systemName: "arrow.up")
                                        .font(.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundColor(.secondary)
                                )
                        })
                        .buttonStyle(PlainButtonStyle())
                        .accessibilityLabel(Text("Back")) // Keep it accessible
                        .padding(5)
                } else {
                    // Fallback on earlier versions
                    Button(action: showConfigViewBack, label: {
                            Text("Back")
                                .frame(width: 45, height: 45)
                                .font(.system(size: 11, weight: .bold, design: .rounded))
                                .foregroundColor(.secondary)
                        })
                        .buttonStyle(PlainButtonStyle())
                }

              Text("ExpoMod Options").font(.title)
              HStack{
                Image("frontLogo")
                  .padding(5)
                  Text("Version \(shortVersion) Build:(\(version))").font(.subheadline).padding(.vertical, 4)
              }
              
              VStack{
                LaunchAtLogin.Toggle {
                    Text("Launch at login")
                }
              }
              Spacer()
              
              HStack(alignment: .bottom){

                if #available(macOS 11.0, *) {
                    Text("Created with").font(.subheadline)
                    Image(systemName: "heart.fill").foregroundColor(.red)
                    Text("by").font(.subheadline)
                    Link("Niemeskern Kevin",destination: URL(string: "https://niemes.info/")!)
                      .font(.subheadline)
                      .foregroundColor(.blue)
                } else {
                  Text("Created with <3 by Niemeskern Kevin").padding(10).font(.subheadline)
                }

              }.padding(.top, 60).padding(.bottom, 4)

            }.padding(.top)
          }
        }
          .fixedSize(horizontal: false, vertical: true)
          //.background(Color.purple)
    }

}

