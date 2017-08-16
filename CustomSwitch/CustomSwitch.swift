//
//  CustomSwitch.swift
//  CustomSwitch
//
//  Created by Ivan Kovacevic on 15/12/2016.
//  Copyright © 2016 Ivan Kovacevic. All rights reserved.
//

import UIKit

@IBDesignable
final class CustomSwitch: UIControl {
    
    // MARK: Public properties
    
    @IBInspectable public var isOn:Bool = true
    
    public var animationDuration: Double = 0.5
    
    @IBInspectable  public var padding: CGFloat = 1 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    @IBInspectable  public var onTintColor: UIColor = UIColor(red: 144/255, green: 202/255, blue: 119/255, alpha: 1) {
        didSet {
            self.setupUI()
            
        }
    }
    
    @IBInspectable public var offTintColor: UIColor = UIColor.black {
        didSet {
            self.setupUI()
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        
        get {
            return self.privateCornerRadius
        }
        set {
            if newValue > 0.5 || newValue < 0.0 {
                privateCornerRadius = 0.5
            } else {
                privateCornerRadius = newValue
            }
        }
        
    }
    
    private var privateCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
            
        }
    }
    
    // thumb properties
    @IBInspectable public var thumbTintColor: UIColor = UIColor.white {
        didSet {
            self.thumbView.backgroundColor = self.thumbTintColor
        }
    }
    
    @IBInspectable public var thumbCornerRadius: CGFloat {
        get {
            return self.privateThumbCornerRadius
        }
        set {
            if newValue > 0.5 || newValue < 0.0 {
                privateThumbCornerRadius = 0.5
            } else {
                privateThumbCornerRadius = newValue
            }
        }
        
    }
    
    private var privateThumbCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
            
        }
    }
    
    @IBInspectable public var thumbSize: CGSize = CGSize.zero {
        didSet {
            self.layoutSubviews()
        }
    }
    
    @IBInspectable public var thumbImage:UIImage? = nil {
        didSet {
            guard let image = thumbImage else {
                return
            }
            thumbView.thumbImageView.image = image
        }
    }
    
    public var onImage:UIImage? {
        didSet {
            self.onImageView.image = onImage
            self.layoutSubviews()
            
        }
        
    }
    
    public var offImage:UIImage? {
        didSet {
            self.offImageView.image = offImage
            self.layoutSubviews()
            
        }
        
    }
    
    
    // dodati kasnije
    @IBInspectable public var thumbShadowColor: UIColor = UIColor.black {
        didSet {
            self.thumbView.layer.shadowColor = self.thumbShadowColor.cgColor
        }
    }
    
    @IBInspectable public var thumbShadowOffset: CGSize = CGSize(width: 0.75, height: 2) {
        didSet {
            self.thumbView.layer.shadowOffset = self.thumbShadowOffset
        }
    }
    
    @IBInspectable public var thumbShaddowRadius: CGFloat = 1.5 {
        didSet {
            self.thumbView.layer.shadowRadius = self.thumbShaddowRadius
        }
    }
    
    @IBInspectable public var thumbShaddowOppacity: Float = 0.4 {
        didSet {
            self.thumbView.layer.shadowOpacity = self.thumbShaddowOppacity
        }
    }
    
    // labels
    
    public var labelOff:UILabel = UILabel()
    public var labelOn:UILabel = UILabel()
    
    public var areLabelsShown: Bool = false {
        didSet {
            self.setupUI()
        }
    }
    
    // MARK: Private properties
    fileprivate var thumbView = CustomThumbView(frame: CGRect.zero)
    fileprivate var onImageView = UIImageView(frame: CGRect.zero)
    fileprivate var offImageView = UIImageView(frame: CGRect.zero)
    
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
        self.thumbView.layer.shadowColor = self.thumbShadowColor.cgColor
        self.thumbView.layer.shadowRadius = self.thumbShaddowRadius
        self.thumbView.layer.shadowOpacity = self.thumbShaddowOppacity
        self.thumbView.layer.shadowOffset = self.thumbShadowOffset
        
        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        
        self.addSubview(self.thumbView)
        self.addSubview(self.onImageView)
        self.addSubview(self.offImageView)
        
        self.setupLabels()
        
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
    
    func setOn(on:Bool, animated:Bool) {
        
        switch animated {
        case true:
            self.animate(on: on)
        case false:
            self.isOn = on
            self.setupViewsOnAction()
            self.completeAction()
        }
        
    }
    
    fileprivate func animate(on:Bool? = nil) {
        
        self.isOn = on ?? !self.isOn
        
        self.isAnimating = true
        
        UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [UIViewAnimationOptions.curveEaseOut, UIViewAnimationOptions.beginFromCurrentState, UIViewAnimationOptions.allowUserInteraction], animations: {
            self.setupViewsOnAction()
            
        }, completion: { _ in
            self.completeAction()
            
        })
    }
    
    private func setupViewsOnAction() {
        self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        self.setOnOffImageFrame()
        
    }
    
    private func completeAction() {
        self.isAnimating = false
        self.sendActions(for: UIControlEvents.valueChanged)
        
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
            
            
            //label frame
            if self.areLabelsShown {
                
                let labelWidth = self.bounds.width / 2 - self.padding * 2
                self.labelOn.frame = CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height)
                self.labelOff.frame = CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
                
            }
            
            // on/off images
            //set to preserve aspect ratio of image in thumbView
            
            guard onImage != nil && offImage != nil else {
                return
            }
            
            let frameSize = thumbSize.width > thumbSize.height ? thumbSize.height * 0.7 : thumbSize.width * 0.7
            
            let onOffImageSize = CGSize(width: frameSize, height: frameSize)
            
            
            self.onImageView.frame.size = onOffImageSize
            self.offImageView.frame.size = onOffImageSize
            
            self.onImageView.center = CGPoint(x: self.onPoint.x + self.thumbView.frame.size.width / 2, y: self.thumbView.center.y)
            self.offImageView.center = CGPoint(x: self.offPoint.x + self.thumbView.frame.size.width / 2, y: self.thumbView.center.y)
            
            
            self.onImageView.alpha = self.isOn ? 1.0 : 0.0
            self.offImageView.alpha = self.isOn ? 0.0 : 1.0
            
        }
    }
}

