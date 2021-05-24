////
////  AuthView.swift
////  Hobbly_SwiftUI
////
////  Created by Nina Paripovic on 5/17/21.
////
//
//import SwiftUI
//import RealmSwift
//
//struct AuthView: View {
//    @EnvironmentObject var state: AppState
//    @State private var username = "123@123.com"
//    @State private var password = "123456"
//    @State private var newUser = false
//    
////    var realm: Realm
//    
//    
//    var body: some View {
//        VStack {
//            VStack {
//                Text("enter email")
//                TextField("", text: $username)
//            }
//            VStack {
//                Text("enter password")
//                SecureField("", text: $password)
//            }
//            Button(newUser ? "Sign up" : "Log in") {
//                self.userAction(username: self.username, password: self.password)
//            }
//            Button(newUser ? "Already signed up? Log in" : "New here? Sign up") {
//                newUser.toggle()
//            }
//            Button("Press to anon log in") {
//                app.login(credentials: Credentials.anonymous) { (result) in
//                    // Remember to dispatch back to the main thread in completion handlers
//                    // if you want to do anything on the UI.
//                    DispatchQueue.main.async {
//                        switch result {
//                        case .failure(let error):
//                            print("Login failed: \(error)")
//                        case .success(let user):
//                            print("Login as \(user) succeeded!")
//                            // Continue below, make login bool = true
//                            onLogin()
//                        }
//                    }
//                }
//            
//            }
//        }
//    }
//    
//    private func userAction(username: String, password: String) {
//        if newUser {
//            signup(username: username, password: password)
//        } else {
//            login(username: username, password: password)
//        }
//    }
//    
//    
//    private func onLogin() {
//        state.loggedIn = true
//        print(state.loggedIn)
////         open a realm
//        let user = app.currentUser!
//        let partitionValue = "PUBLIC"
//        // Get a sync configuration from the user object.
////        var configuration = user!.configuration(partitionValue: partitionValue)
//        let configuration = user.configuration(partitionValue: partitionValue)
//        // Open the realm asynchronously to ensure backend data is downloaded first.
//        Realm.asyncOpen(configuration: configuration) { (result) in
//            switch result {
//            case .failure(let error):
//                print("Failed to open realm: \(error.localizedDescription)")
//                // Handle error...
//            case .success(let realm):
//                // Realm opened
//                print("yay")
////                onRealmOpened(realm)
//                let activity = Activity2(name: "test", price: "$200")
//                try! realm.write {
//                    realm.add(activity)
//                    print("written new activity")
//                }
//            }
//        }
//        return
//    }
//    
//    
//    
//    private func signup(username: String, password: String) {
//        if username.isEmpty || password.isEmpty {
//            // provide error message
//            return
//        }
//        app.emailPasswordAuth.registerUser(email: username, password: password) { (error) in
//            guard error == nil else {
//                print("Failed to register: \(error!.localizedDescription)")
//                return
//            }
//            // Registering just registers. You can now log in.
//            print("Successfully registered user.")
//            login(username: username, password: password)
//        }
//
//        
//    }
//    
//    private func login(username: String, password: String) {
//        if username.isEmpty || password.isEmpty {
//            // provide error message
//            return
//        }
////        self.state.error = nil
////        app.login(credentials: .emailPassword(email: username, password: password))
////            .receive(on: DispatchQueue.main)
////            .sink(receiveCompletion: {
////                state.shouldIndicateActivity = false
////                switch $0 {
////                case .finished:
////
////                    break
////                case .failure(let error):
////                    self.state.error = error.localizedDescription
////                }
////            }, receiveValue: {
////                self.state.error = nil
////                state.loginPublisher.send($0)
////            })
////            .store(in: &state.cancellables)
//        
//        app.login(credentials: Credentials.emailPassword(email: username, password: password))
//        { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .failure(let error):
//                    print("Login failed: \(error.localizedDescription)")
//                case .success(let user):
//                    print("Successfully logged in as user \(user)")
//                    // Now logged in, do something with user
//    //                DispatchQueue.main.async {
//                        onLogin()
//                        // Remember to dispatch to main if you are doing anything on the UI thread
//    //                }
//
//                }
//            }
//        }
//
//    }
//    
//}
//
//struct AuthView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthView()
//            .environmentObject(AppState())
//    }
//}
//
//
//
//
//
