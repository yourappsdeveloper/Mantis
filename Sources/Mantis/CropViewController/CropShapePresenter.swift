//
//  CropShapePresenter.swift
//  Mantis
//
//  Created by Yingtao Guo on 11/28/21.
//

import UIKit

class CropShapePresenter {
    var didSelectShape: ((CropShapeType)->Void) = { _ in }
    private var type: CropShapeType = .rect
    private var candidates: [CropShapeType] = []
    
    init(type: CropShapeType = .rect, candidates: [CropShapeType]) {
        self.type = type
        self.candidates = candidates
    }
    
    func present(by viewController: UIViewController, in sourceView: UIView) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        for shape in candidates {

            let action = UIAlertAction(title: shape.title, style: .default) {[weak self] _ in
                guard let self = self else { return }
                self.didSelectShape(shape)
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
