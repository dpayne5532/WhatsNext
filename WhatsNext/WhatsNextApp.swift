//
//  WhatsNextApp.swift
//  WhatsNext
//
//  Created by Dan Payne on 1/30/22.
//

import SwiftUI

@main
struct WhatsNextApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
