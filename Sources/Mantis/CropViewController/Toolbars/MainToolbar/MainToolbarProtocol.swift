//
//  MainToolbarProtocol.swift
//  Mantis
//
//  Created by Aleksandr on 15.07.2022.
//

import UIKit

public protocol MainToolbarDelegate: AnyObject {
    func didSelectBack()
    func didSelectCropMode()
    func didSelectPaintMode()
    func didSelectColorControlMode()
    func didSelectSend()
}

public protocol MainToolbarIconProvider: AnyObject {
    func getBacklIcon() -> UIImage?
    func getCropIcon() -> UIImage?
    func getPaintIcon() -> UIImage?
    func getColorControlIcon() -> UIImage?
    func getSendIcon() -> UIImage?
}

public extension MainToolbarIconProvider {
    func getBackIcon() -> UIImage? { return nil }
    func getCropIcon() -> UIImage? { return nil }
    func getPaintIcon() -> UIImage? { return nil }
    func getColorControlIcon() -> UIImage? { return nil }
    func getSendIcon() -> UIImage? { return nil }
}

public protocol MainToolbarProtocol: UIView {
    
    var config: MainToolbarConfigProtocol? { get }
    var mainToolbarDelegate: MainToolbarDelegate? { get set }
    var iconProvider: MainToolbarIconProvider? { get set }
    
    func createToolbarUI(config: MainToolbarConfigProtocol?)
    
    // MARK: - The following functions have default implementations
    func getRatioListPresentSourceView() -> UIView?
    
    func respondToOrientationChange()
    func adjustLayoutWhenOrientationChange()
    
    func handleCropViewDidBecomeResettable()
    func handleCropViewDidBecomeUnResettable()
}

public extension MainToolbarProtocol {
    func getRatioListPresentSourceView() -> UIView? {
        return nil
    }
    
    private func adjustIntrinsicContentSize() {
        invalidateIntrinsicContentSize()
        
        let highPriority: Float = 10000
        let lowPriority: Float = 1

        if Orientation.isPortrait {
            setContentHuggingPriority(UILayoutPriority(highPriority), for: .vertical)
            setContentCompressionResistancePriority(UILayoutPriority(highPriority), for: .vertical)
            setContentHuggingPriority(UILayoutPriority(lowPriority), for: .horizontal)
            setContentCompressionResistancePriority(UILayoutPriority(lowPriority), for: .horizontal)
        } else {
            setContentHuggingPriority(UILayoutPriority(highPriority), for: .horizontal)
            setContentCompressionResistancePriority(UILayoutPriority(highPriority), for: .horizontal)
            setContentHuggingPriority(UILayoutPriority(lowPriority), for: .vertical)
            setContentCompressionResistancePriority(UILayoutPriority(lowPriority), for: .vertical)
        }
    }
    
    func respondToOrientationChange() {
        adjustIntrinsicContentSize()
        adjustLayoutWhenOrientationChange()
    }
    
    func adjustLayoutWhenOrientationChange() {}
    
    func handleCropViewDidBecomeResettable() {}
    
    func handleCropViewDidBecomeUnResettable() {}
}
