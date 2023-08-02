import Foundation
import ScriptingBridge

@objc protocol SystemEventsApplication {
    @objc optional func sleep()
}

class SleepManager {
    static func putMacToSleep() {
        let systemEvents = SBApplication(bundleIdentifier: "com.apple.systemevents") as! SystemEventsApplication
        systemEvents.sleep?()
    }
}
