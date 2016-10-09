//
//  RoundedImageView.swift
//  CustomDesignableExample
//
//  Created by Ignacio Nieto Carvajal on 26/7/15.
//  Copyright (c) 2015 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

private let kRoundedImageStartingAngle = -90.0

@IBDesignable open class RoundedImageView: UIView {

    // inspectable properties
    @IBInspectable open var image: UIImage? = nil
    @IBInspectable open var strokeColor: UIColor = UIColor.black
    @IBInspectable open var strokeWidth: CGFloat = 20.0
    @IBInspectable open var completed: Double = 0.20 {
        willSet { self.willChangeValue(forKey: "completed") }
        didSet {
            if completed < 0.0 { completed = 0.0 }
            if completed > 1.0 { completed = 1.0 }
            self.didChangeValue(forKey: "completed")
            setNeedsDisplay()
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // draw the image (if any)
        if image != nil {
            // custom drawing: 1. Calculate the rounded path.
            let cornerRadius = min(image!.size.width, image!.size.height) / 2.0
            let clippingPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            clippingPath.addClip()
            
            // custom drawing: 2. Draw the image.
            image!.draw(in: rect)
        }
    
        // custom drawing: 3. Add the stroke.
        if strokeWidth > 0.0 {
            let radius = max(self.bounds.width, self.bounds.height) / 2.0
            let strokePath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.midX, y: self.bounds.midY), radius: radius, startAngle: CGFloat(degreesToRadians(kRoundedImageStartingAngle)), endAngle: CGFloat(degreesToRadians(-90.0 + 360.0 * completed)), clockwise: true)
            strokePath.lineWidth = strokeWidth
            strokeColor.setStroke()
            strokePath.stroke()
        }
    
    }

}
