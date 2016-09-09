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

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darkvaderButton: UIButton!
    @IBOutlet weak var parrotButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!


    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!

    enum ButtonType: Int { case Slow = 0, Fast, ChipMunk, Vader, Echo, Reverb }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAudio()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.NotPlaying)
    }
    
    @IBAction func playAudio(sender: AnyObject) {
        print("Play Audio Button pressed")

        // Choose from diff buttons
        switch (ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .ChipMunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }

        // Update to playing state
        configureUI(.Playing)
    }

    @IBAction func stopPlaying(sender: AnyObject) {
        stopAudio()
    }

}
