//
//  PlaySoundsViewController.swift
//  Pitchify
//
//  Created by Y50-70 on 07/09/16.
//  Copyright © 2016 Chashmeet Singh. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pitchSelection: UISegmentedControl!
    @IBOutlet weak var audioRate: UISlider!

    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!

    enum Slider: Int { case DarkVader = 0, ChipMunk }

    override func viewDidLoad() {
        super.viewDidLoad()

        stopButton.enabled = false
        setupAudio()
    }

    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
    
    @IBAction func playAudio(sender: AnyObject) {
        play()
    }

    func play() {

        // Get rate from slider
        let rate = Float(audioRate.value)

        // Choose from slider
        switch (Slider(rawValue: pitchSelection.selectedSegmentIndex)!) {
        case .DarkVader:
            playSound(rate: -rate)
        case .ChipMunk:
            playSound(rate: rate)
        }

        // Update to playing state
        configureUI(.Playing)
    }

    @IBAction func stopAudio(sender: AnyObject) {
        stopAudio()
    }


    @IBAction func rateChanged(sender: AnyObject) {
        stopAudio()
        play()
    }

}
