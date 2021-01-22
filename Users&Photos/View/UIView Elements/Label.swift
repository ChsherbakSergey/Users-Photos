//
//  Label.swift
//  Users&Photos
//
//  Created by Sergey on 1/22/21.
//

import UIKit

class Label: UILabel {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Init
    init(text: String?, fontSize: CGFloat, numberOfLines: Int) {
        super.init(frame: .zero)
        self.text = text
        self.font = .systemFont(ofSize: fontSize)
        self.numberOfLines = numberOfLines
        self.textAlignment = .left
    }
    
}
