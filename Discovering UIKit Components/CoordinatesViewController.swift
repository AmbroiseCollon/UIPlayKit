//
//  ViewController.swift
//  UIView Coordinate System
//
//  Created by Ambroise COLLON on 03/07/2017.
//  Copyright © 2017 OpenClassrooms. All rights reserved.
//

import UIKit

class CoordinatesViewController: UIViewController {

    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var boundsView: UIView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var frameLabel: UILabel!
    @IBOutlet weak var boundsLabel: UILabel!

    let width: CGFloat = 112
    let height: CGFloat = 130

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centerViews()
    }

    private func centerViews() {
        print(contentView.frame.midY)
        print(contentView.frame.size.height)
        let frame = CGRect(
            x: contentView.frame.width/2 - width/2,
            y: contentView.frame.height/2 - height/2,
            width: width,
            height: height)
        frameView.frame = frame
        boundsView.frame = frame
    }

    private func updateLabels() {
        var frameText = String(format: "x: %.2f\n", boundsView.frame.origin.x)
        frameText += String(format: "y: %.2f\n", boundsView.frame.origin.y)
        frameText += String(format: "width: %.2f\n", boundsView.frame.size.width)
        frameText += String(format: "height: %.2f", boundsView.frame.size.height)
        frameLabel.text = frameText

        var boundsText = "x: \(boundsView.bounds.origin.x)\n"
        boundsText += "y: \(boundsView.bounds.origin.y)\n"
        boundsText += "width: \(boundsView.bounds.size.width)\n"
        boundsText += "height: \(boundsView.bounds.size.height)"
        boundsLabel.text = boundsText
    }

    @IBAction func moveView(_ sender: UIPanGestureRecognizer) {
        let transitionX = sender.translation(in: view).x
        let transitionY = sender.translation(in: view).y

        let origin = boundsView.frame.origin
        let size = boundsView.frame.size

        boundsView.frame = CGRect(
            origin: CGPoint(x: origin.x + transitionX, y: origin.y + transitionY),
            size: size)
        frameView.frame = boundsView.frame

        sender.setTranslation(CGPoint.zero, in: self.view)
        updateLabels()
    }

    @IBAction func rotate(_ sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            let transform = CGAffineTransform(rotationAngle: sender.rotation)
            boundsView.transform = transform
            frameView.frame = boundsView.frame
            updateLabels()
        case .ended:
            UIView.animate(withDuration: 0.3, animations: {
                self.boundsView.transform = .identity
                self.frameView.frame = self.boundsView.frame
                self.updateLabels()
            })
        default:
            break
        }
    }
}
