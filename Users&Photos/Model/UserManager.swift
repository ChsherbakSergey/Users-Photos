//
//  UserManager.swift
//  Users&Photos
//
//  Created by Sergey on 1/22/21.
//

import Foundation

protocol UserManagerDelegate: class {
    func didFailWithError(error: Error)
    func didGetUsers(_ userManager: UserManager, result: [UserModel])
}

class UserManager {
    
    let baseUrl = "https://jsonplaceholder.typicode.com/users"
    
    weak var delegate: UserManagerDelegate?
    
    func fetchUsers() {
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
            
            if let users = self.parseJSON(safeData) {
                self.delegate?.didGetUsers(self, result: users)
            }
            
        }
        //Start the task
        task.resume()
    }
    
    func parseJSON(_ userData: Data) -> [UserModel]? {
        let decoder = JSONDecoder()
        
        do {
            var users: [UserModel] = []
            
            let decodedData = try decoder.decode([UserModel].self, from: userData)
            
            for (i, _) in decodedData.enumerated() {
                let id = decodedData[i].id
                let name = decodedData[i].name
                let user = UserModel(id: id, name: name)
                users.append(user)
            }
            
            return users
            
        } catch {
            return nil
        }
        
    }
    
}

