//
//  ViewController.swift
//  Users&Photos
//
//  Created by Sergey on 1/22/21.
//

import UIKit

class UsersController: UITableViewController {
    
    //MARK: - Properties
    var userManager = UserManager()
    var usersArray : [UserModel] = []
    
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
        navigationItem.title = K.usersController
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.tableFooterView = UIView()
        //Set UserManagerDelegate
        userManager.delegate = self
        //Fetch Users
        userManager.fetchUsers()
    }
    
}

//MARK: - DataSource

extension UsersController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        cell.configureCell(withModel: usersArray[indexPath.row])
        return cell
    }
    
}

//MARK: - Delegate

extension UsersController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = PhotosController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.user = usersArray[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - UserManagerDelegate

extension UsersController: UserManagerDelegate {
    
    func didGetUsers(_ userManager: UserManager, result: [UserModel]) {
        usersArray = result
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        Alert.showErrorAlert(on: self)
    }
    
}
