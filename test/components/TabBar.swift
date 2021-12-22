//
//  TabBar.swift
//  test
//
//  Created by Angel Dev on 12/20/21.
//

import SwiftUI

struct TabBar: View {
    @ObservedObject var tabItems: TabItems
    let padding: CGFloat = 5
    let iconeSize: CGFloat = 20
    var iconFrame: CGFloat {
        (padding * 2) + iconeSize
    }
    var tabItemCount: CGFloat {
        CGFloat(tabItems.items.count)
    }
    var spacing: CGFloat {
        (UIScreen.main.bounds.width - (iconFrame * tabItemCount)) / (tabItemCount + 1)
    }
    var firstCenter: CGFloat {
         spacing + iconFrame/2
    }
    var stepperToNextCenter: CGFloat {
        spacing + iconFrame //half of 1 and half of next
    }
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Bar(tabItems: tabItems, firstCenter: firstCenter, stepperToNextCenter: stepperToNextCenter)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width, height: 50)
                
                HStack(spacing: spacing) {
                    ForEach(0..<tabItems.items.count, id: \.self) { i in
                        ZStack {
                            Image(systemName: self.tabItems.items[i].imageName)
                                .resizable()
                                .foregroundColor(Color.gray)
                                .frame(width: self.iconeSize, height: self.iconeSize)
                                .opacity(self.tabItems.items[i].opacity)
                                .padding(.all, padding)
                                .background(Color.white)
                                .clipShape(Circle())
                                .onTapGesture {
                                    withAnimation(Animation.easeInOut) {
                                        self.tabItems.select(i)
                                    }
                                }
                        }
                        .offset(y: self.tabItems.items[i].offset)
                    }
                }
                .ignoresSafeArea(.all, edges: .all)
//                .edgesIgnoringSafeArea(.)
            }
        }
    }
}

struct Bar: Shape {
    @ObservedObject var tabItems: TabItems
    var tab: CGFloat
    let firstCenter: CGFloat
    let stepperToNextCenter: CGFloat
    
    init(tabItems: TabItems, firstCenter: CGFloat, stepperToNextCenter: CGFloat) {
        self.tabItems = tabItems
        self.tab = tabItems.selectedTabIndex
        self.firstCenter = firstCenter
        self.stepperToNextCenter = stepperToNextCenter
    }
    
    var animatableData: Double {
        get { return Double(tab) }
        set { tab = CGFloat(newValue) }
    }
    
    func path(in rect: CGRect) -> Path {
        let tabCenter = firstCenter + stepperToNextCenter * (tab - 1)
        return Path { p in
            p.move(to: CGPoint(x: rect.minX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            p.addLine(to: CGPoint(x: tabCenter + 50, y: rect.minY))
            p.addCurve(to: CGPoint(x: tabCenter, y: rect.midY),
                          control1: CGPoint(x: tabCenter + 20, y: rect.minY),
                          control2: CGPoint(x: tabCenter + 20, y: rect.minY + 25))
            p.addCurve(to: CGPoint(x: tabCenter - 50, y: rect.minY),
                          control1: CGPoint(x: tabCenter - 20, y: rect.minY + 25),
                          control2: CGPoint(x: tabCenter - 20, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.maxX - tabCenter, y: rect.minY))
        }
    }
}
