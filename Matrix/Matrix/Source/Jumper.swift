//
//  Jumper.swift
//  Matrix
//
//  Created by Christophe Bronner on 2018-08-22.
//  Copyright © 2018 Christophe Bronner. All rights reserved.
//

extension Simulation {
    class Jumper {
        
        //MARK: - Properties
        
        var tile: Tile!
        var lifetime: Int
        var isLitUp: Bool
        
        //MARK: - Computed Properties
        
        var isAlive: Bool {
            return lifetime > 0
        }
        
        //MARK: - Initialization
        
        init(on: Tile) {
            tile = on
            
            lifetime = Settings.JUMPER_LIFETIME_RANGE.randomElement() ?? 1
            isLitUp = Double.random(in: 0...1) < Settings.JUMPER_LIGHTEN_UP_CHANCE
        }
        
        deinit {
            die()
        }
        
        //MARK: - Methods
        
        func update() {
            lifetime -= 1
            tile.activate()
            if isLitUp { tile.lightUp() }
        }
        
        func die() {
            tile.die()
        }
        
    }
}
