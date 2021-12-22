//
//  Moveonupdate.swift
//  test
//
//  Created by Angel Dev on 12/20/21.
//

import SwiftUI

struct ChatUI : View {
    @StateObject private var keyboard = KeyboardResponder()
    var scrollToid = 99
    
    func Scroll(reader :ScrollViewProxy) -> some View {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            withAnimation {
                reader.scrollTo(scrollToid)
            }
        }
        return EmptyView()
    }
        
    var body: some View {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    ScrollViewReader { reader in
                        LazyVStack(spacing: 0.5) {
                                //Chat Bubbols
                            Rectangle()
                                .frame(height: 50, alignment: .center)
                                .foregroundColor(Color.clear).id(scrollToid)//padding from bottom
                            Scroll(reader: reader)
                        }
                     }
                    }
                }
        }
    }

  
struct ChatUI_Previews: PreviewProvider {
    static var previews: some View {
        ChatUI()
    }
}
