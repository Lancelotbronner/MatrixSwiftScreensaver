//
//  Simulation.swift
//  Simulation
//
//  Created by Christophe Bronner on 2018-08-21.
//  Copyright © 2018 Christophe Bronner. All rights reserved.
//

import Cocoa

class Simulation {

    //MARK: - Properties

    weak var screenSaver: Matrix?
    var grid: Grid

    var jumpers: [Jumper]
    var rains: [Rain]

    //MARK: - Initialization

    init(size: NSRect, view: Matrix) {
        screenSaver = view

        // Create the grid
        grid = Grid(rows: Settings.ROW_COUNT.toInt, columns: Settings.COLUMN_COUNT.toInt, view: view)

        // Set empty animations
        jumpers = []
        rains = []
    }

    //MARK: - Methods

    func update() {

        // Update the animations

        jumpers.forEach { $0.update() }
        rains.forEach { $0.update() }

        // Remove dead animations

        jumpers = jumpers.filter { $0.isAlive }
        
        rains = rains.filter { $0.isAlive }

        // Add animations

        let randJ = Settings.JUMPER_COUNT_RANGE.randomElement() ?? 1
        jumpers: if jumpers.count < randJ, let free = grid.freeTile() {
            let jumper = Jumper(on: free)
            jumpers.append(jumper)
        }

        let randR = Settings.RAIN_FREE_COLUMNS.randomElement() ?? 8
        let active = Settings.COLUMN_COUNT.toInt - randR
        rains: if rains.count < active, let free = grid.freeColumn() {
            guard !rains.contains(where: { $0.x == free.x }) else { break rains }

            let rain = Rain(on: free.column, at: free.x)
            rains.append(rain)
        }

        // Update the UI

        grid.update()
    }

}
