//
//  ContentView.swift
//  DarkNight
//
//  Created by ronik on 12/27/23.
//

import SwiftUI

struct ContentView: View {
    // Environment variable to detect the current color scheme
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            // Background Image
            var bgType = colorScheme == .light ? "bg-light" : "bg-dark"
            Image(bgType)
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(.all)
            
            // Text on top
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.secondary)
                Text("Hello, world!")
                    .foregroundColor(.primary)
            }
        }
    }
}

#Preview {
    ContentView()
}
