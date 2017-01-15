//
//  PopUpViewController.swift
//  LetsPaint
//
//  Created by regan on 04/01/2017.
//  Copyright © 2017 Heng-Hao. All rights reserved.
//

import UIKit

/// MARK: - (1/4) Create a delegate protocol that defines the responsibilities of the delegate.
protocol SelectedColorDelegate {
    func colorSelected(name: String)
}

class PaletteViewController: UIViewController {

    //@IBOutlet var popUpView: PopUpView!
    
    /// MARK: - (2/4) Create a delegate property in the delegating class to keep track of the delegate.
    var delegate: SelectedColorDelegate?
    
    @IBAction func btn_Click_ChangeTheImageOfbtnPen(_ sender: UIButton) {
        
        /// MARK: - (4/4) Call the delegate (method) from the delegating object.
        delegate?.colorSelected(name: sender.currentTitle!)
    } 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 調暗Root view的背景顏色且可透明看到前一個view controller的view
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        // 進場動畫
        self.inboundAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 出場動畫+離開
        self.outboundAnimationAndRemoveView()
        //self.popUpView.removeFromSuperview()
    }
    
    /// MARK: - Animation
    func inboundAnimation() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    func outboundAnimationAndRemoveView() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 0.0
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: {
            (finished: Bool) in
            if (finished){
                self.view.removeFromSuperview()
            }
        })
    }

}
