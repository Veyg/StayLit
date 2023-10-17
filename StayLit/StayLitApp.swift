//
//  StayLitApp.swift
//  StayLit
//
//  Created by Dawid Grochowski on 12/10/2023.
//
import SwiftUI
import AppKit

@main
struct StayLitApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarController: StatusBarController?
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        hideFromDock()
        
        statusBarController = StatusBarController()
        
        if let window = NSApplication.shared.windows.first {
            window.styleMask.remove(.resizable)
            window.styleMask.insert(.titled)
            window.setContentSize(NSSize(width: 400, height: 500))
        }
    }
    
    func hideFromDock() {
        var psn = ProcessSerialNumber(highLongOfPSN: 0, lowLongOfPSN: UInt32(kCurrentProcess))
        let transformState = ProcessApplicationTransformState(kProcessTransformToUIElementApplication)
        TransformProcessType(&psn, transformState)
    }

}
