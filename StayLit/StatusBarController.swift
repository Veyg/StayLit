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
    private var timer: Timer?

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

            menu.addItem(NSMenuItem.separator())

            let fifteenMinItem = NSMenuItem(title: "Enable for 15 minutes", action: #selector(enableForFifteenMinutes), keyEquivalent: "")
            fifteenMinItem.target = self
            menu.addItem(fifteenMinItem)

            let thirtyMinItem = NSMenuItem(title: "Enable for 30 minutes", action: #selector(enableForThirtyMinutes), keyEquivalent: "")
            thirtyMinItem.target = self
            menu.addItem(thirtyMinItem)

            let oneHourItem = NSMenuItem(title: "Enable for 1 hour", action: #selector(enableForOneHour), keyEquivalent: "")
            oneHourItem.target = self
            menu.addItem(oneHourItem)
        } else {
            let disableItem = NSMenuItem(title: "Disable", action: #selector(toggleSleep), keyEquivalent: "")
            disableItem.target = self
            menu.addItem(disableItem)
        }
        menu.addItem(NSMenuItem.separator())
        let settingsItem = NSMenuItem(title: "Settings", action: #selector(showSettings), keyEquivalent: ",")
        settingsItem.target = self
        menu.addItem(settingsItem)

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

    @objc func enableForFifteenMinutes() {
        enableFor(duration: 900) // 900 seconds = 15 minutes
    }

    @objc func enableForThirtyMinutes() {
        enableFor(duration: 1800) // 1800 seconds = 30 minutes
    }

    @objc func enableForOneHour() {
        enableFor(duration: 3600) // 3600 seconds = 1 hour
    }

    private func enableFor(duration: TimeInterval) {
        toggleSleep() // Ensure the system is awake

        // Invalidate any existing timer
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
            self?.toggleSleep() // Allow the system to sleep after the duration
        }
    }
    @objc func showSettings() {
        NSApp.activate(ignoringOtherApps: true)
        let windows = NSApplication.shared.windows
        for window in windows {
            if window.contentViewController is NSHostingController<ContentView> {
                window.makeKeyAndOrderFront(nil)
                return
            }
        }
    }

    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
    
}
