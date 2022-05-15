//
//  AppDelegate.swift
//  expoMod
//
//  Created by Kevin Niemeskern on 3/5/22.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusBar: StatusBarController?
    var popover = NSPopover.init()
    
    var statusBarItem: NSStatusItem!
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let contentView = ContentView()

        popover.contentSize = NSSize(width: 270, height: 330)
        popover.contentViewController = NSHostingController(rootView: contentView)

        statusBar = StatusBarController.init(popover)
        
        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
}

