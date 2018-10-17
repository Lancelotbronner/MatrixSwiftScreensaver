//
//  Resources.swift
//  Matrix
//
//  Created by Christophe Bronner on 2018-08-26.
//  Copyright © 2018 Christophe Bronner. All rights reserved.
//

import Cocoa

class Resources {
    private init() { }
    
    //MARK: - Properties
    
    static var chars: [Character] = {
        let valid = CHARS_SHEET.replacingOccurrences(of: "\n", with: "")
        return valid.map { $0 }
    }()
    
    static var symbols: [NSImage] = {
        return getSymbols(of: Settings.CHAR_COLOR)
    }()
    
    static var symbolsLit: [NSImage] = {
       return getSymbols(of: Settings.LIGHTEN_UP_CHAR_COLOR)
    }()
    
    //MARK: - Private Properties
    
    private static var frame: NSRect!
    private static var tileWidth: CGFloat!
    private static var tileHeight: CGFloat!
    private static var imageSize: NSSize!
    private static var font: NSFont!
    
    //MARK: - Methods
    
    static func prepare(_ matrix: Matrix) {
        frame = matrix.frame
        
        tileWidth = frame.width / Settings.COLUMN_COUNT
        tileHeight = frame.height / Settings.ROW_COUNT
        imageSize = NSSize(width: tileWidth, height: tileHeight)
        font = font(imageSize)
        
        print("   Resources initialization")
        print("      Values")
        print("         - Tile Width: \(tileWidth!.toInt)")
        print("         - Tile Height: \(tileWidth!.toInt)")
        print("         - Font Size: \(font!.pointSize.toInt)")
        print("      Symbols")
        print("         - Chars: \(chars.count)")
        print("         - Symbols: \(symbols.count)")
        print("         - Lit Symbols: \(symbolsLit.count)")
    }
    
    static func symbol(_ litUp: Bool = false) -> NSImage {
        return litUp ? symbolsLit.randomElement()! : symbols.randomElement()!
    }
    
    //MARK: - Private Methods
    
    private static func getSymbols(of color: NSColor) -> [NSImage] {
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : color,
            NSAttributedString.Key.font : font,
            ]
        
        let attributed = chars.map { NSAttributedString(string: "\($0)", attributes: attributes) }
        
        let images = attributed.map { attStr -> NSImage in
            let image = NSImage(size: imageSize)
            
            image.lockFocus()
            attStr.draw(at: .zero)
            image.unlockFocus()
            
            return image.flippedHorizontally()
        }
        
        return images
    }
    
    private static func font(_ fit: NSSize) -> NSFont {
        func f(_ i: CGFloat) -> NSFont { return NSFont.systemFont(ofSize: i) }
        func att(_ nsf: NSFont) -> NSAttributedString { return NSAttributedString(string: "驘", attributes: [.font : nsf]) }
        
        var last: CGFloat = -1
        var i: CGFloat = 1
        var font = f(i)
        
        while att(font).size() < fit {
            last = i
            i += 1
            font = f(i)
        }
        
        return f(last)
    }
    
}
