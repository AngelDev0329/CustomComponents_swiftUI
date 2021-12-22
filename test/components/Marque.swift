//
//  Marque.swift
//  test
//
//  Created by Angel Dev on 12/20/21.
//

import SwiftUI

struct Marque: View {
    let text: String
    @State private var moveView = false
    @State private var stopAnimation = false
    @State private var textFrame: CGRect = CGRect()
    public init(text: String) {
        self.text = text
    }
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: false, content: {
                Text(text)
                    .lineLimit(1)
                    .background(GeometryGetter(rect: $textFrame)).offset(moveView ? CGSize(width: -1 * textFrame.width, height: 0) : CGSize(width: proxy.size.width, height: 0))
                .onAppear() {
                    self.stopAnimation = false
                    animateView()
                    moveViewOnAnimationEnd()///scrollViewProxy.scrollTo("Identifier") /// does not animate
                }.onDisappear() {
                    self.stopAnimation = true
                }
            }).mask(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black, Color.black, Color.clear]), startPoint: .leading, endPoint: .trailing))
            .padding([.top, .bottom], 100)
        }
    }
    private func animateView() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: { //after 0.5 sec
            withAnimation(Animation.linear(duration: Double(textFrame.width) * 0.01)) {
                moveView = true
            }//no on completion so need to add another time bound method to restart animation from start
        })
    }
    private func moveViewOnAnimationEnd() {
        let timeToAnimate = (Double(textFrame.width) * 0.01) + 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeToAnimate, execute: { //after 0.5 sec
            moveView = false
            if stopAnimation == false {
                animateView()
                moveViewOnAnimationEnd()
            }
        })
    }
}

struct GeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { (proxy) -> Path in
            DispatchQueue.main.async {
                self.rect = proxy.frame(in: .global)
            }
            return Path()
        }
    }
}

struct Marque_Previews: PreviewProvider {
    
    static var previews: some View {
        Marque(text: "If you don't provide your own init with an explicit public modifier the generated constructor will be marked internal")
    }
}
