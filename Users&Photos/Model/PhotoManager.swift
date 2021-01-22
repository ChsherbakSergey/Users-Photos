//
//  PhotoManager.swift
//  Users&Photos
//
//  Created by Sergey on 1/22/21.
//

import Foundation

protocol PhotoManagerDelegate: class {
    func didFailWithError(error: Error)
    func didGetPhotos(_ photoManager: PhotoManager, result: [PhotoModel])
}

class PhotoManager {
    
    let baseUrl = "https://jsonplaceholder.typicode.com/users/albums/photos"
    
    var userId: Int = 1
    
    weak var delegate: PhotoManagerDelegate?
    
    func fetchPhotos(withUserId id: Int) {
        userId = id
        performRequest(with: baseUrl)
    }
    
    func performRequest(with url: String) {
        //Create url
        guard let url = URL(string: url) else { return }
        //Create session
        let session = URLSession(configuration: .default)
        //Give session a task
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                self.delegate?.didFailWithError(error: error)
            }
            
            guard let safeData = data else { return }
            
            if let photos = self.parseJSON(safeData) {
                self.delegate?.didGetPhotos(self, result: photos)
            }
            
        }
        //Start the task
        task.resume()
    }
    
    func parseJSON(_ photosData: Data) -> [PhotoModel]? {
        let decoder = JSONDecoder()
        
        do {
            
            var photos: [PhotoModel] = []
            
            let decodedData = try decoder.decode([PhotoModel].self, from: photosData)
            
            for (i, _) in decodedData.enumerated() {
                if decodedData[i].albumId == userId {
                    let albumId = decodedData[i].albumId
                    let title = decodedData[i].title
                    let url = decodedData[i].url
                    let photo = PhotoModel(albumId: albumId, title: title, url: url)
                    photos.append(photo)
                }
                
            }
            
            return photos
            
        } catch {
            return nil
        }
    }
    
}
