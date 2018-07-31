# Springbok

[![dependencies Status](https://david-dm.org/dwyl/esta/status.svg)](https://david-dm.org/dwyl/esta)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Language](https://img.shields.io/badge/Swift-4.2-brightgreen.svg)](http://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-10.0-brightgreen.svg)](https://developer.apple.com/download/more/)

## 📖 Project description

Springbok is a light and fast HTTP Networking in Swift working with Codable.

## 📂 Features

- [x] Chainable Request / Response Methods
- [x] Request handle is background and Response in the main thread
- [x] Works with Codable !

## 🔧 Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](https://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Springbok into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "nodes-ios/Springbok"
```

Run `carthage update` to build the framework and drag the built `Springbok.framework` into your Xcode project.

## 📝 Documentation

### Define your Model

```swift
struct User: Codable {
    let id: Int
    let name: String
    ...
}
```

### Making simple request

```swift
import Springbok

    Springbok
        .request("<your_url>")
        .responseCodable { (result: Result<User>) in
            switch result {
            case .success(let user):
                // request successful, your model is decoded !
            case .failure(let error):
                // request failed ...
            }
        }
```

### Making elaborated request

```swift
import Springbok

    Springbok
        .request(
            "<your_url>", 
            method: .post, // .get, .post, .patch, .put, .delete
            parameters: ["id": 1], // [String: Any]
            headers: ["Content-Type": "application/json"] // [String: String]
        )
        .responseCodable { (result: Result<User>) in
            switch result {
            case .success(let playlists):
                // request successful, your model is decoded !
            case .failure(let error):
                // request failed ...
            }
        }
```

### Unwrap your data

If your server returns data like this :

```json
{
   "<root_object_name>": [
      {
         "id": 1,
         "name": "John Doe"
      },
      ...
   ]
}
```

You need to unwrap the response in order to decode it.

```swift
import Springbok

Springbok
        .request("<your_url>")
        .unwrap("root_object_name") // the name of your root object
        .responseCodable { (result: Result<User>) in
            switch result {
            case .success(let user):
                // request successful, your model is decoded !
            case .failure(let error):
                // request failed ...
            }
        }
```

## 💻 Developers

- [Maxime Maheo](https://github.com/mmaheo)

