//
//  SleepTimerApp.swift
//  SleepTimer
//
//  Created by Berkay Güre on 1.08.2023.
//

import SwiftUI

@main
struct SleepTimerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        let _ = NSApplication.shared.setActivationPolicy(.prohibited)

        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    private var popover: NSPopover!
    private var statusItem: NSStatusItem!
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "clock.circle", accessibilityDescription: "Sleep Timer")
            statusButton.action = #selector(togglePopover)
            statusButton.alternateImage = NSImage(systemSymbolName: "clock.circle", accessibilityDescription: "Sleep Timer")
        }
        
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 300, height: 300)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: ContentView())
    }
    
    @objc func togglePopover() {
        if let button = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil)
            }else {
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge:  NSRectEdge.maxY)
            }
        }
    }
    
}
