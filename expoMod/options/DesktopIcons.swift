//
//  DesktopIcons.swift
//  expodMod
//
//  Created by Kévin Niemeskern on 12/05/2022.
//

import Foundation
import SwiftUI
import Commands

struct DesktopIcons {
    private static let testcmd = "defaults read com.apple.finder CreateDesktop"

    static var isEnabled: Bool {
        get {
            let result = Commands.Bash.run("\(testcmd)")
            switch result {
            case .Success(_, let response):
                debugPrint("DesktopIcons: \(response.output)")
                if (response.output == "false") {
                    return true
                } else {
                    return false
                }
            case  .Failure(_, let response):
                  debugPrint("DesktopIcons failure output: \(response.errorOutput)")
                return false
            }
        
        }
        set {
            toggle(force: newValue)
        }
    }

    static func toggle(force: Bool? = nil) {
        let runCmd = Commands.Bash.run("defaults write com.apple.finder CreateDesktop \(force ?? false)")
        
        switch runCmd {
            case .Success(_, let response):
                debugPrint("DesktopIcons toggle: \(response.output)")
                Commands.Bash.run("killall Finder")
            case  .Failure(_, let response):
                debugPrint("DesktopIcons toggle Error: \(response.output)")
        }
    }
}

