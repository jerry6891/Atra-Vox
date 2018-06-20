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

final class MainPlayerController: UIViewController{
    
    // MARK: IBOutlets.
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var sliderSong: UISlider!
    
    fileprivate var songs = [Music]()
    var genra: String!
    var timer:Timer?
    var avAudioPlayer: AVAudioPlayer!
    
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
    @IBAction func backwardTapped(_ sender: Any) {
        if thisSong == 1{
            playThis(thisOne: songs[thisSong-1].url!)
            thisSong -= 1
            // titleLabel.text = songs[thisSong].title
        } else { }
    }
    @IBAction func forwardTapped(_ sender: Any) {
        if thisSong < songs.count+1{
            playThis(thisOne: songs[thisSong+1].url!)
            thisSong += 1
            // titleLabel.text = songs[thisSong].title
        } else { }
        /* thisSong = thisSong + 1
        if thisSong >= songs.count {
            thisSong = 0
        }
        avPlayer.play() */
    }
    @IBAction func updateAudioDuration(_ sender: UISlider) {
        avPlayer.volume = sender.value
        // avPlayer.currentItem?.currentTime().value
        /* avPlayer.pause()
        let curTime = sliderSong.value
        avPlayer.currentTime() = TimeInterval(curTime)
        avPlayer.play() */
    }
    @objc func changeSliderValueFollowPlayerCurTime(){
        let curValue = Float(avAudioPlayer.currentTime)
        sliderSong.value = curValue
    }
    
    func playThis(thisOne:String){
        let bmSong = thisSongName
        if let mp3URL = URL(string: bmSong) {
            avPlayer = AVPlayer(url: mp3URL)
            avPlayer.play()
        }
        
        /* let bmSong = thisOne
        if let mp3URL = URL(string: bmSong) {
            do { avAudioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
            sliderSong.maximumValue = Float(avAudioPlayer.duration)
            // thisSong += 1
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeSliderValueFollowPlayerCurTime), userInfo: nil, repeats: true)
            avPlayer.play()
            } catch { print(error) }
        } */
    }
    
    // MARK: Initialization.
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = thisSongName
        sliderSong.minimumValue = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
