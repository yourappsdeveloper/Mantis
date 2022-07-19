//
//  CGRectExtension.swift
//  Mantis
//
//  Created by Aleksandr on 18.07.2022.
//

import UIKit

extension CGRect {
    
    init(p1: CGPoint, p2: CGPoint) {
        self.init(x: min(p1.x, p2.x),
                  y: min(p1.y, p2.y),
                  width: abs(p1.x - p2.x),
                  height: abs(p1.y - p2.y))
    }
}
