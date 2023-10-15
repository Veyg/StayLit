//
//  StayLitApp.swift
//  StayLit
//
//  Created by Dawid Grochowski on 12/10/2023.
//
import SwiftUI

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
        statusBarController = StatusBarController()
        
        if let window = NSApplication.shared.windows.first{
            window.styleMask.remove(.resizable)
            window.setContentSize(NSSize(width: 400, height: 500))
        }
    }
}
