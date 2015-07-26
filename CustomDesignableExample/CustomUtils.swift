//
//  CustomUtils.swift
//  CustomDesignableExample
//
//  Created by Ignacio Nieto Carvajal on 26/7/15.
//  Copyright (c) 2015 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

func degreesToRadians (value:Double) -> Double {
    return value * Double(M_PI) / 180.0
}

func radiansToDegrees (value:Double) -> Double {
    return value * 180.0 / Double(M_PI)
}
