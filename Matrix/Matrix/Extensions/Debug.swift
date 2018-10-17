//
//  Debug.swift
//  Matrix
//
//  Created by Christophe Bronner on 2018-08-22.
//  Copyright © 2018 Christophe Bronner. All rights reserved.
//

//MARK: - Debug

extension Debug {
    
    /// Gets called everytime the screen saver is ran
    static func debug() {
        
    }
    
}

//MARK: - Debug Class

import AppKit

class Debug {
    private init() { }
    
    @discardableResult
    init(_ b: () -> ()) {
        if Debug.debugMode {
            b()
        }
    }
    
    //MARK: - Debug
    
    static var debugMode: Bool = false
    
    private static var limit: Int = -1
    
    //MARK: - Stats
    
    static var lifetime: Int = 0 {
        didSet {
            if lifetime == limit {
                NSApp.mainWindow?.close()
            }
        }
    }
    
    static var averageUpdateTimes: [TimeInterval] = []
    static var aut_timestamp: Date = Date()
    
    static var averageUpdatePerSeconds: [Int] = []
    static var aups_timestamp: Date = Date()
    static var aups_counter: Int = 0
    
    static var averageJumpers: [Int] = []
    static var averageRains: [Int] = []
    
    static var averageUpdateTime: TimeInterval {
        var total: TimeInterval = 0
        averageUpdateTimes.forEach { total -= $0 }
        return total / averageUpdateTimes.count.toDouble
    }
    
    //MARK: - Constants
    
    static let CHARS_FILE_PATH = "/Users/christophe/Programming/Screen Savers/Matrix/Matrix/Resources/Chars"
    
    //MARK: - Methods
    
    static func cleanChars(_ using: [Character]) {
        let path = Debug.CHARS_FILE_PATH
        guard let string = try? String(contentsOfFile: path) else {
            print("ERROR - INCORRECT PATH: \"\(path)\"")
            return
        }
        
        var left: [Character] = []
        for each in string.map({ $0 }) {
            guard !using.contains(each) else { continue }
            left.append(each)
        }
        
        let newString = String(left)
        guard let data = newString.data(using: .utf8) else { return }
        
        FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
    }
    
    //MARK: - Shorcuts
    
    static func average(of: [Int]) -> Int {
        guard !of.isEmpty else { return -1 }
        
        var total: Int = 0
        of.forEach { total += $0 }
        return total / of.count
    }
    
}
