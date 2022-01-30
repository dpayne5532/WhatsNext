//
//  ContentView.swift
//  WhatsNext
//
//  Created by Dan Payne on 1/30/22.
//
import EventKit
import SwiftUI


class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popover = NSPopover()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.title = "What's Next?"
        statusItem?.button?.target = self
        statusItem?.button?.action = #selector(togglePopover)
 
    let contentView = ContentView()
        popover.contentSize = NSSize(width:400, height: 400)
        popover.contentViewController = NSHostingController(rootView: contentView)
    
        NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) {
            [weak self] event in
            guard let self = self else { return }
            
            if self.popover.isShown {
                self.hidePopover(event)
            }
        }
        
    }
    
    
    func showPopover() {
        guard let statusBarButton = statusItem?.button else {
            return
            
        }
        popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: .maxY)
        
        
        
    }
    func hidePopover(_ sender: Any) {
        popover.performClose(sender)

    }

    @objc func togglePopover(_ sender: Any) {
        if popover.isShown {
            hidePopover(sender)
        } else {
            showPopover()
        }
    }
}




extension Date {
    func offsetBy(days: Int, seconds: Int) -> Date {
        var components = DateComponents()
        components.day = days
        components.second = seconds
        return Calendar.current.date(byAdding: components, to: self) ?? self
    }
    
    static var startOfToday: Date {
        Calendar.current.startOfDay(for: Date.now)
        
    }
    static var endOfToday: Date {
        startOfToday.offsetBy(days: 1, seconds: -1)
    }
    
    
    
    
}




struct ContentView: View {
    @State private var eventStore = EKEventStore()
    @State private var storeAccessGranted = false
    
    @State private var todayEvents = [EKEvent]()
    @State private var tomorrowEvents = [EKEvent]()
    @State private var laterEvents = [EKEvent]()
    
    var body: some View {
        Text("Hello, world!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                eventStore.requestAccess(to: .event) { granted, error in
                    storeAccessGranted = granted
                  
                    if granted {
                        //read events
                    }
                    
                }
            }
    }
    
    func events(from: Date, to: Date) -> [EKEvent] {
        let predicate = eventStore.predicateForEvents(withStart: from, end: to, calendars: nil)
        return eventStore.events(matching: predicate)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
