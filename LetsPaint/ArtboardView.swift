//
//  ArtboardView.swift
//  LetsPaint
//
//  Created by regan on 05/01/2017.
//  Copyright © 2017 Heng-Hao. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

struct Line {
    var start: CGPoint
    var end: CGPoint
    var color: UIColor
    var lineWidth: CGFloat
}

//enum Mode {
//    case Draw
//    case Erase
//}

//struct Stroke {
//    var lines: [Line]
//}

class ArtboardView: UIView {

    var lines: [Line] = []
    var lastPoint: CGPoint!
    var count: [Int] = []
    var color: UIColor = UIColor(hex: 0x1abc9c)
    var lineWidth: CGFloat = 3.0
    //var mode: Mode = Mode.Draw
    
    /// MARK: - 在ArtboardView實作手指觸碰螢幕的Handler
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lastPoint = touches.first?.location(in: self)
    }
    
    /// MARK: - 在ArtboardView實作手指在螢幕上移動的Handler
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 產生小線段們
        let newPoint = touches.first?.location(in: self)
        lines.append(Line(start: lastPoint, end: newPoint!, color: color, lineWidth: lineWidth))
        lastPoint = newPoint
        
        // 提出redraw需求
        self.setNeedsDisplay()
    }
    
    /// MARK: - 在ArtboardView實作手指離開螢幕的Handler
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 記錄大線段數目
        count.append(lines.count)
    }
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()!
        context.setLineCap(CGLineCap.round)
        //依小線段們畫圖
        for line in lines {
            context.beginPath()
            context.move(to: CGPoint(x: line.start.x, y: line.start.y))
            context.addLine(to: CGPoint(x: line.end.x, y: line.end.y))
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(line.lineWidth)
            context.strokePath()
        }
        
        // cannot draw path in different color
//        let path = UIBezierPath()
//        
//        for line in lines {
//            line.color.set()
//            path.move(to: CGPoint(x: line.start.x, y: line.start.y))
//            path.addLine(to: CGPoint(x: line.end.x, y: line.end.y))
//        }
//        path.lineWidth = 3.0
//        path.lineCapStyle = CGLineCap.round
//        path.stroke()
    }

}
