//
//  ManagedWindow.swift
//  
//
//  Created by MainasuK Cirno on 2020/3/7.
//

import Cocoa

public protocol ManagableScene: Hashable {
    
    typealias ID = String
    
    var identifier: ID { get }
    var windowController: NSWindowController { get }
    var windowMinSize: NSSize { get }
    
    func setup(window: NSWindow?)
    
}

extension ManagableScene {
    
    public var windowMinSize: NSSize {
        return NSSize(width: 800, height: 450)
    }
    
}

// MARK: - Hashable
extension ManagableScene {

    /// Custom index method for `SceneManager` pool
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    /// Setup window. Should call in `NSViewController.viewDidAppear`
    /// - Parameter window: host window for view controller
    public func setup(window: NSWindow?) {
        window?.minSize = windowMinSize
        window?.setFrameAutosaveName(identifier)
    }
    
}
