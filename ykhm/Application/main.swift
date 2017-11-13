import Foundation
import UIKit

func startApplication(_ delegateClassName: String) {
    UIApplicationMain(
        CommandLine.argc,
        UnsafeMutableRawPointer(CommandLine.unsafeArgv)
            .bindMemory(
                to: UnsafeMutablePointer<Int8>.self,
                capacity: Int(CommandLine.argc)),
        nil,
        delegateClassName
    )
}

class TestingAppDelegate: UIApplication, UIApplicationDelegate {
}

if NSClassFromString("XCTestCase") != nil {
    startApplication(NSStringFromClass(TestingAppDelegate.self))
} else {
    startApplication(NSStringFromClass(AppDelegate.self))
}


