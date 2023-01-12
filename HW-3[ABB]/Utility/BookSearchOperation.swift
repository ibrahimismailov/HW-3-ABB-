//
//  BookSearchOperation.swift
//  HW-3[ABB]
//
//  Created by Abraam on 12.01.2023.
//

import UIKit
class BookSearchOperation: Operation {
    let searchTerm: String
    let bookText: String
    var occurrences = 0

    init(searchTerm: String, bookText: String) {
        self.searchTerm = searchTerm
        self.bookText = bookText
    }

    override func main() {
        let range = NSRange(location: 0, length: bookText.utf16.count)
        let regex = try? NSRegularExpression(pattern: searchTerm, options: .caseInsensitive)
        occurrences = regex?.numberOfMatches(in: bookText, options: .withTransparentBounds, range: range) ?? 0
    }
}
