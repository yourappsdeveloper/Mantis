//
//  Enums.swift
//  Mantis
//
//  Created by Yingtao Guo on 11/28/21.
//

import UIKit

public enum PresetTransformationType {
    case none
    case presetInfo(info: Transformation)
    case presetNormalizedInfo(normailizedInfo: CGRect)
}

public enum PresetFixedRatioType {
    /** When choose alwaysUsingOnePresetFixedRatio, fixed-ratio setting button does not show.
     */
    case alwaysUsingOnePresetFixedRatio(ratio: Double = 0)
    case canUseMultiplePresetFixedRatio(defaultRatio: Double = 0)
}

public enum CropVisualEffectType {
    case blurDark
    case dark
    case light
    case none
}

public enum CropShapeType {
    
    case rect

    /**
      The ratio of the crop mask will always be 1:1.
     ### Notice
     It equals cropShapeType = .rect
     and presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1)
     */
    case square

    /**
     When maskOnly is true, the cropped image is kept rect
     */
    case ellipse(maskOnly: Bool = false)

    /**
      The ratio of the crop mask will always be 1:1 and when maskOnly is true, the cropped image is kept rect.
     ### Notice
     It equals cropShapeType = .ellipse and presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1)
     */
    case circle(maskOnly: Bool = false)

    /**
     When maskOnly is true, the cropped image is kept rect
     */
    case roundedRect(radiusToShortSide: CGFloat, maskOnly: Bool = false)

    case diamond(maskOnly: Bool = false)

    case heart(maskOnly: Bool = false)

    case polygon(sides: Int, offset: CGFloat = 0, maskOnly: Bool = false)

    /**
      Each point should have normailzed values whose range is 0...1
     */
    case path(points: [CGPoint], maskOnly: Bool = false)
    
    var title: String {
        switch self {
        case .rect:
            return "rect"
        case .square:
            return "square"
        case .ellipse:
            return "ellipse"
        case .circle:
            return "circle"
        case .roundedRect:
            return "rounded rect"
        case .diamond:
            return "diamond"
        case .heart:
            return "heart"
        case .polygon:
            return "polygon"
        case .path:
            return "custom path"
        }
    }
}

public enum RatioCandidatesShowType {
    case presentRatioList
    case alwaysShowRatioList
}

public enum FixRatiosShowType {
    case adaptive
    case horizontal
    case vetical
}
