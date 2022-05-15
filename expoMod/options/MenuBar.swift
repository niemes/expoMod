//
//  MenuBar.swift
//  expodMod
//
//  Created by Kévin Niemeskern on 12/05/2022.
//

import Foundation
import SwiftUI
import Commands

struct MenuBar {
    private static let testcmd = "defaults read NSGlobalDomain _HIHideMenuBar -bool"

    static var isEnabled: Bool {
        get {
            let result = Commands.Bash.run("\(testcmd)")
            switch result {
            case .Success(_, let response):
                debugPrint("MenuBar: \(response.output)")
                if (response.output == "1") {
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
        let value = force! ? false : true
//        print("value menuBar=", value)

        let checkMenuBarScript = """
        tell application "System Events"
        tell dock preferences to set autohide menu bar to not autohide menu bar
        end tell
        """
      NSAppleScript(source: checkMenuBarScript)!.executeAndReturnError(nil)
    }
}

