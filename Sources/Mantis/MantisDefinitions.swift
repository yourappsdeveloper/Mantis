//
//  definitions.swift
//  Mantis
//
//  Created by Echo on 8/8/21.
//

import Foundation
import UIKit

public typealias Transformation = (
    offset: CGPoint,
    rotation: CGFloat,
    scale: CGFloat,
    manualZoomed: Bool,
    intialMaskFrame: CGRect,
    maskFrame: CGRect,
    scrollBounds: CGRect
)

public typealias CropInfo = (translation: CGPoint, rotation: CGFloat, scale: CGFloat, cropSize: CGSize, imageViewSize: CGSize)


typealias OverlayEdgeType = (xDelta: CGFloat, yDelta: CGFloat)
typealias TappedEdgeCropFrameUpdateRule = [CropViewOverlayEdge: OverlayEdgeType]
