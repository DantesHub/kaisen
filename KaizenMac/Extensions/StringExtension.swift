//
//  StringExtension.swift
//  KaizenMac
//
//  Created by Dante Kim on 5/24/24.
//

import Foundation
import AppKit

extension String {
    /// Counts the occurrences of a substring in the string.
    func occurrences(of substring: String) -> Int {
        return self.components(separatedBy: substring).count - 1
    }
    
    func height(withConstrainedWidth width: CGFloat, font: NSFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
