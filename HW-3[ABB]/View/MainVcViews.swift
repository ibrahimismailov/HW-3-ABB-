//
//  MainVcViews.swift
//  HW-3[ABB]
//
//  Created by Abraam on 12.01.2023.
//

import UIKit
    //MARK: - SearcButton
class SearcButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    func setupButton() {
        setTitle("Search", for: .normal)
        backgroundColor = .blue
        layer.cornerRadius = 10
        setTitleColor(.systemBackground, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 18, weight: .heavy, width: .compressed)
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
}
//MARK: -

