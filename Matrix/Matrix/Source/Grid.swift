//
//  Grid.swift
//  Matrix
//
//  Created by Christophe Bronner on 2018-08-21.
//  Copyright © 2018 Christophe Bronner. All rights reserved.
//

import Cocoa

extension Simulation {
    class Grid {
        
        //MARK: - Properties
        
        var screenSaver: Matrix
        var tiles: [[Tile]]
        
        //MARK: - Initialization
        
        init(rows: Int, columns: Int, view: Matrix) {
            screenSaver = view
            tiles = []
            
            for x in 0...columns - 1 {
                tiles.append([])
                
                for y in 0...rows - 1 {
                    let tileWidth = view.frame.width / Settings.COLUMN_COUNT
                    let tileHeight = view.frame.height / Settings.ROW_COUNT
                    let posX = x.toCGFloat * tileWidth
                    let posY = y.toCGFloat * tileHeight
                    let frame = NSRect(x: posX, y: posY, width: tileWidth, height: tileHeight)
                    let tile = Tile(charX: x, charY: y, frame: frame, view: view)
                    
                    tiles[x].append(tile)
                }
            }
        }
        
        //MARK: - Methods
        
        func update() {
            for column in tiles {
                for tile in column {
                    tile.update()
                }
            }
        }
        
        func freeTile() -> Tile? {
            for _ in 0...8 {
                let randX = arc4random_uniform(tiles.count.toUInt32).toInt
                let randY = arc4random_uniform(tiles[randX].count.toUInt32).toInt
                
                let tile = tiles[randX][randY]
                guard tile.isFree else { continue }
                
                return tile
            }
            
            guard let column = freeColumn()?.column else { return nil }
            let tile = column.filter { $0.isFree }.first
            
            return tile
        }
        
        func freeColumn() -> (x: Int, column: [Tile])? {
            for _ in 0...8 {
                let randX = arc4random_uniform(tiles.count.toUInt32).toInt
                
                let column = tiles[randX]
                let tile = column[0]
                guard tile.isFree else { continue }
                
                return (randX, column)
            }
            
            for x in 0...tiles.count - 1 {
                let column = tiles[x]
                
                if column[0].isFree {
                    return (x, column)
                }
            }
            
            return nil
        }
        
    }
}
