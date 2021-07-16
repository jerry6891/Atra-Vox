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

final class SongsCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var bandLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    func setData(song: Song) {
        self.bandLabel.text = song.band
        self.titleLabel.text = song.title
        // self.titleLabel.text = genra.title?.trunc(length: 16)
    }
}

extension String {
    func trunc(length: Int, trailing: String = "…") -> String {
        if (self.count <= length) {
          return self
        }
        var truncated = self.prefix(length)
        while truncated.last != " " {

              guard truncated.count > length else {
                break
              }
          truncated = truncated.dropLast()
        }
        return truncated + trailing
      }
}
