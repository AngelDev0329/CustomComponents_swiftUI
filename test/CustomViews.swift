//
//  CustomViews.swift
//  test
//
//  Created by Angel Dev on 12/20/21.
//

import SwiftUI

enum StylesSet {
    struct CustomButton: PrimitiveButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
                         Button(configuration)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.green]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(40)
        }
    }
    
    struct CustomToggle: ToggleStyle {
            func makeBody(configuration: Configuration) -> some View {
                HStack {
                    configuration.label
                    Spacer()
                    Rectangle()
                        .foregroundColor(configuration.isOn ? .red : .green)
                        .frame(width: 50)
                        .overlay(
                            Text(configuration.isOn ? "Off" : "On").font(.system(size: 10))
                                .foregroundColor(configuration.isOn ? .red : .green)
                                .frame(width: 25, height: 25)
                                .background(Color.white)
                                .clipShape(Circle())
                                .offset(x: configuration.isOn ? 10 : -10, y: 0)
                                .animation(Animation.easeInOut(duration: 0.25))
                        ).clipShape(Capsule())
                        .onTapGesture { configuration.isOn.toggle() }
                }
            }
        }
}

struct CustomViews: View {

    @State var active: Bool = false
    @State var active2: Bool = false
    @State var active3: Bool = false
    @State var showSettings : Bool  = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Button(action: {
                
            }, label: {
                Text("Demo Button").foregroundColor(.white)
            }).buttonStyle(StylesSet.CustomButton())
            
            NavigationView {
                List {
                    NavigationLink(destination: PieContentView(), isActive: $showSettings) {
                        Button(action: {
                            self.showSettings = true
                        }, label: {
                            Text("Pie Contents")
                        })
                    }
                    .navigationBarTitle("Pie Contents")
                    .navigationBarHidden(false)
                    
                    Toggle(isOn: $active, label: {Text("Active")})
                        .toggleStyle(StylesSet.CustomToggle())
                    Toggle(isOn: $active, label: {Text("Active")})
                        .toggleStyle(StylesSet.CustomToggle())
                    Toggle(isOn: $active2, label: {Text("Active2")})
                        .toggleStyle(StylesSet.CustomToggle())
                    Toggle(isOn: $active3, label: {Text("Active3")})
                        .toggleStyle(StylesSet.CustomToggle())
                }
                .navigationTitle("Styling Demo")
            }
        }
        
        
    }
}

struct CustomViews_Previews: PreviewProvider {
    static var previews: some View {
        CustomViews(active: false)
    }
}
