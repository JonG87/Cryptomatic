//
//  Emitter.swift
//  Cryptomatic
//
//  Created by Jonathan Grajkowski on 2019-02-06.
//  Copyright © 2019 Jonathan Grajkowski. All rights reserved.
//

import Foundation
import UIKit

class Emitter {
    static func get(with image: UIImage) -> CAEmitterLayer{
        let emitter = CAEmitterLayer()
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterCells = generateEmitterCells(with: image)
        return emitter
    }
    
    static func generateEmitterCells(with image: UIImage) -> [CAEmitterCell] {
        var cells = [CAEmitterCell]()
        let cell = CAEmitterCell()
        
        cell.contents = image.cgImage
        cell.birthRate = 0.75
        cell.lifetime = 50
        cell.velocity = CGFloat(25)
        cell.emissionLongitude = (180 * (.pi/180))
        cell.emissionRange = (45 * (.pi/180))
        cell.scale = 0.1
        cell.scaleRange = 0.1
        
        cells.append(cell)
        
        return cells
    }
}
