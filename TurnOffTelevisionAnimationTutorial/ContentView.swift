//
//  ContentView.swift
//  TurnOffTelevisionAnimationTutorial
//
//  Created by Leonardo Maia Pugliese on 20/03/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            TurnOffTelevisionView(size: CGSize(width: 200, height: 200))
        }
    }
}

struct TurnOffTelevisionView: View {
    @State var maskHeight: CGFloat
    @State var maskWidth: CGFloat
    @State var overlayOpacity = 0.0
    @State var showCircle = false
    private let size: CGSize
    
    init(size: CGSize) {
        self.size = size
        maskHeight = size.height
        maskWidth = size.width
    }
    
    var body: some View {
        VStack {
            Image(systemName: "tv")
                .resizable()
                .frame(width: size.width, height: size.height)
                .overlay {
                    Color.white
                        .opacity(overlayOpacity)
                }
                .mask {
                    VStack {
                        Spacer()
                        if showCircle {
                            Circle()
                                .opacity(showCircle ? 1 : 0)
                                .frame(width: maskWidth, height: maskHeight)
                        } else {
                            RoundedRectangle(cornerRadius: 3)
                                .opacity(showCircle ? 0 : 1)
                                .frame(width: maskWidth, height: maskHeight)
                        }
 
                        Spacer()
                    }
                }.onAppear {
                    withAnimation(.easeIn(duration: 0.4).delay(1)) {
                        maskHeight = maskHeight - ( maskHeight * 0.98 )
                        overlayOpacity = 1
                    }
                    
                    withAnimation(.easeIn(duration: 0.1).delay(1.4)) {
                        maskWidth = maskWidth - (maskWidth * 0.98)
                    }
                    
                    withAnimation(.linear(duration: 0.05).delay(1.8)) {
                        showCircle = true
                    }
                    
                    withAnimation(.easeOut(duration: 0.1).delay(1.85)) {
                        maskWidth = maskWidth * 8
                        maskHeight = maskHeight * 8
                    }
                    
                    withAnimation(.linear(duration: 0.1).delay(1.95)) {
                        maskWidth = 0
                        maskHeight = 0
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
