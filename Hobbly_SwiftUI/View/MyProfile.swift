//
//  MyProfile.swift
//  Hobbly_SwiftUI
//
//  Created by Nina Paripovic on 5/17/21.
//

import SwiftUI
import RealmSwift

struct MyProfile: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        Text("This is my profile")
//        Button("logout") {
//            app.currentUser?.logOut { (error) in
//                // user is logged out or there was an error
//            }
//        }
    }
}

struct MyProfile_Previews: PreviewProvider {
    static var previews: some View {
        MyProfile()
            .environmentObject(AppState())
    }
}
