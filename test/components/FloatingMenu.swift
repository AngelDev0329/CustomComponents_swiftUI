//
//  FloatingMenu.swift
//  test
//
//  Created by Angel Dev on 12/20/21.
//

import SwiftUI

struct FloatingMenu: View {
    let buttonArray: [String]
    let onClick: (String)->()
    @State var showButtons = false
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                if showButtons {
                    ForEach(buttonArray, id: \.self) { buttonImage in
                        Button(action: {
                            onClick(buttonImage)
                        }, label: {
                            Image(systemName: buttonImage)
                                .foregroundColor(.white)
                                .font(.body)
                        }).padding(.all, 10)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .padding(.all, 10)
                        .transition(.move(edge: .trailing))
                    }
                }
                Button(action: {
                    withAnimation {
                        showButtons.toggle()
                    }
                }, label: {
                    Image(systemName: showButtons ? "minus" : "plus")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 60, height: 60)
                })
                .background(Color.blue)
                .clipShape(Circle())
                .padding(.all, 10)
            }
        }.padding(.all, 10)
    }
}

struct FloatingMenuDemo: View {
    let buttonArray = ["pencil", "folder", "tray"]
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(0...10, id: \.self) { i in
                        Text("Title \(i)")
                    }
                }
                FloatingMenu.init(buttonArray: buttonArray, onClick: { buttonObject in
                    print("\(buttonObject) Clicked")
                })
            }
            .navigationTitle("Floating Menu")
        }
    }
}

struct FloatingMenu_Previews: PreviewProvider {
    static var previews: some View {
        FloatingMenuDemo()
    }
}
