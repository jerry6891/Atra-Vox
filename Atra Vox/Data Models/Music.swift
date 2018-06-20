//
//  Music.swift
//  Atra Vox
//
//  Created by Rex Karnufex on 2018-06-10.
//  Copyright © 2018 GWEB. All rights reserved.
//

import Foundation
import UIKit
import Firebase

final class Music{
    var genraName: String?
    var band: String?
    var title: String?
    var url: String?
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any] else{ return nil }
        self.genraName = ["genra name"] as? String
        self.band = value["band"] as? String
        self.title = value["title"] as? String
        self.url = value["url"] as? String
    }
}
