//
//  Notifications.swift
//  expodMod
//
//  Created by Kévin Niemeskern on 12/05/2022.
//

import Foundation
import SwiftUI
import Commands

struct Notifications {
    private static let testcmd = "defaults -currentHost read ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb"

    static var isEnabled: Bool {
        get {
            let result = Commands.Bash.run("\(testcmd)")
            switch result {
                
            case .Success(_, let response):
                debugPrint("Notifications: \(response.output)")
                if (response.output == "1") {
                    return true
                } else {
                    return false
                }
            case  .Failure(_, let response):
                  debugPrint("Notifications failure output: \(response.errorOutput)")
                return false
            }
        
        }
        set {
            toggle(force: newValue)
        }
    }

    static func toggle(force: Bool? = nil) {
        let value = Int (force! ? 1 : 0)
//        if (force == true) {value = 0}
//        else {value = 1}

        print("value Notifs=", value)
//        let cmd = "defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb \(value); killall NotificationCenter")
        
        Commands.Bash.run("defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb \(value)")
        Commands.Bash.run("defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturbDate -date \"`date -u +\"%Y-%m-%d %H:%M:%S +0000\"`\"")
        Commands.Bash.run("killall NotificationCenter")
//        Commands.Bash.run("\(cmd)")
    }
}
