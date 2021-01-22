//
//  PhotosCell.swift
//  Users&Photos
//
//  Created by Sergey on 1/22/21.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "PhotosCell"
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()

    let photoView = PhotoImageView(cornerRadius: 10)
    let titleLabel = Label(text: "Caption", fontSize: 16, numberOfLines: 0)
    let indicatorView = UIActivityIndicatorView(style: .large)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setInitialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    //MARK: - Helpers
    private func setInitialUI() {
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        addViews()
        layoutViews()
        setShadow()
    }
    
    private func addViews() {
        contentView.addSubview(photoView)
        photoView.addSubview(indicatorView)
        contentView.addSubview(titleLabel)
    }
    
    private func layoutViews() {
        titleLabel.anchor(left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        photoView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: titleLabel.topAnchor, right: contentView.rightAnchor, paddingBottom: 10)
        indicatorView.center(inView: photoView)
        contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    private func setShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 2.0
    }
    
    func configureCell(withModel model: PhotoModel) {
        titleLabel.text = model.title
        downloadImage(withUrl: model.url)
    }
    
    private func downloadImage(withUrl imageUrl: String) {
        indicatorView.startAnimating()
        
        let imageCashe = NSCache<NSString, UIImage>()
        
        guard let url = URL(string: imageUrl) else { return }
        
        if let cashedImage = imageCashe.object(forKey: url.absoluteString as NSString) {
            
            DispatchQueue.main.async {
                self.photoView.image = cashedImage
            }
            
        } else {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                guard error == nil, data != nil, let safeData = data else { return }
                guard let image = UIImage(data: safeData) else { return }
                imageCashe.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    self.indicatorView.stopAnimating()
                    self.indicatorView.removeFromSuperview()
                    self.photoView.image = image
                }
                
            }
            task.resume()
        }
        
    }
    
}
