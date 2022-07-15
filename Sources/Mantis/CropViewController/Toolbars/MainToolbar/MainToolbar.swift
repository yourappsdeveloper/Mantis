//
//  MainToolbar.swift
//  Mantis
//
//  Created by Aleksandr on 15.07.2022.
//

import UIKit

public class MainToolbar: UIView, MainToolbarProtocol {
    
    private(set) public var config: MainToolbarConfigProtocol?
    
    public var iconProvider: MainToolbarIconProvider?
    public weak var mainToolbarDelegate: MainToolbarDelegate?
        
    private lazy var backButton: UIButton = {
        let button = createOptionButton(withTitle: nil, andAction: #selector(back))
        let icon = iconProvider?.getBackIcon() ?? AssetManager.image("chevron.backward.circle")
        button.setImage(icon, for: .normal)
        return button
    }()

    private lazy var cropButton: UIButton = {
        let button = createOptionButton(withTitle: nil, andAction: #selector(crop))
        let icon = iconProvider?.getCropIcon() ?? AssetManager.image("crop")
        button.setImage(icon, for: .normal)
        return button
    }()

    private lazy var paintButton: UIButton = {
        let button = createOptionButton(withTitle: nil, andAction: #selector(paint))
        let icon = iconProvider?.getPaintIcon() ?? AssetManager.image("pencil.tip.crop.circle")
        button.setImage(icon, for: .normal)

        return button
    }()

    private lazy var colorControlButton: UIButton = {
        let button = createOptionButton(withTitle: nil, andAction: #selector(colorControl))
        let icon = iconProvider?.getColorControlIcon() ?? AssetManager.image("slider.horizontal.3")
        button.setImage(icon, for: .normal)
        return button
    }()
    
    private lazy var sendButton: UIButton = {
        let button = createOptionButton(withTitle: nil, andAction: #selector(send))
        let icon = iconProvider?.getSendIcon() ?? AssetManager.image("arrow.up.circle.fill")
        button.setImage(icon, for: .normal)
        return button
    }()
    
    private var optionButtonStackView: UIStackView?
    
    public func createToolbarUI(config: MainToolbarConfigProtocol?) {
        self.config = config
        guard let config = config as? MainToolbarConfig else { return }
        backgroundColor = config.backgroundColor
                
        if #available(macCatalyst 14.0, iOS 14.0, *) {
            if UIDevice.current.userInterfaceIdiom == .mac {
                backgroundColor = .white
            }
        }

        createButtonContainer()
        setButtonContainerLayout()
        addButtonsToContainer(buttons: [backButton, cropButton, paintButton, colorControlButton, sendButton])
    }
    
    public override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        guard let config = config else { return superSize }

        if Orientation.isPortrait {
            return CGSize(width: superSize.width, height: config.heightForVerticalOrientation)
        } else {
            return CGSize(width: config.widthForHorizontalOrientation, height: superSize.height)
        }
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
}

// Objc functions
extension MainToolbar {

    @objc private func back(_ sender: Any) {
        mainToolbarDelegate?.didSelectBack()
    }
    
    @objc private func crop() {
        mainToolbarDelegate?.didSelectCropMode()
    }

    @objc private func paint(_ sender: Any) {
        mainToolbarDelegate?.didSelectPaintMode()
    }

    @objc private func colorControl(_ sender: Any) {
        mainToolbarDelegate?.didSelectColorControlMode()
    }

    @objc private func send(_ sender: Any) {
        mainToolbarDelegate?.didSelectSend()
    }
}

// private functions
extension MainToolbar {
    private func createOptionButton(withTitle title: String?, andAction action: Selector) -> UIButton {
        guard let config = config as? MainToolbarConfig else {
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
