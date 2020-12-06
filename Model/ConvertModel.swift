//
//  ConvertModel.swift
//  AngleConverter
//
//  Created by Logan Watkins on 11/27/20.
//  Copyright © 2020 Logan Watkins. All rights reserved.
//

import Foundation
import UIKit

struct ConvertModel {
    
    var currentInLamdaName: String = ""
    var currentInLamdaNum: Double = 0
       
    var currentOutLamdaNum: Double = 0
    var currentOutLamdaName: String = ""
    
    var currentInAngle: Double = 0
    var currentOutAngle: Double = 0
    
    var currentInLamda: Double = 0
    var currentOutLamda: Double = 0
    
    var currentPlate: String = ""
    
    var inLamdaData: [String] = [String]()
    var outLamdaData: [String] = [String]()
    
    var inLamdaValues: [Double] = [Double]()
    var outLamdaValues: [Double] = [Double]()
    
    //Returns the actual result of calculating the output angle. Based on Bragg's law
    mutating func calculateOutputAngle() -> Double {
        let lamdaA = currentInLamda
        let lamdaB = currentOutLamda
        
        let d = lamdaA/(2 * sin(self.currentInAngle * Double.pi / 180))
        let e = lamdaB/(2 * d)
        let outputAngle = asin(e) * 180 / Double.pi
        
        let outputResult = Double(round(100000*outputAngle)/100000)
        
        return outputResult
        
    }
}
