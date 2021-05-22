//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ruargh on 2021/05/21.
//  Copyright © 2021 Ruargh Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: - Call playSound function for the effects button pressed
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }

        configureUI(.playing)
    }
    
    // MARK: - Stop playing audio
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
        /// initialise buttons to `scaleAspectFit` contentMode to avoid image stretching
        
        snailButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.imageView?.contentMode = .scaleAspectFit
        rabbitButton.imageView?.contentMode = .scaleAspectFit
        vaderButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        
    }

}
