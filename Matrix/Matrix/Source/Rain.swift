//
//  Rain.swift
//  Matrix
//
//  Created by Christophe Bronner on 2018-08-26.
//  Copyright © 2018 Christophe Bronner. All rights reserved.
//

extension Simulation {
    class Rain {
        
        //MARK: - Properties
        
        var column: [Tile]
        var lenght: Int
        var position: Int
        var x: Int
        
        //MARK: - Computed Properties
        
        var isAlive: Bool {
            return position >= 0
        }
        
        var bottom: Int {
            return position - lenght
        }
        
        //MARK: - Initialization
        
        init(on: [Tile], at: Int) {
            column = on
            x = at
            
            lenght = Settings.RAIN_LENGHT_RANGE.randomElement() ?? 1
            
            let addedHeight = Settings.RAIN_HEIGHT_RANGE.randomElement() ?? 1
            position = Settings.ROW_COUNT.toInt + addedHeight + lenght - 1
        }
        
        //MARK: - Methods
        
        func update() {
            
            // Activating tiles
            
            var bottom = position - lenght
            var first = true
            
            while bottom != position {
                if let t = column.at(bottom) {
                    t.activate()
                    t.isLitUp = first
                }
                
                if first { first = false }
                bottom += 1
            }
            
            // Killing tiles
            
            var top = position
            while let t = column.at(top) {
                t.die()
                top += 1
            }
            
            position -= 1
        }
        
    }
}
