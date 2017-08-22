//
//  Animation.swift
//  AnimationCurves
//
//  Created by Ambroise COLLON on 22/07/2017.
//  Copyright © 2017 OpenClassrooms. All rights reserved.
//

import Foundation

class Animation {
    enum Style {
        case simple, spring
    }

    enum Easing {
        case easeIn, easeOut, easeInOut
    }

    var style: Style = .simple
    var easing: Easing = .easeIn

    var dampingRatio: Float = 0.5
    var initialVelocity: Float = 0.5
    var duration: Float = 1.0

    static let shared = Animation()
    private init() {}
}
