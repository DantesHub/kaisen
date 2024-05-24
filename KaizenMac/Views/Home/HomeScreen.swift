//
//  HomeScreen.swift
//  KaizenMac
//
//  Created by Dante Kim on 5/24/24.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var chatVM: ChatViewModel = ChatViewModel()
    
    var body: some View {
        VStack {
            ChatScreen(vm: chatVM)
        }  .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeScreen()
}
