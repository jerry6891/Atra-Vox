//
//  RBMController.swift
//  Atra Vox
//
//  Created by Rex Karnufex on 2018-06-08.
//  Copyright © 2018 GWEB. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVFoundation
import MediaPlayer
import AVKit
import Kingfisher

var avPlayer: AVPlayer = AVPlayer()
var player: AVAudioPlayer = AVAudioPlayer()
var avAudioPlayer: AVAudioPlayer!
var thisSong = 0
var thisSongName = ""
var genra: Genra?
final class GenraController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate {
    
    var ref: DatabaseReference!
    
    // MARK: IBOutlets
    @IBOutlet private var subGenrasName: UILabel!
    @IBOutlet var tableView: UITableView!
    var xSongs: Song?
    
    // MARK: - FIREBASE METHODOLOGY STARTS: 'IBOutlets & Variables/Constants'
    // var genra: String?
    // var songs: [Song]
    // fileprivate var songs = [Music]()
    // MARK: - FIREBASE METHODOLOGY ENDS: 'IBOutlets & Variables/Constants'
    
    // MARK: Initialization.
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView?.rowHeight = 94.0
        // load()
        let audioSession = AVAudioSession.sharedInstance()
        do { try audioSession.setCategory(AVAudioSessionCategoryPlayback) } catch { print(error) }
    }
    
    // MARK: - FIREBASE METHODOLOGY STARTS: 'LOADING'
    // MARK: Loading.
    /* fileprivate func load() {
        Database.database().reference().child("Songs").child(genra).observeSingleEvent(of: .value) { snapshot in
            var songs = [Music]()
            for child in snapshot.children {
                guard let child = child as? DataSnapshot,
                    let song = Music(snapshot: child) else { continue }
                songs.append(song)
            }
            // self.songs = songs
            globalSongs = songs
            self.tableView.reloadData()
        }
    } */
    // MARK: - FIREBASE METHODOLOGY ENDS: 'LOADING'
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (genra?.songs.count)!
    }
    
    // MARK: - FIREBASE METHODOLOGY STARTS: 'Unknown'
    /* public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    } */
    // MARK: - FIREBASE METHODOLOGY ENDS: 'Unknown'
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongsCell", for: indexPath) as! SongsCell
        cell.setData(song: (genra?.songs[indexPath.row])!)
        return cell
        
        // MARK: - FIREBASE METHODOLOGY STARTS: 'cellForRowAt'
        // let genra = globalSongs[indexPath.row]
        // cell.setData(genra: genra)
        // let genraSongs = songModel.result?.genras[indexPath.row].songs
        // cell.setData(song: genraSongs)
        // MARK: - FIREBASE METHODOLOGY ENDS: : 'cellForRowAt'
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        thisSong = indexPath.row
        thisSongName = (genra?.songs[thisSong].band)! + " - " + (genra?.songs[thisSong].title)!
        let url = Bundle.main.url(forResource: genra?.songs[indexPath.row].url, withExtension: "mp3")
        
        do {
            avPlayer = AVPlayer(url: url!)
            avPlayer.prepareForInterfaceBuilder()
            avPlayer.play()
            
           /* player = try AVAudioPlayer(contentsOf: url!)
            player.delegate = self
            player.prepareToPlay()
            player.play() */
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, mode: AVAudioSessionModeDefault, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session Is Active")
        } catch let error { print(error.localizedDescription) }
        
        let storyboard = UIStoryboard(name: "MainPlayerController", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainPlayerController") as! MainPlayerController
        navigationController?.pushViewController(controller, animated: true)
        
        // MARK: - FIREBASE METHODOLOGY STARTS: 'didSelectRowAt'
        // thisSongName = globalSongs[thisSong].band! + " - " + globalSongs[thisSong].title!
        // let bmSong = globalSongs[indexPath.row].url
        /* let bmSong = genra?.songs[indexPath.row].url
         
        if let mp3URL = URL(string: bmSong!) {
                avPlayer = AVPlayer(url: mp3URL)
                avPlayer.play()
            } else {} */
        
        /* guard let audioURL = URL(string: globalSongs[indexPath.row].url!) else { return }
        let player = AVPlayer(url: audioURL)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller, animated: true) {
            player.play()
        } */
        
        /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "SecondViewController")
        show(secondVC, sender: self) */
        // MARK: - FIREBASE METHODOLOGY ENDS: 'didSelectRowAt'
    }
}
