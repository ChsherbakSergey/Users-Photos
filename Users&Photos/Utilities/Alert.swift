//
//  Alert.swift
//  Users&Photos
//
//  Created by Sergey on 1/23/21.
//

import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true, completion: nil) }
    }
    
    static func showErrorAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Error Loading Data", message: "Please, check your internet connection")
    }
    
}
