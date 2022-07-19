//
//  CropToolbar.swift
//  Mantis
//
//  Created by Echo on 11/6/18.
//  Copyright © 2018 Echo. All rights reserved.
//

import UIKit

public enum CropToolbarMode {
    case normal
    case simple // Without cancel and crop buttons
}

public class CropToolbar: UIView, CropToolbarProtocol {
    private(set) public var config: CropToolbarConfigProtocol?
    
    public var iconProvider: CropToolbarIconProvider?
    
    public weak var cropToolbarDelegate: CropToolbarDelegate?
        
    private lazy var counterClockwiseRotationButton: UIButton = {
        let button = createOptionButton(withTitle: nil, andAction: #selector(counterClockwiseRotate))
        let icon = iconProvider?.getCounterClockwiseRotationIcon() ?? ToolBarButtonImageBuilder.rotateCCWImage()
        button.setImage(icon, for: .normal)
        return button
    }()

    private lazy var clockwiseRotationButton: UIButton = {
        let button = createOptionButton(withTitle: nil, andAction: #selector(clockwiseRotate))
        let icon = iconProvider?.getClockwiseRotationIcon() ?? AssetManager.image("rotate.left")
        button.setImage(icon, for: .normal)
        return button
    }()

    private lazy var alterCropper90DegreeButton: UIButton = {
        let button = createOptionButton(withTitle: nil, andAction: #selector(alterCropper90Degree))
        let icon = iconProvider?.getAlterCropper90DegreeIcon() ?? ToolBarButtonImageBuilder.alterCropper90DegreeImage()
        button.setImage(icon, for: .normal)
        return button
    }()

    private lazy var fixedRatioSettingButton: UIButton = {
        let button = createOptionButton(withTitle: nil, andAction: #selector(setRatio))
        let icon = iconProvider?.getSetRatioIcon() ?? AssetManager.image("aspectratio")
        button.setImage(icon, for: .normal)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = createOptionButton(withTitle: nil, andAction: #selector(cancel))
        let icon = iconProvider?.getCancelIcon() ?? AssetManager.image("x.circle")
        button.setImage(icon, for: .normal)
        return button
    }()

    private lazy var cropButton: UIButton = {
        let button = createOptionButton(withTitle: nil, andAction: #selector(crop))
        let icon = iconProvider?.getCropIcon() ?? AssetManager.image("checkmark.circle")
        button.setImage(icon, for: .normal)
        return button
    }()

    private var resetButton: UIButton?
    private var optionButtonStackView: UIStackView?
    
    public func createToolbarUI(config: CropToolbarConfigProtocol?) {
        self.config = config
        
        guard let config = config as? CropToolbarConfig else {
            return
        }
        
        backgroundColor = config.backgroundColor
                
        if #available(macCatalyst 14.0, iOS 14.0, *) {
            if UIDevice.current.userInterfaceIdiom == .mac {
                backgroundColor = .white
            }
        }

        createButtonContainer()
        setButtonContainerLayout()

        if config.mode == .normal {
            addButtonsToContainer(button: cancelButton)
        }

        if config.toolbarButtonOptions.contains(.counterclockwiseRotate) {
            addButtonsToContainer(button: counterClockwiseRotationButton)
        }

        if config.toolbarButtonOptions.contains(.clockwiseRotate) {
            addButtonsToContainer(button: clockwiseRotationButton)
        }

        if config.toolbarButtonOptions.contains(.alterCropper90Degree) {
            addButtonsToContainer(button: alterCropper90DegreeButton)
        }

        if config.toolbarButtonOptions.contains(.reset) {
            let icon = iconProvider?.getResetIcon() ?? AssetManager.image("arrow.triangle.2.circlepath")
            resetButton = createResetButton(with: icon)
            addButtonsToContainer(button: resetButton)
            resetButton?.isHidden = true
        }

        if config.toolbarButtonOptions.contains(.ratio) && config.ratioCandidatesShowType == .presentRatioListFromButton {
            if config.includeFixedRatiosSettingButton {
                addButtonsToContainer(button: fixedRatioSettingButton)

                if config.presetRatiosButtonSelected {
                    handleFixedRatioSetted(ratio: 0)
                    resetButton?.isHidden = false
                }
            }
        }

        if config.mode == .normal {
            addButtonsToContainer(button: cropButton)
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        guard let config = config else {
            return superSize
        }

        if Orientation.isPortrait {
            return CGSize(width: superSize.width, height: config.heightForVerticalOrientation)
        } else {
            return CGSize(width: config.widthForHorizontalOrientation, height: superSize.height)
        }
    }

    public func getRatioListPresentSourceView() -> UIView? {
        return fixedRatioSettingButton
    }

    public func adjustLayoutWhenOrientationChange() {
        if Orientation.isPortrait {
            optionButtonStackView?.axis = .horizontal
            optionButtonStackView?.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        } else {
            optionButtonStackView?.axis = .vertical
            optionButtonStackView?.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        }
    }

    public func handleFixedRatioSetted(ratio: Double) {
        fixedRatioSettingButton.tintColor = nil
    }

    public func handleFixedRatioUnSetted() {
        guard let config = config else {
            return
        }

        fixedRatioSettingButton.tintColor = config.foregroundColor
    }

    public func handleCropViewDidBecomeResettable() {
        resetButton?.isHidden = false
    }

    public func handleCropViewDidBecomeUnResettable() {
        resetButton?.isHidden = true
    }
    
    public func present(by viewController: UIViewController, in sourceView: UIView) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let discardAction = UIAlertAction(title: LocalizedHelper.getString("Mantis.Crop.Discard", value: "Discard Cahnges"),
                                          style: .default) { [weak self] _ in
            self?.cropToolbarDelegate?.didSelectDiscardChanges()
        }
        
        actionSheet.addAction(discardAction)
        
        actionSheet.handlePopupInBigScreenIfNeeded(sourceView: sourceView)

        let cancelText = LocalizedHelper.getString("Mantis.Cancel", value: "Cancel")
        let cancelAction = UIAlertAction(title: cancelText, style: .cancel)
        actionSheet.addAction(cancelAction)

        viewController.present(actionSheet, animated: true)
    }
}

// Objc functions
extension CropToolbar {
    @objc private func cancel() {
        cropToolbarDelegate?.didSelectCancel()
    }

    @objc private func setRatio() {
        cropToolbarDelegate?.didSelectSetRatio()
    }

    @objc private func reset(_ sender: Any) {
        cropToolbarDelegate?.didSelectReset()
    }

    @objc private func counterClockwiseRotate(_ sender: Any) {
        cropToolbarDelegate?.didSelectCounterClockwiseRotate()
    }

    @objc private func clockwiseRotate(_ sender: Any) {
        cropToolbarDelegate?.didSelectClockwiseRotate()
    }

    @objc private func alterCropper90Degree(_ sender: Any) {
        cropToolbarDelegate?.didSelectAlterCropper90Degree()
    }

    @objc private func crop(_ sender: Any) {
        cropToolbarDelegate?.didSelectCrop()
    }
}

// private functions
extension CropToolbar {
    private func createOptionButton(withTitle title: String?, andAction action: Selector) -> UIButton {
        guard let config = config as? CropToolbarConfig else {
            return UIButton()
        }

        let buttonColor = config.foregroundColor
        let buttonFontSize: CGFloat = (UIDevice.current.userInterfaceIdiom == .pad) ?
            config.optionButtonFontSizeForPad :
            config.optionButtonFontSize

        let buttonFont = UIFont.systemFont(ofSize: buttonFontSize)

        let button = UIButton(type: .custom)
        button.tintColor = config.foregroundColor
        button.titleLabel?.font = buttonFont

        if let title = title {
            button.setTitle(title, for: .normal)
            button.setTitleColor(buttonColor, for: .normal)
        }

        button.addTarget(self, action: action, for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)

        return button
    }

    private func createResetButton(with image: UIImage? = nil) -> UIButton {
        if let image = image {
            let button = createOptionButton(withTitle: nil, andAction: #selector(reset))
            button.setImage(image, for: .normal)
            return button
        } else {
            let resetText = LocalizedHelper.getString("Mantis.Reset", value: "Reset")
            return createOptionButton(withTitle: resetText, andAction: #selector(reset))
        }
    }

    private func createButtonContainer() {
        optionButtonStackView = UIStackView()
        addSubview(optionButtonStackView!)

        optionButtonStackView?.distribution = .equalCentering
        optionButtonStackView?.isLayoutMarginsRelativeArrangement = true
    }

    private func setButtonContainerLayout() {
        optionButtonStackView?.translatesAutoresizingMaskIntoConstraints = false
        optionButtonStackView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        optionButtonStackView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        optionButtonStackView?.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        optionButtonStackView?.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    private func addButtonsToContainer(button: UIButton?) {
        if let button = button {
            optionButtonStackView?.addArrangedSubview(button)
        }
    }

    private func addButtonsToContainer(buttons: [UIButton?]) {
        buttons.forEach {
            if let button = $0 {
                optionButtonStackView?.addArrangedSubview(button)
            }
        }
    }
}
