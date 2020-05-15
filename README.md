# CocoaWindowManager

Simple app scene manager for the Cocoa App.

## Setup

Create the scene manager class.

```swift
import Cocoa
import CocoaSceneManager

final class AppSceneManager: SceneManager<AppScene> {
    
    // MARK: - Singleton
    public static let shared = AppSceneManager()

    private override init() {
        super.init()
    }
    
}
```

Create App scene and conform it to `ManagableScene`. For example:

```swift
import Cocoa
import CocoaSceneManager

enum AppScene: ManagableScene {
        
    case main(document: Document)
    case …
    
    … 
}
```

## Usage
Use `open(_:active:)` method on the `AppSceneManager` and it will save the scene and related window controller in the pool. Manager will reuse same window controller for the same hash value scene.

```swift
let windowController = AppSceneManager.shared.open(.main(document: document))
```

