//
//  SyncContentView.swift
//  Hobbly_SwiftUI
//
//  Created by Nina Paripovic on 5/23/21.
//

import SwiftUI
import RealmSwift

/// The main content view if not using Sync.

// The main content view if using Sync.
struct SyncContentView: View {
    // Observe the Realm app object in order to react to login state changes.
    @ObservedObject var app: RealmSwift.App
    // Observe a realm that may be opened after login.
    @State var realm: Realm?

    var body: AnyView {
        // If there is no user logged in, show the login view.
        guard let user = app.currentUser else {
            return AnyView(LoginView(app: app))
        }
        // If logged in but the realm is not open yet, then show a progress spinner
        // while opening the realm. Realm.asyncOpen() downloads the remote changes before
        // the realm opens, which might take a moment.
        guard let realm = realm else {
            return AnyView(ProgressView() // Show the activity indicator while the realm loads
                .onReceive(Realm.asyncOpen(configuration: user.configuration(partitionValue: user.id)).assertNoFailure()) { realm in
                    // Preload one Category if it does not exist. This app only ever allows
                    // one Category per user partition, but you could expand it to allow many Categorys.
                    if realm.objects(Category.self).count == 0 {
                        try! realm.write {
                            realm.add(Category(name: "new cat!"))
                            realm.add(Category(name: "new cattt!"))

                        }
                    }
                    // Assign the realm to the state property to trigger a view refresh.
                    self.realm = realm
                })
        }
        // If logged in and the realm has been opened, then go to the Activitys
        // screen for the only Category in the realm.
        return AnyView(ActivitysView(category: realm.objects(Category.self).first!, categories: realm.objects(Category.self),
                                 leadingBarButton: AnyView(LogoutButton(app: app))))
        // Pass the app to descendents via this environment object.
    }
}

struct ActivitysView: View {
    /// The Category is a container for a list of Activitys. Using a Category instead of all Activitys
    /// directly allows us to maintain a list order that can be updated in the UI.
    @ObservedRealmObject var category: Category
    var categories: Results<Category>
    var categoriesArray: [Category] {
      categories.map(Category.init)
    }
    
    /// The button to be displayed on the top left.
    var leadingBarButton: AnyView?
    let tabBarImageNames = ["house.fill", "person.2.fill", "plus.circle", "magnifyingglass", "person.fill"]
    let tabBarNames = ["Home", "Community", "Add", "Search", "Profile"]
    
    @State private var ActivityName = ""
    @State private var ActivityPrice = ""
    @State var addModal = false

    @State var selectedIndex = 0
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor = "Red"

    var body: some View {
            VStack {
                ZStack {
                    Spacer()
                        .fullScreenCover(isPresented: $addModal, content: {
                            VStack {
//                                VStack {
//                                    Text("choose a category")
//                                    Picker("Please choose a color", selection: $selectedColor) {
//                                                    ForEach(categoriesArray, id: \.self) {
//                                                        Text(categoriesArray.name)
//                                                    }
//                                                }
//                                                Text("You selected: \(selectedColor)")
//
//                                }
                                
                                Section(header: Text("name")) {
                                    TextField("", text: $ActivityName)
                                }
                                Section(header: Text("price")) {
                                    TextField("", text: $ActivityPrice)
                                }
                                Button(action: {
                                    // The bound collection automatically
                                    // handles write transactions, so we can
                                    // append directly to it.
                                    $category.Activitys.append(Activity(name: ActivityName, price: ActivityPrice))
                                }) { Image(systemName: "plus") }
                                
                                Button(action: {addModal.toggle()}, label: {
                                    Text("dismiss modal")
                                })
                            }
                        })
                    switch selectedIndex {
                    case 0:
                        NavigationView {
                            VStack {
                                List {
                                    ForEach(categoriesArray) { category in
                                        Text(category.name)
                                        ForEach(category.Activitys) { Activity in
                                            ActivityCell(activity: Activity)
                                        }
                                    }
                                }
                                    .navigationBarTitle("Activitys", displayMode: .large)
                                    .navigationBarBackButtonHidden(true)
                                    .navigationBarItems(
                                        leading: self.leadingBarButton,
                                        // Edit button on the right to enable rearranging Activitys
                                    trailing: EditButton())
                            }
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

                    // Action bar at bottom contains Add button.
//                    HStack {
//                        Spacer()
//
//                    }.padding()
                HStack {
                    ForEach(0..<tabBarImageNames.count) { num in
                        VStack {
                            Button(action: {
                                if (num == 2) {
                                    addModal.toggle()
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
            
                // The list shows the Activitys in the realm.


    }
}

/// Represents an Activity in a list.
struct AcitivtyRow: View {
    @ObservedRealmObject var activity: Activity

    var body: some View {
        // You can click an Activity in the list to navigate to an edit details screen.
        NavigationLink(destination: ActivityDetailsView(activity: activity)) {
            Text(activity.name)
            if activity.isFavorite {
                // If the user "favorited" the Activity, display a heart icon
                Image(systemName: "heart.fill")
            }
        }
    }
}

/// Represents a screen where you can edit the Activity's name.
struct ActivityDetailsView: View {
    @ObservedRealmObject var activity: Activity

    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter a new name:")
            // Accept a new name
            TextField("New name", text: $activity.name)
                .navigationBarTitle(activity.name)
                .navigationBarItems(trailing: Toggle(isOn: $activity.isFavorite) {
                    Image(systemName: activity.isFavorite ? "heart.fill" : "heart")
                })
        }.padding()
    }
}


//
//struct SyncContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SyncContentView(app: app)
//    }
//}


struct ActivityCell: View {
    let activity: Activity
    var body: some View {
        NavigationLink(
            destination: ActivityDetail(activity: activity)) {
            Image("kaf1")
                .resizable()
                .frame(width: 80.0, height: 80.0)
            VStack {
                Text(activity.name)
            }
        }
    }
}
