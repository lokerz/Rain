//
//  SliderView.swift
//  Rain
//
//  Created by Ridwan Abdurrasyid on 15/05/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class SliderView: UISlider {

    let min :Float = 0
    let max :Float = 100
    let val : Float = 5
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        minimumValue = min
        maximumValue = max
        setValue(val, animated: false)
        alpha = 0.05
    }
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
    }
    
}
