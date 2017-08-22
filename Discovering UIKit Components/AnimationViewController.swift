//
//  ViewController.swift
//  AnimationCurves
//
//  Created by Ambroise COLLON on 22/07/2017.
//  Copyright © 2017 OpenClassrooms. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var whiteLine: UIView!

    var isAnimating = false
    var animation = Animation.shared

    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resetAnimatedView()
    }

    private func resetAnimatedView() {
        animatedView.transform = .identity
        isAnimating = false
    }

    @IBAction func play(_ sender: UITapGestureRecognizer) {
        if !isAnimating {
            isAnimating = true
            switch animation.style {
            case .simple:
                playSimpleAnimation()
            case .spring:
                playSpringAnimation()
            }
        }
    }

    private func playSimpleAnimation() {
        UIView.animate(withDuration: TimeInterval(animation.duration),
                       delay: 0,
                       options: getOptions(), animations: { 
            self.animatedView.transform = CGAffineTransform(translationX: 0, y: self.whiteLine.frame.height)
        }) { (success) in
            if success {
                self.endAnimation()
            }
        }
    }

    private func playSpringAnimation() {
        UIView.animate(withDuration: TimeInterval(animation.duration),
                       delay: 0,
                       usingSpringWithDamping: CGFloat(animation.dampingRatio),
                       initialSpringVelocity: CGFloat(animation.initialVelocity),
                       options: getOptions(),
                       animations: {
            self.animatedView.transform = CGAffineTransform(translationX: 0, y: self.whiteLine.frame.height)
        }) { (success) in
            if success {
                self.endAnimation()
            }
        }
    }

    private func getOptions() -> UIViewAnimationOptions {
        switch animation.easing {
        case .easeIn:
            return [.curveEaseIn]
        case .easeOut:
            return [.curveEaseOut]
        case .easeInOut:
            return [.curveEaseInOut]
        }
    }

    private func endAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
            self.resetAnimatedView()
        })
    }
}

