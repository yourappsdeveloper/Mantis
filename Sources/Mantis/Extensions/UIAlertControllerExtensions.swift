//
//  UIAlertControllerExtensions.swift
//  Mantis
//
//  Created by Yingtao Guo on 11/28/21.
//

import UIKit

public extension UIAlertController {
    func handlePopupInBigScreenIfNeeded(sourceView: UIView, permittedArrowDirections: UIPopoverArrowDirection? = nil) {
        func handlePopupInBigScreen(sourceView: UIView, permittedArrowDirections: UIPopoverArrowDirection? = nil) {
            // https://stackoverflow.com/a/27823616/288724
            popoverPresentationController?.permittedArrowDirections = permittedArrowDirections ?? .any
            popoverPresentationController?.sourceView = sourceView
            popoverPresentationController?.sourceRect = sourceView.bounds
        }

        if #available(macCatalyst 14.0, iOS 14.0, *) {
            if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
                handlePopupInBigScreen(sourceView: sourceView, permittedArrowDirections: permittedArrowDirections)
            }
        } else {
            if UIDevice.current.userInterfaceIdiom == .pad {
                handlePopupInBigScreen(sourceView: sourceView, permittedArrowDirections: permittedArrowDirections)
            }
        }
    }
}

