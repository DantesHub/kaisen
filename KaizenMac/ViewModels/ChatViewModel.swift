//
//  ChatViewModel.swift
//  KaizenMac
//
//  Created by Dante Kim on 5/24/24.
//

import Foundation

class ChatViewModel: ObservableObject {
    var messages: [Message] = []
    @Published var inputMessage: String = ""
    @Published var isInterfacing: Bool = false
    var task: Task<Void, Never>?

    
    func clickedSend() {
        isInterfacing = true
        var streamText = ""
        var messageRow = Message(
            isInteracting: true,
            sendImage: "profile",
            send: .rawText(inputMessage),
            responseImage: "api.provider.imageName",
            response: .rawText(streamText),
            responseError: nil)
        
        self.messages.append(messageRow)
        
        // response
        do {
//            let stream = try await api.sendMessageStream(text: inputMessage)
//            for try await text in stream {
//                streamText += text
//            messageRow.response = .rawText(streamText.trimmingCharacters(in: .whitespacesAndNewlines))
//                self.messages[self.messages.count - 1] = messageRow
//            }\
            messageRow.response = .rawText("deep this shit")

            self.messages[self.messages.count - 1] = messageRow
        } catch {
            messageRow.responseError = error.localizedDescription
        }
        
        messageRow.isInteracting = false
        self.messages[self.messages.count - 1] = messageRow
        isInterfacing = false
    }
}

