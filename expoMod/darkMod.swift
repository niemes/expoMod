//
//  darkMod.swift
//  expodMod
//
//  Created by Kévin Niemeskern on 10/05/2022.
//

import Foundation
import SwiftUI

@discardableResult
func runAppleScript(_ source: String) -> String? {
    return NSAppleScript(source: source)?.executeAndReturnError(nil).stringValue
}

struct DarkMode {
    private static let prefix = "tell application \"System Events\" to tell appearance preferences to"
    
    static var isEnabled: Bool {
        get {
            if #available(macOS 10.14, *) {
                return NSAppearance.current.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
            } else {
                return UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
            }
        }
        set {
            print("set isEnabled =>", newValue, self.isEnabled)
            toggle(force: newValue)
            
        }
    }
    
    static func toggle(force: Bool? = nil) {
        let value = force.map(String.init) ?? "not dark mode"
        print("value darkmod= \(force ?? false)")
        runAppleScript("\(prefix) set dark mode to \(value)")
    }
}
