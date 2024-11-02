//
//  AppDelegate.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import Swinject
import UserNotifications
import RiveRuntime
import ServiceManagement

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
  
  /// services section
  let audio = Container.shared.resolve(AudioService.self)
  let charService: CharacterService = UserManager.shared
    let notifService = NotificationManager.shared
  
  var userPreference: UserPreferenceModel?
  var mainWindow: MainWindow?
  var statusBarWindow: NSWindow!
  var statusBar: NSStatusBar?
  var statusBarItem: NSStatusItem?
  var statusBarPopOver: NSPopover?
  var quitMenu: NSMenu!
  
  var hideClimbrItem: NSMenuItem!
  var hideOthersItem: NSMenuItem!
  var showAllItem: NSMenuItem!
  var minimizeItem: NSMenuItem!
  
  var isHideOthers: Bool = false {
    didSet {
      hideOthersItem.action = isHideOthers ? nil : #selector(hideOthers)
      hideClimbrItem.action = isHideOthers ? nil : #selector(hideApp)
      showAllItem.action = !isHideOthers ? nil : #selector(showAll)
    }
  }
  
  var isMinimized: Bool = false {
    didSet {
      minimizeItem.action = isMinimized ? nil : #selector(minimizeApp)
    }
  }
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    
    // Load user preferences (Anda dapat mengganti ini dengan cara Anda menyimpan/memuat preferensi)
    loadUserPreference()
    
    // Cek jika launchAtLogin bernilai true
    if let preferences = userPreference {
        notifService.startOverlayScheduler(userPreference: preferences)
      if preferences.launchAtLogin {
        enableHelperAppLaunchAtLogin(true)
      } else {
        enableHelperAppLaunchAtLogin(false)
      }
    }
    
    mainWindow = MainWindow()
    
    if let vc                  = Container.shared.resolve(MainVC.self) {
      mainWindow?.addViewController(vc)
    }
    
    createStatusBar()
    createAppMenuBar()
    createWindowMenuBar()
    
    NSApplication.shared.setActivationPolicy(.regular)
    
    mainWindow?.delegate = self
    
    NSApp.appearance = NSAppearance(named: .aqua)
    
    UNUserNotificationCenter.current().delegate = self
    
    mainWindow?.makeKeyAndOrderFront(nil)
  }
  
  func loadUserPreference(){
    userPreference = charService.getPreferences()
  }
  
  func enableHelperAppLaunchAtLogin(_ enabled: Bool) {
    if #available(macOS 13.0, *) {
      // Menggunakan SMAppService untuk macOS 13.0 dan yang lebih baru
      let helperAppIdentifier = "com.hkbp.climbr.helper"
      let loginItem = SMAppService.loginItem(identifier: helperAppIdentifier)
      
      if enabled {
        do {
          try loginItem.register()
          print("Helper App registered successfully.")
        } catch {
          print("Failed to register Helper App: \(error.localizedDescription)")
        }
      } else {
        do {
          try loginItem.unregister()
          print("Helper App unregistered.")
        } catch {
          print("Failed to register Helper App: \(error.localizedDescription)")
        }
      }
    } else {
      // Fallback untuk macOS yang lebih lama
      let mainAppIdentifier = "com.hkbp.climbr"
      let runningApps = NSWorkspace.shared.runningApplications
      let isRunning = runningApps.contains(where: { $0.bundleIdentifier == mainAppIdentifier })
      
      if !isRunning {
        let path = Bundle.main.bundlePath as NSString
        var components = path.pathComponents
        components.removeLast(3)
        components.append("MacOS")
        components.append("climbr")
        let newPath = NSString.path(withComponents: components)
        
        NSWorkspace.shared.openApplication(at: URL(fileURLWithPath: newPath), configuration: NSWorkspace.OpenConfiguration())
      }
      NSApp.terminate(nil)
    }
  }
  
  func windowDidDeminiaturize(_ notification: Notification) {
    isMinimized = false
  }
  
  func windowWillMiniaturize(_ notification: Notification) {
    isMinimized = true
  }
  
  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
    audio?.stopBackground()
    print("Application will terminate")
  }
  
  func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
  
  func windowWillClose(_ notification: Notification) {
    NSApp.hide(nil) // Menyembunyikan aplikasi saat jendela ditutup
    if let audio = audio {
      audio.stopBackground()
    } else {
      print("AudioService not resolved.")
    }
    print("Application will close")
    mainWindow?.isReleasedWhenClosed = false
    NSApplication.shared.setActivationPolicy(.accessory)
  }
  
  func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
    
    if !flag {
      mainWindow?.orderFront(self)
      if let window = mainWindow {
        window.makeKeyAndOrderFront(nil)
        NSApplication.shared.activate(ignoringOtherApps: true)
      } else {
        mainWindow?.makeKeyAndOrderFront(self)
        print("Creating a new mainWindow instance.")
        mainWindow = MainWindow()
        mainWindow?.delegate = self
        mainWindow?.makeKeyAndOrderFront(nil)
        NSApplication.shared.activate(ignoringOtherApps: true)
      }
    }
    return true
  }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.banner, .badge, .sound])
    
    print("Notification Did Received on foreground")
    
    var count = UserDefaults.standard.integer(forKey: UserDefaultsKey.kNotificationCount)
    
    count += 1
    
    UserDefaults.standard.setValue(count, forKey: UserDefaultsKey.kNotificationCount)
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
    print("Notification Did Received on background")
    
    var count = UserDefaults.standard.integer(forKey: UserDefaultsKey.kNotificationCount)
    
    count += 1
    
    UserDefaults.standard.setValue(count, forKey: UserDefaultsKey.kNotificationCount)
    
    completionHandler()
    
    openStrechingPage()
  }
  
  func openStrechingPage() {
    if let vc = Container.shared.resolve(StretchingVC.self) {
      mainWindow?.contentViewController?.push(to: vc)
      print("go to stretching session")
      mainWindow?.orderFrontRegardless()
      
    }
  }
}
