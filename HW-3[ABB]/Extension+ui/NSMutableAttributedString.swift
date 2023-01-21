//
//  Extension+UI.swift
//  HW-3[ABB]
//
//  Created by Abraam on 19.01.2023.
//

import UIKit
extension NSMutableAttributedString {
func highlightOccurrences(of searchTerm: String, with color: UIColor) {
    let range = NSRange(location: 0, length: self.length)
    let pattern = searchTerm
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    regex.enumerateMatches(in: self.string, options: [], range: range) { (result, _, _) in
        if let range = result?.range {
            addAttribute(.backgroundColor, value: color, range: range)
        }
    }
}
}
