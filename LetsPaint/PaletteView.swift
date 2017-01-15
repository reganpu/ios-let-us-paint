//
//  PaletteView.swift
//  LetsPaint
//
//  Created by regan on 04/01/2017.
//  Copyright © 2017 Heng-Hao. All rights reserved.
//

import UIKit

@IBDesignable
class PaletteView: UIView {
        
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Draw a rectangle
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.close()
        path.lineWidth = 3.0
        UIColor.lightGray.set()
        path.stroke()
    }
}
