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
import Kingfisher
import CoreMedia

var globalSongs = [Music]()
var globalMusic = [Song]()
public var timeObservationToken: Any?
final class MainPlayerController: UIViewController, AVAudioPlayerDelegate {
    
    // MARK: IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var sliderSong: UISlider!
    
    // MARK: - FIREBASE METHODOLOGY STARTS: 'IBOutlets & Variables/Constants'
    // var genra: String!
    // var timer:Timer?
    // MARK: - FIREBASE METHODOLOGY ENDS: 'IBOutlets & Variables/Constants'
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - FIREBASE METHODOLOGY STARTS: 'Volume'
        /* // Volume
        sliderSong.value = 0.5
        sliderSong.addTarget(self, action: #selector(transportSliderChanged(_:)), for: .valueChanged)
        */
        // MARK: - FIREBASE METHODOLOGY ENDS: 'Volume'
        
        sliderSong.minimumValue = 0
       avPlayer.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
       let interval = CMTime(seconds: 0.25, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            timeObservationToken = avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
                self?.updateAudioDuration(for: time)
            }
        
        // MARK: - FIREBASE METHODOLOGY STARTS: 'Initialization'
        // addTimeObserver()
        // MARK: - FIREBASE METHODOLOGY ENDS: 'Initialization'
    }
    
    override func viewDidAppear(_ animated: Bool) {
        titleLabel.text = thisSongName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Methods
    @IBAction func playTapped(_ sender: Any) {
        if avPlayer.rate == 1 {
            playButton.setBackgroundImage(#imageLiteral(resourceName: "play"), for: UIControlState.normal)
            playButton.setBackgroundImage(#imageLiteral(resourceName: "pause"), for: UIControlState.disabled)
            avPlayer.pause()
        } else {
            playButton.setBackgroundImage(#imageLiteral(resourceName: "pause"), for: UIControlState.normal)
            playButton.setBackgroundImage(#imageLiteral(resourceName: "play"), for: UIControlState.disabled)
            avPlayer.play()
        }
        
        // MARK: - FIREBASE METHODOLOGY STARTS: 'Player isPlaying'
        /* if player.isPlaying == true {
            player.pause()
            playButton.setBackgroundImage(#imageLiteral(resourceName: "play"), for: UIControlState.normal)
            playButton.setBackgroundImage(#imageLiteral(resourceName: "pause"), for: UIControlState.disabled)
        } else {
            player.play()
            playButton.setBackgroundImage(#imageLiteral(resourceName: "pause"), for: UIControlState.selected)
            playButton.setBackgroundImage(#imageLiteral(resourceName: "play"), for: UIControlState.disabled)
        } */
        // MARK: - FIREBASE METHODOLOGY ENDS: 'Player isPlaying'
    }
    
    func addTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
            guard let currentItem = avPlayer.currentItem else { return }
            self?.sliderSong.maximumValue = Float(currentItem.duration.seconds)
            self?.sliderSong.minimumValue = 0
            self?.sliderSong.value = Float(currentItem.currentTime().seconds)
        })
    }
    
    @IBAction func backwardTapped(_ sender: Any) {
        thisSong -= 1
        if thisSong < 0 {
            thisSong = (genra?.songs.count)! - 1
        }
        playThis(thisOne: (genra?.songs[thisSong])!)
        titleLabel.text = (genra?.songs[thisSong].band)! + " - " + (genra?.songs[thisSong].title)!
        avPlayer.play()
        
        // MARK: - FIREBASE METHODOLOGY STARTS: 'IF STATEMENT - NEXT SONG'
        /* if thisSong < globalSongs.count && thisSong >= 0 {
           playThis(thisOne: globalSongs[thisSong].url!)
            titleLabel.text = globalSongs[thisSong].band! + " - " + globalSongs[thisSong].title!
            // thisSong = thisSong-1
            thisSong = 0
        } else { }  */
        // MARK: - FIREBASE METHODOLOGY ENDS: 'IF STATEMENT - NEXT SONG'
        
        let interval = CMTime(seconds: 0.25, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            timeObservationToken = avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
                self?.updateAudioDuration(for: time)
            }
    }
    
    @IBAction func forwardTapped(_ sender: Any) {
        thisSong += 1
        if thisSong >= (genra?.songs.count)! {
            thisSong = 0
        }
        playThis(thisOne: (genra?.songs[thisSong])!)
        titleLabel.text = (genra?.songs[thisSong].band)! + " - " + (genra?.songs[thisSong].title)!
        avPlayer.play()
        
        // MARK: - FIREBASE METHODOLOGY STARTS: 'IF STATEMENT - PREVIOUS SONG'
        /* if thisSong < globalMusic.count-1 {
            playThis(thisOne: globalMusic[thisSong+1].url)
            titleLabel.text = globalMusic[thisSong+1].band + " - " + globalMusic[thisSong+1].title
            thisSong += 1
        } */
        // MARK: - FIREBASE METHODOLOGY ENDS: 'IF STATEMENT - PREVIOUS SONG'
        
        let interval = CMTime(seconds: 0.25, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            timeObservationToken = avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
                self?.updateAudioDuration(for: time)
            }
        
        // MARK: - FIREBASE METHODOLOGY STARTS: 'Unknown'
        // avPlayer.replaceCurrentItem(with: nil)
        /* let currentTime = CMTimeGetSeconds(avPlayer.currentTime())
        let newTime = currentTime + 5.0
        if newTime < 5.0 {
            let time: CMTime = CMTimeMake(Int64(newTime*1000), 1000)
            avPlayer.seek(to: time)
        } */
        // MARK: - FIREBASE METHODOLOGY ENDS: 'Unknown'
    }
    
    func updateAudioDuration(for time: CMTime) {
        // Slider Progress
        // guard let duration = globalSongs[thisSong].duration else { return }
        guard let duration = genra?.songs[thisSong].duration else { return }
        let progress = time.seconds / duration
        sliderSong?.value = Float(progress)
    }
    
    // @IBAction func transportSliderChanged(_ sender: Any) {}
    @IBAction func transportSliderChanged(_ sender: UISlider) {
        // MARK: - FIREBASE METHODOLOGY STARTS: 'Volume Function'
        /*
        // Slider Volume
        let value = sender.value
        avPlayer.volume = value
        */
        // MARK: - FIREBASE METHODOLOGY ENDS: 'Volume Function'
        
        // Slider Progress
        // let seconds = globalSongs[thisSong].duration! * Double(sliderSong.value)
        let seconds = (genra?.songs[thisSong].duration)! * Double(sliderSong.value)
        let time = CMTime(seconds: seconds, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        avPlayer.seek(to: time)
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
        } else {
            return String(format: "%02i:%02i", arguments: [minutes,seconds])
        }
    }
    
    
    func playThis(thisOne: Song) {
        guard let url = Bundle.main.url(forResource: thisOne.url, withExtension: "mp3") else { return }
        
        do {
            avPlayer = AVPlayer(url: url)
            avPlayer.prepareForInterfaceBuilder()
            avPlayer.play()
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, mode: AVAudioSessionModeDefault, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session Is Active")
        } catch let error { print(error.localizedDescription) }
    
        // MARK: - FIREBASE METHODOLOGY STARTS: 'PlayThis Firebase Function'
        /* if let mp3URL = URL(string: bmSong) {
            avPlayer = AVPlayer(url: mp3URL)
            avPlayer.play()
        } */
        // MARK: - FIREBASE METHODOLOGY ENDS: 'PlayThis Firebase Function'
    }
}

extension CMTime {
    var formattedString: String {
        let totalSeconds = seconds
        let hours = Int(totalSeconds / 3600)
        let minutes = Int(totalSeconds.truncatingRemainder(dividingBy: 3600)) / 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))

        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}
