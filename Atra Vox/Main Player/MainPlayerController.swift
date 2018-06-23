//
//  MainPlayerController.swift
//  Atra Vox
//
//  Created by Rex Karnufex on 2018-05-10.
//  Copyright © 2018 GWEB. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVFoundation
import MediaPlayer
import AVKit

var globalSongs = [Music]()
final class MainPlayerController: UIViewController{
    
    // MARK: IBOutlets.
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var sliderSong: UISlider!
    
    var genra: String!
    var timer:Timer?
    
    // MARK: Initialization.
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderSong.minimumValue = 0
        avPlayer.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        // addTimeObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        titleLabel.text = thisSongName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Functions.
    @IBAction func playTapped(_ sender: Any) {
        if avPlayer.rate == 1{
            avPlayer.pause()
            playButton.setBackgroundImage(#imageLiteral(resourceName: "play"), for: UIControlState.normal)
            playButton.setBackgroundImage(#imageLiteral(resourceName: "pause"), for: UIControlState.disabled)
        } else {
            avPlayer.play()
            playButton.setBackgroundImage(#imageLiteral(resourceName: "pause"), for: UIControlState.normal)
            playButton.setBackgroundImage(#imageLiteral(resourceName: "play"), for: UIControlState.disabled)
        }
    }
    
    func addTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
            guard let currentItem = avPlayer.currentItem else {return}
            self?.sliderSong.maximumValue = Float(currentItem.duration.seconds)
            self?.sliderSong.minimumValue = 0
            self?.sliderSong.value = Float(currentItem.currentTime().seconds)
        })
    }
    
    @IBAction func backwardTapped(_ sender: Any) {
        if thisSong < globalSongs.count && thisSong >= 0{
           playThis(thisOne: globalSongs[thisSong].url!)
            titleLabel.text = globalSongs[thisSong].band! + " - " + globalSongs[thisSong].title!
            thisSong = thisSong-1
            // thisSong = 1
        } else { }
    }
    @IBAction func forwardTapped(_ sender: Any) {
        if thisSong < globalSongs.count-1{
           playThis(thisOne: globalSongs[thisSong+1].url!)
            titleLabel.text = globalSongs[thisSong+1].band! + " - " + globalSongs[thisSong+1].title!
            thisSong += 1
        }
        
        /* let currentTime = CMTimeGetSeconds(avPlayer.currentTime())
        let newTime = currentTime + 5.0
        if newTime < 5.0 {
            let time: CMTime = CMTimeMake(Int64(newTime*1000), 1000)
            avPlayer.seek(to: time)
        } */
    }
    @IBAction func updateAudioDuration(_ sender: UISlider) {
        avPlayer.volume = sender.value
        // avPlayer.seek(to: CMTimeMake(Int64(sender.value*1000), 1000))
    }
    
    func playThis(thisOne:String){
        let bmSong = thisOne
        if let mp3URL = URL(string: bmSong) {
            avPlayer = AVPlayer(url: mp3URL)
            avPlayer.play()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = avPlayer.currentItem?.duration.seconds, duration > 0.0 {
        }
    }
    
    func getTimeString(from time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int(totalSeconds/3600)
        let minutes = Int(totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
       if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours,minutes,seconds])
        }else {
            return String(format: "%02i:%02i", arguments: [minutes,seconds])
        }
    }
}
