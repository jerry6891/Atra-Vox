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

let songModel = ViewModel()
final class SubGenrasController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets.
    @IBOutlet private var tableView: UITableView!
    var identities = [String]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?

    // MARK: - FIREBASE METHODOLOGY STARTS: 'IBOutlets & Variables/Constants'
    // var genra: String?
    // var songs: [Song]
    // fileprivate var songs = [Music]()
    // Genras' Titles.
    // let genrasList = ["Raw Black Metal", "Atmospheric Black Metal", "Symphonic Black Metal", "Melodic Black Metal", "Depressive Black Metal", "Pagan Black Metal", "Evil Black Metal", "True Black Metal"]
    // MARK: - FIREBASE METHODOLOGY ENDS: 'IBOutlets & Variables/Constants'
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print(songModel.parseValues())
    }
    
    // MARK: -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    // MARK: - Table Views
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (songModel.result?.genras.count)!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.imageViewArrow.image = #imageLiteral(resourceName: "tablearrowicon")
        cell.labelGenras.text = songModel.result?.genras[indexPath.row].name
        return cell
        
        // MARK: - FIREBASE METHODOLOGY STARTS: 'cellForRowAt'
        // cell.imageViewArrow.image = UIImage(named: "tablearrowicon")
        // cell.labelGenras.text = genrasList[indexPath.row]
        // MARK: - FIREBASE METHODOLOGY ENDS: : 'cellForRowAt'
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "GenraController", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! GenraController
        // controller.genra = songModel.result?.genras[indexPath.row]
        genra = songModel.result?.genras[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
        
        // MARK: - FIREBASE METHODOLOGY STARTS: 'didSelectRowAt'
        // controller.genra = genrasList[indexPath.row]
        // controller.genra = songModel.result?.genras[indexPath.row].name
        // controller.songs = (songModel.result?.genras[indexPath.row].songs)!
        // MARK: - FIREBASE METHODOLOGY ENDS: 'didSelectRowAt'
    }
}
