//
//  Cell.swift
//  Atra Vox
//
//  Created by Rex Karnufex on 2018-06-04.
//  Copyright © 2018 GWEB. All rights reserved.
//

import Foundation
import Firebase
import UIKit

final class Cell: UITableViewCell{
    
    // MARK: IBOutlets
    @IBOutlet var imageViewArrow: UIImageView!
    @IBOutlet var labelGenras: UILabel!
    
    func setData(genra: Music){
        self.labelGenras.text = genra.genraName
        self.imageViewArrow.image = UIImage(named: "tablearrowicon")
    }
}
