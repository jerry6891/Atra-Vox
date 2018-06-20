//
//  ViewController.swift
//  Atra Vox
//
//  Created by Rex Karnufex on 2018-05-06.
//  Copyright © 2018 GWEB. All rights reserved.
//

import Foundation
import UIKit
import Firebase

final class SubGenrasController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: IBOutlets.
    @IBOutlet private var tableView: UITableView!
    var identities = [String]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    // Genras' Names.
    let genrasList = ["Raw Black Metal", "Atmospheric Black Metal", "Symphonic Black Metal", "Melodic Black Metal", "Depressive Black Metal", "Pagan Black Metal", "Evil Black Metal", "True Black Metal"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // ref = Database.database().reference()
        /* databaseHandle = ref?.child("Songs").observe(.childAdded, with: { (snapshot) in
            let identity = snapshot.value as? String
            if let actualIdentity = identity{
                self.identities.append(actualIdentity)
                self.tableView.reloadData()
            }
        }) */
        // Additional setup after loading the view.
        // identities = ["RBM", "ABM", "SBM", "MBM", "DBM", "PGM", "EBM", "TBM"]
    }
    
    // MARK: -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    // Mark: -
    // Mark: Table Views
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return genrasList.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.imageViewArrow.image = UIImage(named: (genrasList[indexPath.row] + ".png"))
        cell.imageViewArrow.image = #imageLiteral(resourceName: "tablearrowicon")
        cell.labelGenras.text = genrasList[indexPath.row]
        return(cell)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let storyboard = UIStoryboard(name: "GenraController", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! GenraController
        navigationController?.pushViewController(controller, animated: true)
        controller.genra = genrasList[indexPath.row]
    }
}

