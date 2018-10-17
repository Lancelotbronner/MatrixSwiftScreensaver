//
//  ScreenSaver.swift
//  Matrix
//
//  Created by Christophe Bronner on 2018-08-21.
//  Copyright © 2018 Christophe Bronner. All rights reserved.
//

import ScreenSaver
import Cocoa

@objc(Matrix)
class Matrix: ScreenSaverView {

    //MARK: - Properties
    
    var isInitialized: Bool = false
    
    var simulation: Simulation!
    var rect: NSRect!
    
    //MARK: - Initialization
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        Settings.prepare(frame)
        animationTimeInterval = Settings.UPDATE_INTERVAL
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    func initialize() {
        
        // Initialize resources
        Resources.prepare(self)
        
        // Set simulation
        simulation = Simulation(size: frame, view: self)
        
        // Toggle the flag
        isInitialized = true
    }
    
    //MARK: - Overrides

    override var hasConfigureSheet: Bool { return false }
    
    override func draw(_ rect: NSRect) {
        super.draw(rect)
        
        if !isInitialized {
            // Draw background
            NSColor.black.setFill()
            rect.fill()
            
            // Initialize
            initialize()
        }
    }
    
    //MARK: - Methods

    override func animateOneFrame() {
        super.animateOneFrame()
        
        Debug {
            Debug.lifetime += 1
            Debug.aut_timestamp = Date()
        }
        
        // Update simulation
        simulation.update()
        
        // Update display
        setNeedsDisplay(bounds)
        
        Debug {
            Debug.averageUpdateTimes.append(Debug.aut_timestamp.timeIntervalSinceNow)
            Debug.averageJumpers.append(simulation.jumpers.count)
            Debug.averageRains.append(simulation.rains.count)
            
            Debug.aups_counter += 1
            if Debug.aups_timestamp.timeIntervalSinceNow <= -1 {
                Debug.averageUpdatePerSeconds.append(Debug.aups_counter)
                Debug.aups_counter = 0
                Debug.aups_timestamp = Date()
            }
        }
        
    }
    
}
