//
//  SettingsController.swift
//  Atra Vox
//
//  Created by Rex Karnufex on 2018-05-11.
//  Copyright © 2018 GWEB. All rights reserved.
//

import Foundation
import UIKit

final class SettingsController: UIViewController {
    
    @IBAction func shareButton(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["https://gerardolozano.myportfolio.com/"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func aboutButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AboutController", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! AboutController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func websiteButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://gerardolozano.myportfolio.com/")! as URL, options: [:], completionHandler: nil)
    }
}
