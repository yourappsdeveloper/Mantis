//
//  CropShapePresenter.swift
//  Mantis
//
//  Created by Yingtao Guo on 11/28/21.
//

import UIKit

public struct CropShapeTypeCandidate {
    public var shapeType: CropShapeType = .rect
    public var title: String?
    
    public init(shapeType: CropShapeType, title: String? = nil) {
        self.shapeType = shapeType
        self.title = title
    }
}

class CropShapePresenter {
    var didSelectShape: ((CropShapeType)->Void) = { _ in }
    private var type: CropShapeType = .rect
    private var candidates: [CropShapeTypeCandidate] = []
    
    init(type: CropShapeType = .rect, candidates: [CropShapeTypeCandidate]) {
        self.type = type
        self.candidates = candidates
    }
    
    func present(by viewController: UIViewController, in sourceView: UIView) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        for candidate in candidates {
            let title = candidate.title ?? candidate.shapeType.title
            let action = UIAlertAction(title: title, style: .default) {[weak self] _ in
                guard let self = self else { return }
                self.didSelectShape(candidate.shapeType)
            }
            actionSheet.addAction(action)
        }

        actionSheet.handlePopupInBigScreenIfNeeded(sourceView: sourceView)

        let cancelText = LocalizedHelper.getString("Mantis.Cancel", value: "Cancel")
        let cancelAction = UIAlertAction(title: cancelText, style: .cancel)
        actionSheet.addAction(cancelAction)

        viewController.present(actionSheet, animated: true)
    }
}
