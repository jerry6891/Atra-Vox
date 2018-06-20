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

var avPlayer: AVPlayer = AVPlayer()
var avAudioPlayer: AVAudioPlayer!
var thisSong = 0
var thisSongName = "\(thisSong)"
final class GenraController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate{
    
    var ref: DatabaseReference!
    
    // MARK: IBOutlets
    @IBOutlet private var subGenrasName: UILabel!
    @IBOutlet var tableView: UITableView!
    var genra: String!
    fileprivate var songs = [Music]()
    
    /* func playSoundWith(fileName: String, fileExtension: String) -> Void{
        let audioSourceUrl: URL!
        audioSourceUrl = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        if audioSourceUrl == nil{
            print("Requested Song Can't Be Played.")
        } else {
            do {
                player = try AVAudioPlayer.init(contentsOf: audioSourceUrl!)
                player.prepareToPlay()
                player.play()
            } catch {
                print(error)
            }
        }
    } */
    
    // MARK: Initialization.
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView?.rowHeight = 40.0
        load()
        let audioSession = AVAudioSession.sharedInstance()
        do { try audioSession.setCategory(AVAudioSessionCategoryPlayback) } catch { print(error) }
    }
    
    // MARK: Loading.
    fileprivate func load(){
        Database.database().reference().child("Songs").child(genra).observeSingleEvent(of: .value) { snapshot in
            var songs = [Music]()
            for child in snapshot.children{
                guard let child = child as? DataSnapshot,
                    let song = Music(snapshot: child) else{ continue }
                songs.append(song)
            }
            self.songs = songs
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return songs.count
    }
    
    /* public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    } */
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongsCell", for: indexPath) as! SongsCell
        let genra = songs[indexPath.row]
        cell.setData(genra: genra)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let bmSong = songs[indexPath.row].url
        if let mp3URL = URL(string: bmSong!) {
            avPlayer = AVPlayer(url: mp3URL)
            avPlayer.play()
            // thisSongName = songs[indexPath.row].band! + " - " + songs[indexPath.row].title!
        }
        thisSong = indexPath.row
        thisSongName = songs[indexPath.row].title!
        /* do {
            let bmSong = songs[indexPath.row].url
            if let mp3URL = URL(string: bmSong!) {
            avAudioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
            avAudioPlayer.play()
            }
        } catch { print("Error") } */
    }
}
