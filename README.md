# FirebaseLogin
Demonstrates a barebones authentication code for Firebase.

![login screen](/Images/screen.png)

## Server.swift

The `Server.swift` file contains a barebones `Server` enum:

```swift
enum Server {}
```

In the spirit of modular code, everything that communicates with the Firebase backend will be in the namespace of the `Server` enum. 

## Server+Auth.swift

The `Server+Auth.swift` file manages the communication between the app and Firebase for authentication. This is an **extension** of the `Server` enum, with the sole responsibility of handling the authentication.



