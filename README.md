# FDAKeychain
Keychain wrapper for iOS/macOS/watchOS/tvOS/iPadOS, written in Swift 5.8

## Installation
Add this SPM dependency to your project:

```
https://github.com/Sfresneda/FDAKeychain
```

## Usage
```swift
import FDAKeychain

let keychain = FDAKeychain()

// Save a value
keychain.set("value", forKey: "key")

// Get a value
let value = keychain.get("key")

// Delete a value
keychain.delete("key")
```

## License
This project is licensed under the Apache License - see the [LICENSE](LICENSE) file for details

## Author
Sergio Fresneda - [sfresneda](https://github.com/Sfresneda)