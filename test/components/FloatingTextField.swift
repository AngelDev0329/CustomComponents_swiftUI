//
//  FloatingTextField.swift
//  test
//
//  Created by Angel Dev on 12/20/21.
//

import SwiftUI
struct FloatingTextField: View {
    
    private let placeHolderText: String
    
    let textFieldHeight: CGFloat = 50
    @Binding var text: String
    @State private var isEditing = false
    public init(placeHolder: String, text: Binding<String>) {
        self._text = text
        self.placeHolderText = placeHolder
    }
    var shouldPlaceHolderMove: Bool {
        isEditing || (text.count != 0)
    }
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text, onEditingChanged: { (edit) in
                isEditing = edit
            })
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary, lineWidth: 1).frame(height: textFieldHeight))
                .foregroundColor(Color.primary)
                .accentColor(Color.secondary)
                .animation(.linear)

            ///Floating Placeholder
            Text(placeHolderText)
                .foregroundColor(Color.secondary)
                .background(Color(UIColor.systemBackground))
                /*.padding(shouldPlaceHolderMove ?
                     EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0) : EdgeInsets(top: 0, leading:15, bottom: 0, trailing: 0)
                )*/
                .offset(x: 10, y: shouldPlaceHolderMove ? -0.5 * textFieldHeight : 0)
                .scaleEffect(shouldPlaceHolderMove ? 1.0 : 1.2)
                .animation(.linear)
        }
    }
}

struct FloatingTextField1: View {
    let title: String
    let text: Binding<String>
    
    var body: some View {
        withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
            ZStack(alignment: .leading) {
                TextField("", text: text) // give TextField an empty placeholder
                    .offset(x: 5)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary, lineWidth: 1).frame(height: 40))
                
                Text(title)
                    .background(Color(UIColor.systemBackground))
//                    .foregroundColor(Color.secondary)
                    .foregroundColor(text.wrappedValue.isEmpty ? Color(.placeholderText) : .accentColor)
                    .offset(x: text.wrappedValue.isEmpty ? 8 : 10, y: text.wrappedValue.isEmpty ? 0 : -25)
                    .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.8, anchor: .leading)
            }
            .padding(.top, 30)
        }
    }
}

struct FloatingTextField2: View {
    let title: String
    let text: Binding<String>

    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: text)
            
            Text(title)
                .foregroundColor(text.wrappedValue.isEmpty ? Color(.placeholderText) : .accentColor)
                .offset(y: text.wrappedValue.isEmpty ? 0 : -25)
                .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.75, anchor: .leading)
            
        }
        .padding(.top, 30)
        .animation(.spring(response: 0.4, dampingFraction: 0.3))
    }
}
