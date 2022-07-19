//
//  DialConfig.swift
//  Mantis
//
//  Created by Echo on 5/22/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

// MARK: - DialConfig
public struct DialConfig {
    public init() {}

    public var margin: Double = 10
    public var interactable = false
    public var rotationLimitType: RotationLimitType = .limit(angle: CGAngle(degrees: 45))
    public var angleShowLimitType: AngleShowLimitType = .limit(angle: CGAngle(degrees: 40))
    public var rotationCenterType: RotationCenterType = .useDefault
    public var numberShowSpan = 1
    public var orientation: Orientation = .normal

    public var backgroundColor: UIColor = .clear
    public var bigScaleColor: UIColor = .white
    public var smallScaleColor: UIColor = .white
    public var indicatorColor: UIColor = .white
    public var numberColor: UIColor = .white
    public var centerAxisColor: UIColor = .white

    public var theme: Theme = .dark {
        didSet {
            switch theme {
            case .dark:
                backgroundColor = .clear
                bigScaleColor = .white
                smallScaleColor = .white
                indicatorColor = .white
                numberColor = .white
                centerAxisColor = .white
            case .light:
                backgroundColor = .clear
                bigScaleColor = .darkGray
                smallScaleColor = .darkGray
                indicatorColor = .darkGray
                numberColor = .darkGray
                centerAxisColor = .darkGray
            }
        }
    }

    public enum RotationCenterType {
        case useDefault
        case custom(CGPoint)
    }

    public enum AngleShowLimitType {
        case noLimit
        case limit(angle: CGAngle)
    }

    public enum RotationLimitType {
        case noLimit
        case limit(angle: CGAngle)
    }

    public enum Orientation {
        case normal
        case right
        case left
        case upsideDown
    }

    public enum Theme {
        case dark
        case light
    }
}
