//
//  ContentView.swift
//  ExpoMod App
//
//  Created by Niemeskern Kévin on 3/5/22.
//

import SwiftUI
import Commands
import AppKit

struct Options {
    var id : Int
    var name : String
    var nLabel : String
    var isOn : Bool = false {
        willSet {
            if (self.name == "DarkMode") {
                DarkMode.toggle(force: !self.isOn)
            }
            if (self.name == "SystemeUpdate") {
                SystemeUpdate.toggle(force: self.isOn)
            }
            if (self.name == "notifications") {
                Notifications.toggle(force: !self.isOn)
            }
            if (self.name == "Awake") {
                Awake.toggle(force: !self.isOn)
            }
            if (self.name == "DesktopIcons") {
                DesktopIcons.toggle(force: self.isOn)
            }
            if (self.name == "MenuBar") {
                MenuBar.toggle(force: self.isOn)
            }
        }
    }
}

struct ContentView: View {

    @State private var myOptions: [Options] = [

        Options(
            id: 2,
            name: "SystemeUpdate",
            nLabel: "Deactivate Systeme Update",
            isOn: SystemeUpdate.isEnabled
        ),
        Options(
            id: 3,
            name: "notifications",
            nLabel: "Pause System Notifications",
            isOn: Notifications.isEnabled
        ),
        Options(
            id: 4,
            name: "Awake",
            nLabel: "Keep Awake",
            isOn: Awake.isEnabled
        ),
        Options(
            id: 5,
            name: "DesktopIcons",
            nLabel: "Hide Desktop Icons",
            isOn: DesktopIcons.isEnabled
        ),
        Options(
            id: 6,
            name: "MenuBar",
            nLabel: "Auto hide MenuBar",
            isOn: MenuBar.isEnabled
        ),
        Options(
            id: 7,
            name: "DarkMode",
            nLabel: "Dark Mode",
            isOn: DarkMode.isEnabled
        )
    ]

    @State private var showDetails = false
    @State private var allOptions: Bool = false {
        willSet {
            print("AllOptions= \(allOptions)")
//            let toggleVal: Bool
//            if allOptions {
//              toggleVal = true
//            } else {
//              toggleVal = false
//            }
//
//            Awake.isEnabled = toggleVal
//            DarkMode.isEnabled = toggleVal
//            MenuBar.isEnabled = toggleVal
//            DesktopIcons.isEnabled = toggleVal
//            Notifications.isEnabled = toggleVal
//            SystemeUpdate.isEnabled = toggleVal
        }
    }
    
    @State var showConfigView: Bool = false
    @State var showExitView: Bool = false

    var eventMonitor: EventMonitor?
    
    func showConfigViewFunc() {
        showConfigView.toggle()
    }
    
    func showExitViewFunc() {
      showExitView.toggle()
    }

