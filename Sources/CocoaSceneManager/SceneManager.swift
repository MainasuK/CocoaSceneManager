//
//  SceneManager.swift
//  
//
//  Created by MainasuK Cirno on 2020/3/7.
//

import os
import Cocoa

/// Generice window manager
///
///     final class AppSceneManager: SceneManager<AppScene> {
///
///         // MARK: - Singleton
///         public static let shared = AppSceneManager<AppScene>()
///
///         private override init() {
///             super.init()
///         }
///
///     }
///
open class SceneManager<Scene: ManagableScene>: NSObject, NSWindowDelegate {
    
    var windowControllerPool: [Scene: NSWindowController] = [:]
    
    open func windowWillClose(_ notification: Notification) {
        os_log("%{public}s[%{public}ld], %{public}s: %{public}s", ((#file as NSString).lastPathComponent), #line, #function, notification.description)

        guard let window = notification.object as? NSWindow else {
            return
        }
        
        let cachedKeyValue = windowControllerPool.first { (scene, windowController) -> Bool in
            return windowController.window === window
        }
    
        guard let _cachedKeyValue = cachedKeyValue else {
            return
        }
        
        // Remove scene
        windowControllerPool[_cachedKeyValue.key] = nil
        
        os_log("%{public}s[%{public}ld], %{public}s: %s", ((#file as NSString).lastPathComponent), #line, #function, String(describing: windowControllerPool))
    }
    
    open func windowDidResignKey(_ notification: Notification) {
        os_log("%{public}s[%{public}ld], %{public}s", ((#file as NSString).lastPathComponent), #line, #function)
        guard let _ = notification.object as? NSWindow else {
            return
        }
    }
    
}

extension SceneManager {
    
    @discardableResult
    open func open(_ scene: Scene, active: Bool = false) -> NSWindowController {
        let windowController: NSWindowController = {
            if let cachedWindowController = windowControllerPool[scene] {
                return cachedWindowController
            } else {
                let windowController = scene.windowController
                windowControllerPool[scene] = windowController
                
                return windowController
            }
        }()

        // Setup window controller delegate
        windowController.window?.delegate = self
        
        if active {
            // Make window display
            windowController.showWindow(self)
            // brint to front
            NSApplication.shared.activate(ignoringOtherApps: true)
            windowController.window?.makeKeyAndOrderFront(nil)
        }
        
        os_log("%{public}s[%{public}ld], %{public}s: %s", ((#file as NSString).lastPathComponent), #line, #function, String(describing: windowControllerPool))
        
        return windowController
    }
    
}
