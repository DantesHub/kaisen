//
//  Message.swift
//  KaizenMac
//
//  Created by Dante Kim on 5/24/24.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
   
   var isInteracting: Bool
   
   let sendImage: String
   var send: MessageRowType
   var sendText: String {
       send.text
   }
   
   let responseImage: String
   var response: MessageRowType?
   var responseText: String? {
       response?.text
   }
   
   var responseError: String?
}


struct AttributedOutput {
    let string: String
    let results: [ParserResult]
}

enum MessageRowType {
    case attributed(AttributedOutput)
    case rawText(String)
    
    var text: String {
        switch self {
        case .attributed(let attributedOutput):
            return attributedOutput.string
        case .rawText(let string):
            return string
        }
    }
}

struct ParserResult: Identifiable {
    let id = UUID()
    let attributedString: AttributedString
    let isCodeBlock: Bool
    let codeBlockLanguage: String?
}
