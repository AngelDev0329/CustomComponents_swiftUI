//
//  CustomTabBar.swift
//  test
//
//  Created by Angel Dev on 12/20/21.
//

import SwiftUI

struct TabBarDemo: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var tabItems = TabItems()
    
    var body: some View {
        ZStack {
            ///View1
            /*NavigationView {
                ZStack {
                    Color.gray
//                    Text("Home")
//                    ContentView().environment(\.managedObjectContext, viewContext)
                }
                .navigationBarTitle("Home")
            }
            .opacity((tabItems.selectedTabIndex == 1) ? 1 : 0)*/
            
            NavigationView {
                ZStack {
                    Color.gray
                    VStack{
                        Text("Home")
                        Text("Home")
                        Text("Home")
                        Text("Home")
                        Text("Home")
                        Text("Home")
                        Text("Home")
                        Text("Home")
                        Text("Home")
                    }
                    
//                    List {
//                        ForEach(0...100, id: \.self) { i in
//                            Text("Title \(i)")
//                        }
//                    }
                }
//                .navigationTitle("Floating Menu")
                .navigationBarTitle("Home")
            }
            .opacity((tabItems.selectedTabIndex == 1) ? 1 : 0)
//            .edgesIgnoringSafeArea(.top)
            ///View2
            NavigationView {
                ZStack {
                    Color.gray
                    NavigationLink(destination: {
                        ZStack {
                                Color.gray
                                Text("Second Search View")
                        }.navigationBarTitle("Second View")
                    }()) {
                        Text("Search")
                    }
                }
                .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
                .navigationTitle("Search")
//                .navigationBarTitle("Search")
            }
            .opacity((tabItems.selectedTabIndex == 2) ? 1 : 0)
            ///View3
            NavigationView {
                ZStack {
                    Color.gray
                    Text("Add")
                }
                .navigationBarTitle("Add")
            }
            .opacity((tabItems.selectedTabIndex == 3) ? 1 : 0)
            ///View4
            NavigationView {
                ZStack {
                    Color.gray
                    Text("Favorite")
                }
                .navigationBarTitle("Favorite")
            }
            .opacity((tabItems.selectedTabIndex == 4) ? 1 : 0)
            ///View5
            NavigationView {
                ZStack {
                    Color.gray
                    Text("Profile")
                }
                .navigationBarTitle("Profile")
            }
            .opacity((tabItems.selectedTabIndex == 5) ? 1 : 0)
            
            TabBar(tabItems: tabItems)
        }
    }
}


class TabItem: Identifiable {
    let id = UUID()
    let imageName: String
    var offset: CGFloat = -5
    var opacity: Double = 1
    
    init(imageName: String, offset: CGFloat) {
        self.imageName = imageName
        self.offset = offset
    }
    init(imageName: String) {
        self.imageName = imageName
    }
}

class TabItems: ObservableObject {

    @Published var items: [TabItem] = [
        TabItem(imageName: "house", offset: -20),
        TabItem(imageName: "magnifyingglass"),
        TabItem(imageName: "plus.app"),
        TabItem(imageName: "heart"),
        TabItem(imageName: "person"),
    ]
    
    @Published var selectedTabIndex: CGFloat = 1
    
    func select(_ index: Int) {
        let tabItem = items[index]
        
        tabItem.opacity = 0
        tabItem.offset = 15
        
        withAnimation(Animation.easeInOut) {
            selectedTabIndex = CGFloat(index + 1)
            for i in 0..<items.count {
                if i != index {
                    items[i].offset = -5
                }
            }
        }
        withAnimation(Animation.easeOut(duration: 0.25).delay(0.25)) {
            tabItem.opacity = 1
            tabItem.offset = -25
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarDemo()
    }
}
