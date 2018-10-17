//
//  Settings.swift
//  Matrix
//
//  Created by Christophe Bronner on 2018-08-21.
//  Copyright © 2018 Christophe Bronner. All rights reserved.
//

import Cocoa

class Settings {
    private init() { }
    
    //MARK: - GRID SETTINGS
    
    static var COLUMN_COUNT: CGFloat = 50
    static var ROW_COUNT: CGFloat = 18
    
    //MARK: - MATRIX SETTINGS
    
    static let UPDATE_INTERVAL: TimeInterval = 0.15
    static let LIGHTEN_UP_CHAR_COLOR: NSColor = NSColor(red: 0, green: 1, blue: 0, alpha: 1)
    static let CHAR_COLOR: NSColor = NSColor(red: 0.1, green: 0.6, blue: 0.1, alpha: 1)
    
    //MARK: - JUMPER SETTINGS
    
    static var JUMPER_COUNT_RANGE: ClosedRange<Int> = 55...75
    static let JUMPER_LIFETIME_RANGE: ClosedRange<Int> = 10...40
    static let JUMPER_LIGHTEN_UP_CHANCE: Double = 0.2
    
    //MARK: - RAIN SETTINGS
    
    static var RAIN_LENGHT_RANGE: ClosedRange<Int> = 12...28
    static var RAIN_FREE_COLUMNS: ClosedRange<Int> = 2...6
    static var RAIN_HEIGHT_RANGE: ClosedRange<Int> = 0...12
    
    //MARK: - Methods
    
    static func prepare(_ frame: NSRect) {
        COLUMN_COUNT = (frame.width / 25).toInt.toCGFloat
        ROW_COUNT = (frame.height / 25).toInt.toCGFloat
        
        let area = COLUMN_COUNT * ROW_COUNT
        JUMPER_COUNT_RANGE = Int(area / 16)...Int(area / 14)
        
        RAIN_LENGHT_RANGE = Int(COLUMN_COUNT / 4)...Int(COLUMN_COUNT / 2)
        RAIN_FREE_COLUMNS = Int(COLUMN_COUNT / 6)...Int(COLUMN_COUNT / 3)
        RAIN_HEIGHT_RANGE = 0...RAIN_LENGHT_RANGE.lowerBound
    }
    
}
