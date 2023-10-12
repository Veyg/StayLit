//
//  StatusBarController.swift
//  StayLit
//
//  Created by Dawid Grochowski on 12/10/2023.
//

import AppKit
import SwiftUI
import IOKit.pwr_mgt

class StatusBarController {
    private var statusBar: NSStatusItem?
    private var assertionID: IOPMAssertionID = 0

    init() {
        statusBar = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        statusBar?.button?.image = NSImage(systemSymbolName: "eye.slash.fill", accessibilityDescription: nil)
        updateMenu()
    }

    private func updateMenu() {
        let menu = NSMenu()

        if assertionID == 0 {
            let enableItem = NSMenuItem(title: "Enable", action: #selector(toggleSleep), keyEquivalent: "")
            enableItem.target = self
            menu.addItem(enableItem)
        } else {
            let disableItem = NSMenuItem(title: "Disable", action: #selector(toggleSleep), keyEquivalent: "")
            disableItem.target = self
            menu.addItem(disableItem)
        }

        menu.addItem(NSMenuItem.separator())
        let quitItem = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q")
        quitItem.target = self
        menu.addItem(quitItem)

        statusBar?.menu = menu
    }

    @objc func toggleSleep() {
        if assertionID == 0 {
            IOPMAssertionCreateWithName(kIOPMAssertionTypeNoDisplaySleep as CFString,
                                        IOPMAssertionLevel(kIOPMAssertionLevelOn),
                                        "Prevent Sleep" as CFString,
                                        &assertionID)
            statusBar?.button?.image = NSImage(systemSymbolName: "eye.fill", accessibilityDescription: nil) // Eye open when on
            statusBar?.button?.title = "On"
        } else {
            IOPMAssertionRelease(assertionID)
            assertionID = 0
            statusBar?.button?.image = NSImage(systemSymbolName: "eye.slash.fill", accessibilityDescription: nil) // Eye closed when off
            statusBar?.button?.title = "Off"
        }

        updateMenu() // Refresh the menu items
    }

    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
