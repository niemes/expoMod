//
//  StatusBarController.swift
//  expoMod
//
//  Created by Niemeskern Kévin on 3/5/22.
//

import AppKit

extension NSImage.Name {
    static let logo = NSImage.Name("statusBar")
    static let tinyLogo = NSImage.Name("AppIcon")
}

class StatusBarController {
    private var statusBar: NSStatusBar
    private var statusItem: NSStatusItem
    private var popover: NSPopover
    
    init(_ popover: NSPopover) {
        self.popover = popover
        
      print("tinyLogo", NSImage.Name("AppIcon"))
        statusBar = NSStatusBar.init()
        statusItem = statusBar.statusItem(withLength: 28.0)
        
        if let statusBarButton = statusItem.button {
            statusBarButton.image = NSImage(named: .logo)
            statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
            statusBarButton.action = #selector(togglePopover(sender:))
            statusBarButton.target = self
        }
    }
    
    @objc func togglePopover(sender: AnyObject) {
        if(popover.isShown) {
            hidePopover(sender)
        }
        else {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject) {
        if let statusBarButton = statusItem.button {
            popover.behavior = NSPopover.Behavior.transient
            NSApp.activate(ignoringOtherApps: true)
            popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
            
        }
    }

    func hidePopover(_ sender: AnyObject) {
        popover.performClose(sender)
    }
}

