//
//  MainView.swift
//  KaizenMac
//
//  Created by Dante Kim on 5/24/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            // Use a VStack to manage the layout inside the NavigationView
            VStack {
                List {
                    NavigationLink(destination: HomeScreen()) {
                        Text("Genkai")
                            .foregroundColor(Color.black)
                    }
                
                }
                // Ensure List view takes up reasonable space
                .frame(minWidth: 200, idealWidth: 300, maxWidth: .infinity,
                       minHeight: 400, idealHeight: 600, maxHeight: .infinity)
            } // Add padding within the VStack if needed to avoid cramped layouts
            .padding()
        }
        .frame(minWidth: 800, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
        .navigationViewStyle(DefaultNavigationViewStyle()) // Use a navigation view style that's appropriate for macOS
    }
}

#Preview {
    MainView()  
        .frame(minWidth: 400, idealWidth: 600, maxWidth: .infinity,
                       minHeight: 400, idealHeight: 600, maxHeight: .infinity)
}
