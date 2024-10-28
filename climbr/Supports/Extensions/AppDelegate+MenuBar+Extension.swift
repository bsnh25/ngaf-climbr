//
//  AppDelegate+MenuBar+Extension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 28/10/24.
//

import Foundation
import AppKit
import Swinject

extension AppDelegate {
  internal func createStatusBar() {
    statusBar = NSStatusBar.system
    statusBarItem = statusBar?.statusItem(withLength: NSStatusItem.variableLength)
    
    if let button = statusBarItem?.button {
      let icon = NSImage.stretchingIcon
      icon.size      = CGSize(width: 16, height: 16)
      
      button.image = icon
      button.appearsDisabled = false
      button.target = self
      button.action = #selector(openMenuBarApp)
    }
    
    statusBarPopOver = NSPopover()
    // Set the popover size
    statusBarPopOver?.contentSize = NSSize(width: 300, height: 300)
    // Set the popover behavior to close automatically if user click outside
    statusBarPopOver?.behavior = .transient
    // Set the UIViewController of popover
    
    
  }
  
  @objc internal func openMenuBarApp(_ sender: Any?) {
    if let button = statusBarItem?.button {
      // Close the popover if is shown
      if let popOver = statusBarPopOver, popOver.isShown {
        statusBarPopOver?.performClose(sender)
      } else {
        // Otherwise show popover relative to button/icon location
        statusBarPopOver?.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
      }
    }
  }
  
  internal func createAppMenuBar() {
    let mainMenu = NSApplication.shared.mainMenu
    
    guard let mainMenu else { return }
    
    let appMenu = NSMenu()
    
    // About Climbr
    let aboutAppItem = NSMenuItem(
      title: "About \(ProcessInfo.processInfo.processName)",
      action: nil,
      keyEquivalent: ""
    )
    appMenu.addItem(aboutAppItem)
    
    // Check For Updates
    let checkUpdateItem = NSMenuItem()
    checkUpdateItem.title = "Check for Updates..."
    appMenu.addItem(checkUpdateItem)
    
    appMenu.addItem(NSMenuItem.separator())
    
    // Settings
    let settingItem = NSMenuItem(
      title: "Settings...",
      action: nil,
      keyEquivalent: ""
    )
    appMenu.addItem(settingItem)
    
    appMenu.addItem(NSMenuItem.separator())
    
    // Hide Items
    let hideClimbrItem = NSMenuItem(
      title: "Hide \(ProcessInfo.processInfo.processName)",
      action: #selector(hideApp),
      keyEquivalent: ""
    )
    appMenu.addItem(hideClimbrItem)
    
    let hideOthersItem = NSMenuItem(
      title: "Hide Others",
      action: #selector(hideOthers),
      keyEquivalent: ""
    )
    appMenu.addItem(hideOthersItem)
    
    let showAllItem = NSMenuItem(
      title: "Show All",
      action: #selector(showAll),
      keyEquivalent: ""
    )
    appMenu.addItem(showAllItem)
    
    appMenu.addItem(NSMenuItem.separator())
    
    // Quit Items
    let quitItem = NSMenuItem(
      title: "Quit \(ProcessInfo.processInfo.processName)",
      action: #selector(quitApp),
      keyEquivalent: "q"
    )
    appMenu.addItem(quitItem)
    
    if let mainMenuItem = mainMenu.items.first {
      mainMenu.setSubmenu(appMenu, for: mainMenuItem)
    }
  }
  
  internal func createWindowsMenuBar() {
    let mainMenu = NSApplication.shared.mainMenu
    
    guard let mainMenu else { return }
    
    let windowsMenu = NSMenu()
    let windowsMenuItem = NSMenuItem(
      title: "Windows",
      action: nil,
      keyEquivalent: ""
    )
    
    // Minimze Item
    let minimizeItem = NSMenuItem(
      title: "Minimize",
      action: #selector(minimizeApp),
      keyEquivalent: ""
    )
    windowsMenu.addItem(minimizeItem)
    
    // Zoom Item
    let zoomItem = NSMenuItem(
      title: "Zoom",
      action: #selector(zoomApp),
      keyEquivalent: ""
    )
    windowsMenu.addItem(zoomItem)
    
    // Fill Item
    let fillItem = NSMenuItem(
      title: "Fill",
      action: nil,
      keyEquivalent: ""
    )
    windowsMenu.addItem(fillItem)
    
    // Center Item
    let centerItem = NSMenuItem(
      title: "Center",
      action: #selector(centerApp),
      keyEquivalent: ""
    )
    windowsMenu.addItem(centerItem)
    
    windowsMenu.addItem(NSMenuItem.separator())
    
    // FullScreen Item
    let fullScreenitem = NSMenuItem(
      title: "Full Screen",
      action: #selector(fullScreenApp),
      keyEquivalent: ""
    )
    windowsMenu.addItem(fullScreenitem)
    
    mainMenu.addItem(windowsMenuItem)
    mainMenu.setSubmenu(windowsMenu, for: windowsMenuItem)
    
  }
  
  private var isCurrentWindowVisible: Bool {
    let window = NSApplication.shared.mainWindow
    
    return window?.isVisible ?? true
  }
  
  @objc private func hideApp(sender: Any?) {
    NSApplication.shared.hide(sender)
  }
  
  @objc private func hideOthers(sender: Any?) {
    let process = ProcessInfo.processInfo.processIdentifier
    for app in NSWorkspace.shared.runningApplications where app.processIdentifier != process {
      app.hide()
    }
  }
  
  @objc private func showAll(sender: Any?) {
    
    for app in NSWorkspace.shared.runningApplications {
      app.unhide()
    }
  }
  
  @objc private func quitApp(sender: Any?) {
    NSApplication.shared.terminate(sender)
  }
  
  @objc private func minimizeApp(sender: Any?) {
    mainWindow?.miniaturize(sender)
  }
  
  @objc private func zoomApp(sender: Any?) {
    mainWindow?.zoom(sender)
  }
  
  @objc private func centerApp(sender: Any?) {
    mainWindow?.centerSelectionInVisibleArea(sender)
  }
  
  @objc private func fullScreenApp(sender: Any?) {
    mainWindow?.toggleFullScreen(sender)
  }
}
