//
//  CropToolbarConfig.swift
//  Mantis
//
//  Created by Yingtao Guo on 11/28/21.
//

import UIKit

public struct CropToolbarConfig {
    public var optionButtonFontSize: CGFloat = 14
    public var optionButtonFontSizeForPad: CGFloat = 20
    public var cropToolbarHeightForVertialOrientation: CGFloat = 44
    public var cropToolbarWidthForHorizontalOrientation: CGFloat = 80
    public var ratioCandidatesShowType: RatioCandidatesShowType = .presentRatioList
    public var fixRatiosShowType: FixRatiosShowType = .adaptive
    public var toolbarButtonOptions: ToolbarButtonOptions = .default
    public var presetRatiosButtonSelected = false
    
    public var cropShapeCandidates: [CropShapeTypeCandidate] = [CropShapeTypeCandidate(shapeType: .rect)]

    var mode: CropToolbarMode = .normal
    var includeFixedRatioSettingButton = true
}
