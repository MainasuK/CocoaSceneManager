//
//  ManagedController.swift
//  
//
//  Created by MainasuK Cirno on 2020/3/7.
//

import Foundation

public protocol ManagedController {
    
    associatedtype Scene = ManagableScene
    
    var scene: Scene? { get set }
    
}
