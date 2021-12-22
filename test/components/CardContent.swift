//
//  CardContent.swift
//  test
//
//  Created by Angel Dev on 12/20/21.
//

import SwiftUI

struct CardContent: View {
    public var body: some View {
        
        ZStack {
            Color.gray
            Text("Main View")
            SlideOverView {
                VStack {
                    Text("Slide Over View")
                    Spacer()
                }
            }
        }
    }
}

struct SlideOverView<Content> : View where Content : View {

    var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
     
    public var body: some View {
        ModifiedContent(content: self.content(), modifier: CardView())
    }
}


struct CardView: ViewModifier {
    @State private var dragging = false
    @GestureState private var dragTracker: CGSize = CGSize.zero
    @State private var position: CGFloat = UIScreen.main.bounds.height - 100
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 2.5)
                    .frame(width: 40, height: 5.0)
                    .foregroundColor(Color.secondary)
                    .padding(10)
                content.padding(.top, 30)
            }
            .frame(minWidth: UIScreen.main.bounds.width)
            .scaleEffect(x: 1, y: 1, anchor: .center)
            .background(Color.white)
            .cornerRadius(15)
        }
        .offset(y:  max(0, position + self.dragTracker.height))
        .animation(dragging ? nil : {
            Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0)
        }())
        .gesture(DragGesture()
                    .updating($dragTracker) { drag, state, transaction in state = drag.translation }
                    .onChanged {_ in  dragging = true }
                    .onEnded(onDragEnded))
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        dragging = false
        let high = UIScreen.main.bounds.height - 100
        let low: CGFloat = 100
        let dragDirection = drag.predictedEndLocation.y - drag.location.y
        //can also calculate drag offset to make it more rigid to shrink and expand
        if dragDirection > 0 {
            position = high
        } else {
            position = low
        }
    }
}

struct SlideOverView_Previews: PreviewProvider {
    static var previews: some View {
        CardContent()
    }
}
