//
//  Awake.swift
//  expodMod
//
//  Created by Kévin Niemeskern on 10/05/2022.
//

import Foundation
import SwiftUI
import Commands
import CaffeineKit

let caf = Caffeination(withOpts: [.idle, .display])

struct Awake {
    
    private static let testcmd = "defaults read /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled"

    static var isEnabled: Bool {
        get {
                do {
                    try caf.start()
                    return true
                } catch {
                    caf.stop()
                    return false
                }
        }
        set {
            toggle(force: newValue)
        }
    }

    static func toggle(force: Bool? = nil) {
//        print("value darkmod=", force)
        if (force == true) {
            do {
                try caf.start()
            } catch {
                caf.stop()
            }
        } else {
            caf.stop()
        }
    }

}