    var body: some View {
      ZStack(){
        
        ZStack{
          if showExitView {
              exitView(showExitView: $showExitView)
                  .padding(0)
                  .transition(.move(edge: .top))
                  .animation(Animation.spring())
                  .frame(width: 270, height: 370)
                  .offset(y: -20)
          }
        }.edgesIgnoringSafeArea(.all)
          .zIndex(3.0)
          .offset(y:0)
        
        ZStack{
          if showConfigView {
              configView(showConfigView: $showConfigView)
                  .padding(0)
                  .transition(.move(edge: .top))
                  .animation(Animation.spring())
                  .frame(width: 270, height: 370)
                  .offset(y:-20)
          }
        }.edgesIgnoringSafeArea(.all)
          .zIndex(2.0)
          .offset(y:0)

        
          ZStack() {

              VStack() {
                HStack {
                    
                    Spacer()
                    Text("Expo Mod").bold().frame(maxHeight: 20)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(nil)
                                    .padding(.bottom, 5)
                                    .font(.title)
                                    .frame(maxWidth: .infinity)
                    Spacer()

                  if #available(macOS 12.0, *) {
                      Button(action: showConfigViewFunc, label: {
                              Circle()
                              .fill(.ultraThickMaterial)
                                  .frame(width: 25, height: 25) // You can make this whatever size, but keep UX in mind.
                                  .overlay(
                                      Image(systemName: "gear")
                                          .font(.system(size: 15, weight: .bold, design: .rounded)) // This should be less than the frame of the circle
                                          .foregroundColor(.secondary)
                                  )
                          })
                          .buttonStyle(PlainButtonStyle()) // This gives it no designs on idle, but can change on input
                          .accessibilityLabel(Text("Close")) // Keep it accessible
                          .padding(5)
                  } else {
                      // Fallback on earlier versions
                      Button(action: showConfigViewFunc, label: {
                              Text("settings")
                                  .frame(width: 30, height: 30) // You can make this whatever size, but keep UX in mind.
                                  .font(.system(size: 11, weight: .bold, design: .rounded)) // This should be less than the frame of the circle
                                  .foregroundColor(.secondary)
                          })
                          .buttonStyle(PlainButtonStyle()) // This gives it no designs on idle, but can change on input
                  }
                }.frame(maxWidth: .infinity)
//                    .padding(.horizontal, 15)
                    .padding(.top, 15)
                    .padding(.bottom, 5)
                
//                  HStack {
                      Spacer()
////                      Toggle("All options", isOn: $allOptions)
////                          .toggleStyle(SwitchToggleStyle())
//                    Toggle(isOn: $allOptions) {
//                      Text("All Options")
//                    }.toggleStyle(SwitchToggleStyle())
//                  }
//
//                  Divider().padding(.vertical, 4).padding(.horizontal, 30)
                      
                  ForEach(myOptions.indices) { providerIndex  in
                      HStack {
                          Spacer()
                          Toggle(isOn: $myOptions[providerIndex].isOn) {
                            if #available(macOS 11.0, *) {
                              Text("\(myOptions[providerIndex].nLabel.capitalized)")
//                                .help("test label description")
                            } else {
                              // Fallback on earlier versions
                              Text("\(myOptions[providerIndex].nLabel.capitalized)")
                            }
                          }
                          .toggleStyle(SwitchToggleStyle())
                      }
                  }
                Divider().padding(.top, 4).padding(.horizontal, 30)
                HStack {
                  Spacer()
                  if #available(macOS 12.0, *) {
                      Button(action: showExitViewFunc, label: {
                              Circle()
                              .fill(.ultraThickMaterial)
                                  .frame(width: 25, height: 25) // You can make this whatever size, but keep UX in mind.
                                  .overlay(
                                      Image(systemName: "xmark")
                                          .font(.system(size: 12, weight: .bold, design: .rounded)) // This should be less than the frame of the circle
                                          .foregroundColor(.secondary)
                                  )
                          })
                          .buttonStyle(PlainButtonStyle()) // This gives it no designs on idle, but can change on input
                          .accessibilityLabel(Text("Close")) // Keep it accessible
                          .padding(6)
                          .padding(.bottom, 15)
                  } else {
                      // Fallback on earlier versions
                      Button(action: showExitViewFunc, label: {
                              Text("Exit")
//                          .font(.)
                                  .frame(width: 30, height: 30) // You can make this whatever size, but keep UX in mind.
                                  .font(.system(size: 15, weight: .bold, design: .rounded)) // This should be less than the frame of the circle
                                  .foregroundColor(.secondary)
                          })
                          .buttonStyle(PlainButtonStyle()) // This gives it no designs on idle, but can change on input
                          .padding(6)
                  }
                }//.Alignement(.trailing)
              }.padding(.horizontal, 5)
          }.zIndex(1.0)

          
      }
      .animation(Animation.spring())  // one animation to transitions
      .edgesIgnoringSafeArea(.all)
      .frame(width: 270, height: 330)
      .fixedSize(horizontal: true, vertical: true)
    }
        
        
        func closePopover(sender: Any?) {
          print("hide popover")
            eventMonitor?.stop()
        }
        
        //.background(Color.white.edgesIgnoringSafeArea(.all))
        // .frame(minHeight: 120, maxHeight:200)
        
    };

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
