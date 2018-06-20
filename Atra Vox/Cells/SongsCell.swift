//
//  SongsCell.swift
//  Atra Vox
//
//  Created by Rex Karnufex on 2018-06-11.
//  Copyright © 2018 GWEB. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import Kingfisher

final class SongsCell: UITableViewCell{
    
    // MARK: IBOutlets
    @IBOutlet private var bandLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    func setData(genra: Music){
        self.bandLabel.text = genra.band
        self.titleLabel.text = genra.title
    }
}
