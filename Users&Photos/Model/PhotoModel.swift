//
//  PhotoModel.swift
//  Users&Photos
//
//  Created by Sergey on 1/22/21.
//

import Foundation

struct PhotoModel: Decodable {
    let albumId: Int
    let title: String
    let url: String
}
