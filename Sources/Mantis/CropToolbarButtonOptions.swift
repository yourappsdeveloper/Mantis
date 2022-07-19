//
//  ToolbarButtonOptions.swift
//  Mantis
//
//  Created by Echo on 5/30/20.
//

import Foundation

public struct CropToolbarButtonOptions: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    static public let counterclockwiseRotate = CropToolbarButtonOptions(rawValue: 1 << 0)
    static public let clockwiseRotate = CropToolbarButtonOptions(rawValue: 1 << 1)
    static public let flipHorizontal = CropToolbarButtonOptions(rawValue: 1 << 2)
    static public let ratio = CropToolbarButtonOptions(rawValue: 1 << 3)
    static public let alterCropper90Degree = CropToolbarButtonOptions(rawValue: 1 << 4)
    
    static public let `default`: CropToolbarButtonOptions = [counterclockwiseRotate,
                                                             flipHorizontal,
                                                             ratio]
    
    static public let all: CropToolbarButtonOptions = [counterclockwiseRotate,
                                                       clockwiseRotate,
                                                       flipHorizontal,
                                                       ratio]
}
