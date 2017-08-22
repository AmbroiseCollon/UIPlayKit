//
//  AnimationSettingsViewController.swift
//  AnimationCurves
//
//  Created by Ambroise COLLON on 23/07/2017.
//  Copyright © 2017 OpenClassrooms. All rights reserved.
//

import UIKit

class AnimationSettingsViewController: UIViewController {

    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var easingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var animationTypeSwitch: UISwitch!
    @IBOutlet weak var dampingLabel: UILabel!
    @IBOutlet weak var dampingSlider: UISlider!
    @IBOutlet weak var dampingView: UIStackView!
    @IBOutlet weak var initialVelocityView: UIStackView!
    @IBOutlet weak var initialVelocityLabel: UILabel!
    @IBOutlet weak var initialVelocitySlider: UISlider!

    var animation = Animation.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        durationLabel.text = String(format: "%.2fs", animation.duration)
        durationSlider.value = Float(animation.duration)

        switch animation.easing {
        case .easeIn:
            easingSegmentedControl.selectedSegmentIndex = 0
        case .easeOut:
            easingSegmentedControl.selectedSegmentIndex = 1
        case .easeInOut:
            easingSegmentedControl.selectedSegmentIndex = 2
        }

        animationTypeSwitch.isOn = animation.style == .spring

        dampingView.alpha = (animation.style == .spring) ? 1 : 0
        dampingLabel.text = String(format: "%.2fs", animation.dampingRatio)
        dampingSlider.value = animation.dampingRatio

        initialVelocityView.alpha = (animation.style == .spring) ? 1 : 0
        initialVelocityLabel.text = String(format: "%.2fs", animation.initialVelocity)
        initialVelocitySlider.value = animation.initialVelocity
    }


    @IBAction func durationDidChange(_ sender: UISlider) {
        animation.duration = sender.value
        durationLabel.text = String(format: "%.2fs", animation.duration)
    }

    @IBAction func easingDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            animation.easing = .easeIn
        case 1:
            animation.easing = .easeOut
        case 2:
            animation.easing = .easeInOut
        default:
            break
        }
    }

    @IBAction func animationTypeDidChange(_ sender: UISwitch) {
        animation.style = sender.isOn ? .spring : .simple
        dampingView.alpha = (animation.style == .spring) ? 1 : 0
        initialVelocityView.alpha = (animation.style == .spring) ? 1 : 0
    }

    @IBAction func dampingDidChange(_ sender: UISlider) {
        animation.dampingRatio = sender.value
        dampingLabel.text = String(format: "%.2fs", animation.dampingRatio)
    }

    @IBAction func initialVelocityDidChange(_ sender: UISlider) {
        animation.initialVelocity = sender.value
        initialVelocityLabel.text = String(format: "%.2fs", animation.initialVelocity)
    }

    @IBAction func save() {
        dismiss(animated: true, completion: nil)
    }
}
