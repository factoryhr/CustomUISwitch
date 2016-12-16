//
//  CustomSwitch.swift
//  CustomSwitch
//
//  Created by Ivan Kovacevic on 15/12/2016.
//  Copyright © 2016 Ivan Kovacevic. All rights reserved.
//

import UIKit

final class CustomSwitch: UIControl {

    // MARK: Public properties
    
    public var isOn = true
    public var animationDuration: Double = 0.5
    
    public var padding: CGFloat = 1 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    public var onTintColor = UIColor(red: 144/255, green: 202/255, blue: 119/255, alpha: 1) {
        didSet {
            self.setupUI()
        }
    }
    
    public var offTintColor = UIColor.lightGray {
        didSet {
            self.setupUI()
        }
    }
    
    public var cornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    // thumb properties
    public var thumbTintColor = UIColor.white {
        didSet {
            self.thumbView.backgroundColor = self.thumbTintColor
        }
    }
    
    public var thumbCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    public var thumbSize = CGSize.zero {
        didSet {
            self.layoutSubviews()
        }
    }
    
    // dodati kasnije
    public var thumbShadowColor = UIColor.black.cgColor {
        didSet {
            self.thumbView.layer.shadowColor = self.thumbShadowColor
        }
    }
    
    public var thumbShadowOffset = CGSize(width: 0.75, height: 2) {
        didSet {
            self.thumbView.layer.shadowOffset = self.thumbShadowOffset
        }
    }
    
    public var thumbShaddowRadius: CGFloat = 1.5 {
        didSet {
            self.thumbView.layer.shadowRadius = self.thumbShaddowRadius
        }
    }
    
    public var thumbShaddowOppacity: Float = 0.4 {
        didSet {
            self.thumbView.layer.shadowOpacity = self.thumbShaddowOppacity
        }
    }
    
    // MARK: Private properties
    fileprivate var thumbView = UIView(frame: CGRect.zero)
    
    fileprivate var onPoint = CGPoint.zero
    fileprivate var offPoint = CGPoint.zero
    fileprivate var isAnimating = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
}

// MARK: Private methods
extension CustomSwitch {
    
    fileprivate func setupUI() {
        
        // clear self before configuration
        self.clear()
        
        self.clipsToBounds = false
        
        // configure thumb view
        self.thumbView.backgroundColor = self.thumbTintColor
        self.thumbView.isUserInteractionEnabled = false
        
        // dodati kasnije
        self.thumbView.layer.shadowColor = self.thumbShadowColor
        self.thumbView.layer.shadowRadius = self.thumbShaddowRadius
        self.thumbView.layer.shadowOpacity = self.thumbShaddowOppacity
        self.thumbView.layer.shadowOffset = self.thumbShadowOffset
        
        self.addSubview(self.thumbView)
    }
    
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        self.animate()
        return true
    }
    
    private func animate() {
     
        self.isOn = !self.isOn
        self.isAnimating = true
        
        UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [UIViewAnimationOptions.curveEaseOut, UIViewAnimationOptions.beginFromCurrentState], animations: {
          
            self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
            self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
            
        }, completion: { _ in
            
            self.isAnimating = false
            self.sendActions(for: UIControlEvents.valueChanged)
        })
    }
}

// Mark: Public methods
extension CustomSwitch {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isAnimating {
            self.layer.cornerRadius = self.bounds.size.height * self.cornerRadius
            self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor

            // thumb managment
            // get thumb size, if none set, use one from bounds
            let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width: self.bounds.size.height - 2, height: self.bounds.height - 2)
            let yPostition = (self.bounds.size.height - thumbSize.height) / 2
            
            self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - self.padding, y: yPostition)
            self.offPoint = CGPoint(x: self.padding, y: yPostition)
            
            self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
            self.thumbView.layer.cornerRadius = thumbSize.height * self.thumbCornerRadius
        }
    }
}
