//
//  PhotosController.swift
//  Users&Photos
//
//  Created by Sergey on 1/22/21.
//

import UIKit

class PhotosController: UICollectionViewController {
    
    //MARK: - Properties
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 30
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        return layout
    }()
    
    var user : UserModel?
    var photoManager = PhotoManager()
    var photosArray: [PhotoModel] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
    }
    
    deinit {
        print("Deleted from memory")
    }
    
    //MARK: - Helpers
    private func setInitialUI() {
        navigationItem.title = K.photosController
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.collectionViewLayout = layout
        //Set photoManagerDelegate
        photoManager.delegate = self
        //Fetch Photos
        fetchPhotos()
    }
    
    private func fetchPhotos() {
        guard let userId = user?.id else { return }
        photoManager.fetchPhotos(withUserId: userId)
    }
    
}

//MARK: - DataSource

extension PhotosController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        cell.configureCell(withModel: photosArray[indexPath.row])
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension PhotosController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 30, height: view.frame.size.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
}

//MARK: - PhotoManagerDelegate

extension PhotosController: PhotoManagerDelegate {
    
    func didFailWithError(error: Error) {
        Alert.showErrorAlert(on: self)
    }
    
    func didGetPhotos(_ photoManager: PhotoManager, result: [PhotoModel]) {
        photosArray = result
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}
