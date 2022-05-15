//
//  SystemeUpdate.swift
//  expodMod
//
//  Created by Kévin Niemeskern on 10/05/2022.
//

import Foundation
import SwiftUI
import Commands

struct SystemeUpdate {

    private static let testcmd = "defaults read /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled"

    static var isEnabled: Bool {
        get {
            let result = Commands.Bash.run("\(testcmd)")
            switch result {
            case .Success(_, let response):
                debugPrint("SystemeUpdate: \(response.output)")
                if (response.output == "TRUE") {
                    return true
                } else {
                    return false
                }
            case  .Failure(_, let response):
                  debugPrint("SystemeUpdate failure output: \(response.errorOutput)")
                return false
            }
        
        }
        set {
            toggle(force: newValue)
        }
    }

    static func toggle(force: Bool? = nil) {
        let value = force! ? true : false
        print("value SystemeUpdate=", value)

        NSAppleScript(source: "do shell script \"sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool \(value) && sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool \(value) && sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool \(value)\" with administrator " +
            "privileges")!.executeAndReturnError(nil)
    }
}
