//
//  ArtboardViewController.swift
//  LetsPaint
//
//  Created by regan on 04/01/2017.
//  Copyright © 2017 Heng-Hao. All rights reserved.
//

import UIKit

private var colors: Dictionary<String, String> = [
    "Red" : "Red 0xe74c3c",
    "Orange" : "Orange 0xe67e22",
    "Yellow" : "Yellow 0xf1c40f",
    "Green" : "Green 0x1abc9c",
    "Blue" : "Blue 0x3498db",
    "Purple" : "Purple 0x9b59b6",
    "Gray" : "Gray 0x7f8c8d",
    "Black" : "Black 0x34495e"
]

private var colorsInHex: Dictionary<String, Int> = [
    "Red" : 0xe74c3c,
    "Orange" : 0xe67e22,
    "Yellow" : 0xf1c40f,
    "Green" : 0x1abc9c,
    "Blue" : 0x3498db,
    "Purple" : 0x9b59b6,
    "Gray" : 0x7f8c8d,
    "Black" : 0x34495e
]

/// MARK: - (3-1/4) Adopt and implement the delegate methods in the delegate class.
class ArtboardViewController: UIViewController, SelectedColorDelegate {
    
    // 筆
    @IBOutlet weak var btnPen: UIButton!
    // 畫布
    @IBOutlet weak var artboardView: ArtboardView!
    
    @IBAction func btnPen_Click_PopOverANewVC(_ sender: UIButton) {
        
        /// MARK: - 產生新的View Controller 法一：使用Storyboard ID  法二：使用popover segue
        let popOverPVC =
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PaletteViewController
        self.addChildViewController(popOverPVC)
        //popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverPVC.view)
        //popOverVC.didMove(toParentViewController: self)
        
        /// MARK: - (3-3/4) Adopt and implement the delegate methods in the delegate class.
        /// 3-3 set the delegate (might be in a prepareForSegue or target-action method)
        /// 也就是常用在跨view controllers的溝通，通常是被創造出來的vc權限不夠只能用這種婉轉方式去通知創造者vc更新他自己
        popOverPVC.delegate = self
    }
    
    @IBAction func btnUndo_Click(_ sender: UIButton) {
        
        if artboardView.count.count > 1 {
            // clear the last line
            let lastLinePointNumber = artboardView.count[artboardView.count.endIndex - 1] - artboardView.count[artboardView.count.endIndex - 2]
            for _ in 1...lastLinePointNumber {
                artboardView.lines.remove(at: artboardView.lines.count - 1)
            }
            artboardView.count.remove(at: artboardView.count.count - 1)
        } else if artboardView.count.count == 1 {
            // use clear all to clear the first line
            artboardView.lines = []
            artboardView.count.remove(at: artboardView.count.count - 1)
        }
        
        artboardView.setNeedsDisplay()
    }
    
    @IBAction func btnErase_Click(_ sender: UIButton) {
        // change the color of the stroke
        artboardView.color = UIColor.white
        // change the line width of the stroke
        artboardView.lineWidth = 10.0
        // change mode
        //artboardView.mode = Mode.Erase
    }
    
    /// MARK: - (3-2/4) Adopt and implement the delegate methods in the delegate class.
    func colorSelected(name color : String) {
        // do stuff like updating the UI
        
        // change the color of the pencil button
        btnPen.imageView?.image = UIImage(named: colors[color]!)
        // change the color of the stroke
        artboardView.color = UIColor(hex: colorsInHex[color]!)
        // change the line width of the stroke
        artboardView.lineWidth = 3.0
        // change mode
        //artboardView.mode = Mode.Draw
    }
}

