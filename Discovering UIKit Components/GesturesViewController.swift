//
//  ViewController.swift
//  Understanding Gesture Recognizers
//
//  Created by Ambroise COLLON on 19/06/2017.
//  Copyright © 2017 Ambroise Collon. All rights reserved.
//

import UIKit

class GesturesViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var demoView: UIView!

    fileprivate func updateTitle(with text: String) {
        UIView.animate(withDuration: 0.1, animations: {
            self.titleLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (completed) in
            if completed {
                self.titleLabel.text = text
                UIView.animate(withDuration: 0.1, animations: {
                    self.titleLabel.transform = .identity
                })
            }
        }
    }
}

// MARK: - Tap
extension GesturesViewController {
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        updateTitle(with: "UITapGestureRecognizer")
        textView.text = ""
        animateWhiteFlash()
    }

    private func animateWhiteFlash() {
        let defaultColor = demoView.backgroundColor
        demoView.backgroundColor = UIColor.white
        UIView.animate(withDuration: 0.2) {
            self.demoView.backgroundColor = defaultColor
        }
    }
}

// MARK: - Long Press
extension GesturesViewController {
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            updateTitle(with: "UILongPressGestureRecognizer")
        }
        textView.text = ""
        animateRoundedCorner(gesture: sender)
    }

    private func animateRoundedCorner(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            startAnimatingRoundedCorner()
        case .ended:
            stopAnimatingRoundedCorner()
        default:
            break
        }
    }

    private func startAnimatingRoundedCorner() {
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.fromValue = 0.0
        animation.toValue = demoView.frame.size.height / 2
        animation.autoreverses = true
        animation.repeatCount = .greatestFiniteMagnitude
        animation.duration = 1
        demoView.layer.add(animation, forKey: "roundedCorner")
    }

    private func stopAnimatingRoundedCorner() {
        demoView.layer.removeAllAnimations()
        demoView.layer.cornerRadius = 0.0
    }
}

// MARK: - Pinch, Rotate, Pan
extension GesturesViewController {
    @IBAction func pinch(_ sender: UIPinchGestureRecognizer) {
        textView.text = "Scale : \(sender.scale)"

        let transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
        transformDemoWith(gesture: sender, title: "UIPinchGestureRecognizer", transform: transform)
    }

    @IBAction func rotate(_ sender: UIRotationGestureRecognizer) {
        textView.text = "Rotation : \(sender.rotation)"

        let transform = CGAffineTransform(rotationAngle: sender.rotation)
        transformDemoWith(gesture: sender, title: "UIRotationGestureRecognizer", transform: transform)
    }

    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        textView.text = "X Translation : \(sender.translation(in: demoView).x)\nY Translation : \(sender.translation(in: demoView).y)"
        let transform = CGAffineTransform(translationX: sender.translation(in: demoView).x, y: sender.translation(in: demoView).y)
        transformDemoWith(gesture: sender, title: "UIPanGestureRecognizer", transform: transform)
    }

    private func transformDemoWith(gesture: UIGestureRecognizer, title: String, transform: CGAffineTransform) {
        switch gesture.state {
        case .began:
            updateTitle(with: title)
        case .changed:
            demoView.transform = transform
        case .ended:
            gestureEnded()
        default:
            break
        }
    }

    private func gestureEnded() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2.0, options: [], animations: {
            self.demoView.transform = .identity
        }, completion: nil)
    }
}


// MARK: - Swipe
extension GesturesViewController {
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        updateTitle(with: "UISwipeGestureRecognizer")

        switch sender.direction {
        case UISwipeGestureRecognizerDirection.right:
            textView.text = "Direction : right"
            animateSwipe(translationX: view.frame.width, y: 0)
        case UISwipeGestureRecognizerDirection.left:
            textView.text = "Direction : left"
            animateSwipe(translationX: -view.frame.width, y: 0)
        case UISwipeGestureRecognizerDirection.up:
            textView.text = "Direction : up"
            animateSwipe(translationX: 0, y: -view.frame.height)
        case UISwipeGestureRecognizerDirection.down:
            textView.text = "Direction : down"
            animateSwipe(translationX: 0, y: view.frame.height)
        default:
            break
        }
    }

    private func animateSwipe(translationX x: CGFloat, y: CGFloat) {
        UIView.animate(withDuration: 0.5, animations: {
            self.demoView.transform = CGAffineTransform(translationX: x, y: y)
        }) { (completed) in
            if completed {
                self.demoView.transform = CGAffineTransform(translationX: -x, y: -y)
                self.animateBackToCenter()
            }
        }
    }

    private func animateBackToCenter() {
        UIView.animate(withDuration: 0.5, animations: {
            self.demoView.transform = .identity
        }, completion: nil)
    }
}

