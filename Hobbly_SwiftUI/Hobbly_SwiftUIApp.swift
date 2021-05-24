//
//  Hobbly_SwiftUIApp.swift
//  Hobbly_SwiftUI
//
//  Created by Nina Paripovic on 5/17/21.
//

import SwiftUI
import RealmSwift
import Combine


//let app = App(id: "hobbly-ibcle")
let app: RealmSwift.App? = RealmSwift.App(id: "hobbly-ibcle")


//@main
//struct Hobbly_SwiftUIApp: SwiftUI.App {
////    @StateObject var state = AppState()
////
////        var body: some Scene {
////            WindowGroup {
////                ContentView()
////                    .environmentObject(state)
////            }
////        }
//}



/// The main screen that determines whether to present the SyncContentView or the LocalOnlyContentView.
@main
struct ContentView: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            // Using Sync?
            if let app = app {
                SyncContentView(app: app)
            } 
        }
    }
}


struct SyncContentView_Previews: PreviewProvider {
    static var previews: some View {
        SyncContentView(app: app!)
    }
}
