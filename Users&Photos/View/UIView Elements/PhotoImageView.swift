//
//  ImageView.swift
//  Users&Photos
//
//  Created by Sergey on 1/22/21.
//

import UIKit

class PhotoImageView: UIImageView {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Init
    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.image = UIImage(named: "white")
    }
    
}
