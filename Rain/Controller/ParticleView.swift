//
//  ParticleView.swift
//  Rain
//
//  Created by Ridwan Abdurrasyid on 15/05/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class ParticleView: UIView {

    var particleImage : UIImage?
    var particleImage2 : UIImage?
    var color : UIColor?
    var rainIntensity : Float = 150
    var rainScale : CGFloat = 0.4
    
    override class var layerClass : AnyClass{
        return CAEmitterLayer.self
    }

    func makeRainCell(_ color : UIColor, _ alpha : CGFloat, _ intensity :  Float,_ velocity : CGFloat, _ scale : CGFloat) -> CAEmitterCell{
        let rain = CAEmitterCell()
        rain.name = "rainDrop"
        
        rain.birthRate = intensity * 1.5
        rain.lifetime = 0.9
        rain.lifetimeRange = 0.1
        
        rain.color = color.withAlphaComponent(0.6).cgColor
        rain.alphaRange = 0.4
        //rain.alphaSpeed = -0.6
        
        rain.velocity = velocity
        rain.velocityRange = velocity * 5 / 10
        rain.yAcceleration = velocity
        
        rain.emissionLongitude = .pi
        
        rain.scale = scale
        rain.scaleRange = scale * 7 / 10
        
        rain.contents = particleImage?.cgImage
        return rain
    }
    
    func makeRippleCell(rainDrop : CAEmitterCell) -> CAEmitterCell{
        let ripple = CAEmitterCell()
        
        ripple.birthRate = 1
        ripple.lifetime = 0.2

        switch UIDevice.current.orientation{
        case .portrait : ripple.beginTime = rainDrop.beginTime - 0.1
        default : ripple.beginTime = rainDrop.beginTime - 0.5
        }
        
        ripple.scale = rainDrop.scale * 1.5
        ripple.scaleSpeed = 0.1
        
        ripple.alphaSpeed = -0.5
        
        ripple.contents = particleImage2?.cgImage
        return ripple
    }
    
    override func layoutSubviews() {
        let emitter = self.layer as! CAEmitterLayer
        
        emitter.emitterShape = .line
        emitter.emitterPosition = CGPoint(x : bounds.midX, y:0)
        emitter.emitterSize = CGSize(width: bounds.size.width, height: 1)
        emitter.renderMode = .backToFront
        
        let rainDroplet = makeRainCell(color!, 1, rainIntensity, 600, rainScale)
        //let rainRipple = makeRippleCell(rainDrop: rainDroplet)
    
        //rainDroplet.emitterCells = [rainRipple]
        emitter.emitterCells = [rainDroplet]

    }
    
    
}
