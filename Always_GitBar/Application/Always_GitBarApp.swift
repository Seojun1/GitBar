// Application/Always_GitBarApp.swift

import SwiftUI

@main
struct Always_GitBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
