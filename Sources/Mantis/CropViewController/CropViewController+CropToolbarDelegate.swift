//
//  CropViewController+CropToolbarDelegate.swift
//  Mantis
//
//  Created by Yingtao Guo on 11/28/21.
//

import UIKit

extension CropViewController: CropToolbarDelegate {
    public func didSelectCancel() {
        handleCancel()
    }
    
    public func didSelectCrop() {
        handleCrop()
    }
    
    public func didSelectCounterClockwiseRotate() {
        handleRotate(rotateAngle: -CGFloat.pi / 2)
    }
    
    public func didSelectClockwiseRotate() {
        handleRotate(rotateAngle: CGFloat.pi / 2)
    }
    
    public func didSelectReset() {
        handleReset()
    }
    
    public func didSelectSetRatio() {
        handleSetRatio()
    }
    
    public func didSelectRatio(ratio: Double) {
        setFixedRatio(ratio)
    }
    
    public func didSelectAlterCropper90Degree() {
        handleAlterCropper90Degree()
    }
    
    public func didSelectCropShape() {
        handleSelectCropShape()
    }
}
