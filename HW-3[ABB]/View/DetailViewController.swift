//
//  DetailViewController.swift
//  HW-3[ABB]
//
//  Created by Abraam on 18.01.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var book: Book?
    var searchTerm: String?
    var occurrences: Int?
    
    let  textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = book?.name
        view.addSubview(textView)
        view.addSubview(myLabel)
        makeTextViewText()
    }
    
    private func makeTextViewText() {
        if let book = book, let searchTerm = searchTerm {
        textView.text = book.text
        myLabel.text = "Occurrences: \(String(describing: occurrences))"
        let attributedString = NSMutableAttributedString(string: book.text)
        attributedString.mutableString.replacingOccurrences(of: searchTerm, with: "")
        attributedString.highlightOccurrences(of: searchTerm, with: UIColor.yellow)
        textView.attributedText = attributedString
        }
    }
}


//MARK: -  DetailViewController Constraints
extension DetailViewController  {
override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    NSLayoutConstraint.activate([
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5),
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5),
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        myLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        myLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        myLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        myLabel.heightAnchor.constraint(equalToConstant: 50)
    ])
}
}