//Mark: Labels frame
extension CustomSwitch {
    
    fileprivate func setupLabels() {
        guard self.areLabelsShown else {
            self.labelOff.alpha = 0
            self.labelOn.alpha = 0
            return
            
        }
        
        self.labelOff.alpha = 1
        self.labelOn.alpha = 1
        
        let labelWidth = self.bounds.width / 2 - self.padding * 2
        self.labelOn.frame = CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height)
        self.labelOff.frame = CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
        self.labelOn.font = UIFont.boldSystemFont(ofSize: 12)
        self.labelOff.font = UIFont.boldSystemFont(ofSize: 12)
        self.labelOn.textColor = UIColor.white
        self.labelOff.textColor = UIColor.white
        
        self.labelOff.sizeToFit()
        self.labelOff.text = "Off"
        self.labelOn.text = "On"
        self.labelOff.textAlignment = .center
        self.labelOn.textAlignment = .center
        
        self.insertSubview(self.labelOff, belowSubview: self.thumbView)
        self.insertSubview(self.labelOn, belowSubview: self.thumbView)
        
    }
    
}

//Mark: Animating on/off images
extension CustomSwitch {
    
    fileprivate func setOnOffImageFrame() {
        guard onImage != nil && offImage != nil else {
            return
        }
        
        self.onImageView.center.x = self.isOn ? self.onPoint.x + self.thumbView.frame.size.width / 2 : self.frame.width
        self.offImageView.center.x = !self.isOn ? self.offPoint.x + self.thumbView.frame.size.width / 2 : 0
        self.onImageView.alpha = self.isOn ? 1.0 : 0.0
        self.offImageView.alpha = self.isOn ? 0.0 : 1.0
        
    }
}
