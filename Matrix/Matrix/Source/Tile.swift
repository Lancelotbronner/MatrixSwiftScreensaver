//
//  Tile.swift
//  Matrix
//
//  Created by Christophe Bronner on 2018-08-21.
//  Copyright © 2018 Christophe Bronner. All rights reserved.
//

import Cocoa

extension Simulation {
    class Tile {
        
        //MARK: - Properties
        
        private var screenSaver: Matrix
        
        private(set) var x: Int
        private(set) var y: Int
        private var character: Bool
        var isLitUp: Bool
        private var imageView: NSImageView
        
        //MARK: - Custom Properties
        
        var isFree: Bool {
            return !character
        }
        
        //MARK: - Initialization
        
        init(charX: Int, charY: Int, frame rect: NSRect, view: Matrix) {
            screenSaver = view
            
            x = charX
            y = charY
            character = false
            isLitUp = false
            
            imageView = NSImageView(frame: rect)
            imageView.translateOrigin(to: NSPoint(x: 0.5, y: 0.5))
            
            imageView.wantsLayer = true
            
            view.addSubview(imageView)
        }
        
        //MARK: - Methods
        
        func update() {
            imageView.image = character ? Resources.symbol(isLitUp) : nil
        }
        
        func lightUp() {
            isLitUp = true
        }
        
        func activate() {
            character = true
        }
        
        func die() {
            isLitUp = false
            character = false
        }
        
    }
}
