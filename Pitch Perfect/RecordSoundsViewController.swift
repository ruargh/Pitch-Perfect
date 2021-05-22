//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ruargh on 2021/05/20.
//  Copyright © 2021 Ruargh Udacity. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
        
    }
    
    // MARK: - setRordingState utility function
    /**
     🛠️ Utility to enable and disable buttons according to state

     Calling this method with `true`:
     1) disables the `recordButton`
     2) enables the `stopRecordingButton`.
     3) sets the `recordingLabel` to `"Recording..."`
     
     Calling this method with `false`:
     1) enables the `recordButton`
     2) disables the `stopRecordingButton`.
     3) sets the `recordingLabel` to `"Tap to record"`
     

     - Parameter recording: Set to `true` if recording is in progress
     - Precondition: `recording` must be a Bool value.
     */
    
    func setRecordingState(recording: Bool) {
        
        stopRecordingButton.isEnabled = recording
        recordButton.isEnabled = !recording
        recordingLabel.text = recording ? "Recording..." : "Tap to record"
    }

    // MARK: - Start recording
    
    @IBAction func recordAudio(_ sender: AnyObject) {
        setRecordingState(recording: true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // MARK: - Stop recording
    
    @IBAction func stopRecording(_ sender: Any) {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        setRecordingState(recording: false)
    }
    
    // MARK: - Audio Recorder Delegate
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

