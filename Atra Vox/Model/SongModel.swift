//
//  SongModel.swift
//  Atra Vox
//
//  Created by Rex Karnufex on 5/22/21.
//  Copyright © 2021 GWEB. All rights reserved.
//

import UIKit
import Foundation

// MARK: - SongModel
struct SongModel: Codable {
    let genras: [Genra]

    enum CodingKeys: String, CodingKey {
        case genras = "Genras"
    }
}

// MARK: - Genra
struct Genra: Codable {
    let name: String
    let songs: [Song]

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case songs = "Songs"
    }
}

// MARK: - Song
struct Song: Codable {
    let band: String
    let duration: Double
    let title: String
    let url: String
}
