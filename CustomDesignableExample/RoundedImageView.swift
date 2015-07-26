//
//  RoundedImageView.swift
//  CustomDesignableExample
//
//  Created by Ignacio Nieto Carvajal on 26/7/15.
//  Copyright (c) 2015 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

private let kRoundedImageStartingAngle = -90.0

@IBDesignable public class RoundedImageView: UIView {

    // inspectable properties
    @IBInspectable public var image: UIImage? = nil
    @IBInspectable public var strokeColor: UIColor = UIColor.blackColor()
    @IBInspectable public var strokeWidth: CGFloat = 20.0
    @IBInspectable public var completed: Double = 0.20 {
        willSet { self.willChangeValueForKey("completed") }
        didSet {
            if completed < 0.0 { completed = 0.0 }
            if completed > 1.0 { completed = 1.0 }
            self.didChangeValueForKey("completed")
            setNeedsDisplay()
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        // draw the image (if any)
        if image != nil {
            // custom drawing: 1. Calculate the rounded path.
            let cornerRadius = min(image!.size.width, image!.size.height) / 2.0
            let clippingPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            clippingPath.addClip()
            
            // custom drawing: 2. Draw the image.
            image!.drawInRect(rect)
        }
    
        // custom drawing: 3. Add the stroke.
        if strokeWidth > 0.0 {
            let radius = max(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2.0
            let strokePath = UIBezierPath(arcCenter: CGPoint(x: CGRectGetMidX(self.bounds), y: CGRectGetMidY(self.bounds)), radius: radius, startAngle: CGFloat(degreesToRadians(kRoundedImageStartingAngle)), endAngle: CGFloat(degreesToRadians(-90.0 + 360.0 * completed)), clockwise: true)
            strokePath.lineWidth = strokeWidth
            strokeColor.setStroke()
            strokePath.stroke()
        }
    
    }

}
