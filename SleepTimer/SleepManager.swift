import SwiftUI
import Foundation


class SleepManager {
    static func putMacToSleep() {
        let sleepScript = """
                tell application "System Events" to sleep
            """
            
        DispatchQueue.global(qos: .background).async {
            var error: NSDictionary?
            if let scriptObject = NSAppleScript(source: sleepScript) {
                scriptObject.executeAndReturnError(&error)
                if let error = error {
                    print("Error executing AppleScript: \(error)")
                }
            } else {
                print("Error creating AppleScript object.")
            }
        }
    }
}
