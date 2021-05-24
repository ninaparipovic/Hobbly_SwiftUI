//
//  LoginView.swift
//  Hobbly_SwiftUI
//
//  Created by Nina Paripovic on 5/23/21.
//

import SwiftUI
import RealmSwift

/// Represents the login screen. We will have a button to log in anonymously.
struct LoginView: View {
    // Hold an error if one occurs so we can display it.
    @State var error: Error?
    
    // Keep track of whether login is in progress.
    @State var isLoggingIn = false
    
    // The Realm app is passed in from above
    @ObservedObject var app: RealmSwift.App

    var body: some View {
        VStack {
            if isLoggingIn {
                ProgressView()
            }
            if let error = error {
                Text("Error: \(error.localizedDescription)")
            }
            Button("Log in anonymously") {
                // Button pressed, so log in
                isLoggingIn = true
                app.login(credentials: .anonymous) { result in
                    isLoggingIn = false
                    if case let .failure(error) = result {
                        print("Failed to log in: \(error.localizedDescription)")
                        // Set error to observed property so it can be displayed
                        self.error = error
                        return
                    }
                    // Other views are observing the app and will detect
                    // that the currentUser has changed. Nothing more to do here.
                    print("Logged in")
                }
            }.disabled(isLoggingIn)
        }
    }
}

/// A button that handles logout requests.
struct LogoutButton: View {
    @ObservedObject var app: RealmSwift.App
    @State var isLoggingOut = false

    var body: some View {
        Button("Log Out") {
            guard let user = app.currentUser else {
                return
            }
            isLoggingOut = true
            user.logOut() { error in
                isLoggingOut = false
                // Other views are observing the app and will detect
                // that the currentUser has changed. Nothing more to do here.
                print("Logged out")
            }
        }.disabled(app.currentUser == nil || isLoggingOut)
    }
}


//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
