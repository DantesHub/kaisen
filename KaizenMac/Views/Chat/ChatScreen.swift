//
//  ContentView.swift
//  XCAChatGPT
//
//  Created by Alfian Losari on 01/02/23.
//

import SwiftUI
import AVKit

struct ChatScreen: View {
        
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var vm: ChatViewModel
    @FocusState var isTextFieldFocused: Bool
    @State private var dynamicHeight: CGFloat = 36  // Initial fixed height for single line

    var body: some View {
        chatListView
    }
    
    var chatListView: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(vm.messages) { message in
                            MessageRowView(message: message) { message in
//                                Task { @MainActor in
//                                    await vm.retry(message: message)
//                                }
                            }
                        }
                    }
                    .onTapGesture {
                        isTextFieldFocused = false
                    }
                }
                #if os(iOS) || os(macOS)
                Divider()
                bottomView(image: "profile", proxy: proxy)
                Spacer()
                #endif
            }
            .onChange(of: vm.messages.last?.responseText) {
                scrollToBottom(proxy: proxy)
            }
        }
//        .background(colorScheme == .light ? .white : Color(red: 52/255, green: 53/255, blue: 65/255, opacity: 0.5))
    }
    func bottomView(image: String, proxy: ScrollViewProxy) -> some View {
        HStack(alignment: .bottom, spacing: 10) {
               Image(systemName: "camera.circle")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 35, height: 35)

               ZStack(alignment: .leading) {
//                   if vm.inputMessage.isEmpty {
//                       Text("Type something...")
//                           .foregroundColor(.gray)
//                           .padding(.horizontal, 15)
//                           .padding(.vertical, 12)  // ensure vertical padding aligns with TextEditor
//                   }
                   TextEditor(text: $vm.inputMessage)
                            .scrollDisabled(true)
                            .autocorrectionDisabled()
                            .font(.system(size: 14))
                            .padding(12)
                            .frame(minHeight: dynamicHeight, idealHeight: dynamicHeight, maxHeight: dynamicHeight)
                            .background(colorScheme == .dark ? Color.dark.cornerRadius(20) : Color.light.cornerRadius(20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .onChange(of: vm.inputMessage) {
                                let newHeight = vm.inputMessage.size(withAttributes: [.font: NSFont.systemFont(ofSize: 14)]).height + 24
                                dynamicHeight = max(36, min(newHeight, 150)) // Ensuring it's between 36 and 150
                            }
                            .focused($isTextFieldFocused)
               }
               
               if vm.isInterfacing {
                   Button {
//                       vm.cancelStreamingResponse()
                   } label: {
                       Image(systemName: "stop.circle.fill")
                           .font(.system(size: 30))
                           .foregroundColor(.red)
                   }
               } else {
                   Button {
                       Task {
                           isTextFieldFocused = false
                           scrollToBottom(proxy: proxy)
                           await vm.clickedSend()
                       }
                   } label: {
                       Image(systemName: "arrow.up.circle.fill")
                           .font(.system(size: 30))
                           .foregroundColor(.blue)
                   }
                   .disabled(vm.inputMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
               }
           }
           .padding(.horizontal, 10)
           .padding(.vertical, 8)
    }
    
    private func getHeight() -> CGFloat {
        let minHeight: CGFloat = 36
        let maxHeight: CGFloat = 150
        let lineCount = vm.inputMessage.occurrences(of: "\n") + 1
        return min(maxHeight, CGFloat(lineCount) * 24 + minHeight) // Basic calculation for dynamic height
    }


    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let id = vm.messages.last?.id else { return }
        proxy.scrollTo(id, anchor: .bottomTrailing)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChatScreen(vm: ChatViewModel())
        }
    }
}

