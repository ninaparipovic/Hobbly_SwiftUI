//
//  AppState.swift
//  Hobbly_SwiftUI
//
//  Created by Nina Paripovic on 5/17/21.
//

import RealmSwift
import SwiftUI
import Combine

class AppState: ObservableObject {
    var loginPublisher = PassthroughSubject<RealmSwift.User, Error>()
    let userRealmPublisher = PassthroughSubject<Realm, Error>()
    var cancellables = Set<AnyCancellable>()



    @Published var shouldIndicateActivity = false
    @Published var error: String?
    @Published var loggedIn: Bool = false

    var user: User?

//    var loggedIn: Bool {
//        app.currentUser != nil && app.currentUser?.state == .loggedIn && user != nil
//    }
    
    init() {
        loginPublisher
            .receive(on: DispatchQueue.main)
            .flatMap { user -> RealmPublishers.AsyncOpenPublisher in
                self.shouldIndicateActivity = true
//                let realmConfig = user.configuration(partitionValue: "user=\(user.id)")
                let realmConfig = user.configuration(partitionValue: "PUBLIC")
                return Realm.asyncOpen(configuration: realmConfig)
            }
            .receive(on: DispatchQueue.main)
            .map {
                self.shouldIndicateActivity = false
                return $0
            }
            .subscribe(userRealmPublisher)
            .store(in: &self.cancellables)

        userRealmPublisher
            .sink(receiveCompletion: { result in
                if case let .failure(error) = result {
                    self.error = "Failed to log in and open realm: \(error.localizedDescription)"
                }
            }, receiveValue: { realm in
                print("Realm User file location: \(realm.configuration.fileURL!.path)")
                self.user = realm.objects(User.self).first
            })
            .store(in: &cancellables)
    }
    

}
