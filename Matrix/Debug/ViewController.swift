//
//  ViewController.swift
//  Debug
//
//  Created by Christophe Bronner on 2018-08-22.
//  Copyright © 2018 Christophe Bronner. All rights reserved.
//

import Cocoa

var saver: Matrix!

class ViewController: NSViewController {
    
    //MARK: - Properties
    
    var scheduled: Timer?
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saver = Matrix(frame: view.frame)
        
        #if DEBUG
            Debug.debugMode = true
        #endif
        
        view.addSubview(saver)
        Debug.debug()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        print("<============| Starting Session |============>")
        
        saver.startAnimation()
        scheduled = Timer.scheduledTimer(timeInterval: Settings.UPDATE_INTERVAL, target: saver, selector: #selector(saver.animateOneFrame), userInfo: nil, repeats: true)
        
        do {
            // Settings
            
            print("   Settings:")
            print("      Grid:")
            print("         - Rows: \(Settings.ROW_COUNT.toInt)")
            print("         - Columns: \(Settings.COLUMN_COUNT.toInt)")
            print("         - Tiles: \(Settings.ROW_COUNT.toInt * Settings.COLUMN_COUNT.toInt)")
            print("      Matrix:")
            print("         - Update Interval: \(Settings.UPDATE_INTERVAL) seconds")
            print("         - Regular Character Color: \(Settings.CHAR_COLOR.rgbDescription)")
            print("         - Lit Up Character Color: \(Settings.LIGHTEN_UP_CHAR_COLOR.rgbDescription)")
            print("      Jumper:")
            print("         - Count Range: \(Settings.JUMPER_COUNT_RANGE)")
            print("         - Lifetime Range: \(Settings.JUMPER_LIFETIME_RANGE)")
            print("         - Lit Up Chance: \(Settings.JUMPER_LIGHTEN_UP_CHANCE.percentDescription)")
            print("      Rain:")
            print("         - Free Columns Range: \(Settings.RAIN_FREE_COLUMNS)")
            print("         - Lenght Range: \(Settings.RAIN_LENGHT_RANGE)")
            print("         - Added Height Range: \(Settings.RAIN_HEIGHT_RANGE)")
            print("\n")
        }
        
        do {
            // Character Sheet
            
            print("   Scanning Character Sheet")
            
            var temp = ""
            var found: [Character : Int] = [:]
            
            for each in Resources.chars {
                if temp.contains(each) {
                    let contained = found.contains(where: { $0.key == each })
                    
                    if contained {
                        found[each]! += 1
                        
                    } else {
                        found[each] = 2
                    }
                    
                    continue
                }
                
                temp.append(each)
            }
            
            let printable = found.map { "      > Character \($0.key) was found \($0.value) times" }
            for each in printable {
                print(each)
            }
            
            if printable.isEmpty {
                print("      No duplicates found")
                
            } else {
                let duplicates = found.map { $0.key }
                print("\n      Cleaning \(duplicates.count) duplicates")
                
                Debug.cleanChars(duplicates)
            }
            
            print("\n")
            
            // End
            
        }
        
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        
        print("\n\n\n")
        print("<============| Session Ended |============>")
        print("   - Ticks: \(Debug.lifetime)")
        print("   - Average Update Time: \((Debug.averageUpdateTime * 1000).toInt) milliseconds")
        print("   - Average Updates per Second: \(Debug.average(of: Debug.averageUpdatePerSeconds))")
        print("   - Average Jumpers: \(Debug.average(of: Debug.averageJumpers))")
        print("   - Average Rains: \(Debug.average(of: Debug.averageRains))")
        
        // TODOS
        
        print("\n")
        print("   TODOS:")
        print("      - None!")
        
        // Deinit
        scheduled?.invalidate()
        saver.stopAnimation()
        
        // Close the app
        exit(0)
    }
    
}
