//
//  UsersCell.swift
//  Users&Photos
//
//  Created by Sergey on 1/22/21.
//

import UIKit

class UserCell: UITableViewCell {

    //MARK: - Properties
    static let identifier = "UsersCell"
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setInitialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func setInitialUI() {
        textLabel?.numberOfLines = 0
    }
    
    func configureCell(withModel model: UserModel) {
        textLabel?.text = model.name
    }

}
