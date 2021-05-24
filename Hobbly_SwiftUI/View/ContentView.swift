////
////  ContentView.swift
////  Hobbly_SwiftUI
////
////  Created by Nina Paripovic on 5/17/21.
////

import SwiftUI
import RealmSwift


struct CcontentView: View {
    @EnvironmentObject var state: AppState
    @ObservedResults(Activity2.self) var activities


    
//    @ObservedObject var store = ActivityStore()
    @State var selectedIndex = 0
    @State var addModal = false
    @State var rowNumber : Int = 0
    @State var menuOpen: Bool = false
    
    @State private var ActivityName = ""
    @State private var ActivityPrice = ""

    
//    var realm: Realm?

    let tabBarImageNames = ["house.fill", "person.2.fill", "plus.circle", "magnifyingglass", "person.fill"]
    let tabBarNames = ["Home", "Community", "Add", "Search", "Profile"]
    

    
    var body: some View {
        if state.loggedIn {
            VStack(spacing: 0) {
                ZStack {
                    Spacer()
                        .fullScreenCover(isPresented: $addModal, content: {
                            VStack {
                                Section(header: Text("name")) {
                                    TextField("", text: $ActivityName)
                                }
                                Section(header: Text("price")) {
                                    TextField("", text: $ActivityPrice)
                                }
                                Button(action: {addModal.toggle()}, label: {
                                    Text("dismiss modal")
                                })
                            }
                        })
                    switch selectedIndex {
                    case 0:
                        NavigationView {
                            HomeView()
                        }
                    case 1:
                        NavigationView {
                            CommunityView()
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                        }
                    case 3:
                        NavigationView {
                            SearchView()
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                        }
                    default:
                        NavigationView {
                            MyProfile()
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                        }
                    }
                }
                Divider()
                    .padding(.bottom, 12)
                HStack {
                    ForEach(0..<tabBarImageNames.count) { num in
                        VStack {
                            Button(action: {
                                if (num == 2) {
                                    addModal.toggle()
                                    // why do you need to return?
                                    return
                                }
                                selectedIndex = num
                            }, label: {
                                Spacer()
                                if num == 2 {
                                    Image(systemName: tabBarImageNames[num])
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundColor(.orange)
                                } else {
                                    Image(systemName: tabBarImageNames[num])
                                        .font(.system(size: 26, weight: .bold))
                                        .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                                    
                                }
                                
                                Spacer()
                            })
                            if (num != 2) {
                                Text("\(tabBarNames[num])")
                                    .font(.system(size: 12, weight: .light))
                            }
                        }
                        
                        
                    }
                }
            }
        } else {
            // bad way to pass?
        }

    }
    func openMenu() {
        self.menuOpen.toggle()
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CcontentView()
            .environmentObject(AppState())
    }
}

