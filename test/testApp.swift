//
//  testApp.swift
//  test
//
//  Created by Angel Dev on 12/20/21.
//

struct Demo: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var city: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            FloatingTextField(placeHolder: "Name", text: $name)
            FloatingTextField(placeHolder: "Email", text: $email)
            
            FloatingTextField1(title: "City", text: $city)
            FloatingTextField2(title: "Street", text: $password)
        }.padding()
    }
}


import SwiftUI

@main
struct testApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
//            Demo()
//            CustomViews()
            TabBarDemo().environment(\.managedObjectContext, persistenceController.container.viewContext)
//            CardContent()
//            FloatingMenuDemo()
//            Marque(text: "If you don't provide your own init with an explicit public modifier the generated constructor will be marked internal")
        }
    }
}
