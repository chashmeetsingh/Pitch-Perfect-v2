//
//  RecordAudioViewController.swift
//  Pitchify
//
//  Created by Y50-70 on 07/09/16.
//  Copyright © 2016 Chashmeet Singh. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var startRecordingButton: UIButton!

    var audioRecorder: AVAudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Disable button on load
        stopRecordingButton.enabled = false
    }

    func recordingActive(state: Bool){
        startRecordingButton.enabled = !state
        stopRecordingButton.enabled = state
        recordingLabel.text = state == true ? "Recording" : "Processing.."
    }

    @IBAction func startRecording(sender: AnyObject) {

        recordingActive(true)

        // Get directory
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String

        // Set name of file
        // Get complete path
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)

        // Get instance
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])

        // Start Recording
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(sender: AnyObject) {

        recordingActive(false)

        // Stop Recording
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {

        // Log message
        print("Recording finished")

        // Perform segue
        if flag {
            performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            print("Saving of recording failed")
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        // Check Identifier
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

}

