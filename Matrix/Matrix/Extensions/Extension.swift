//
//  Extension.swift
//  Matrix
//
//  Created by Christophe Bronner on 2018-08-22.
//  Copyright © 2018 Christophe Bronner. All rights reserved.
//

import Cocoa

extension Int {
    
    var toCGFloat: CGFloat { return CGFloat(self) }
    var toInt32: Int32 { return Int32(self) }
    var toUInt32: UInt32 { return UInt32(self) }
    var toDouble: Double { return Double(self) }
    
}

extension CGFloat {
    
    var toInt: Int { return Int(self) }
    
}

extension Int32 {
    
    var toInt: Int { return Int(self) }
    
}

extension UInt32 {
    
    var toInt: Int { return Int(self) }
    
}

extension NSColor {
    
    var rgbDescription: String {
        let red = (redComponent * 255).toInt
        let green = (greenComponent * 255).toInt
        let blue = (blueComponent * 255).toInt
        return "R\(red), G\(green), B\(blue)"
    }
    
}

extension Double {
    
    var toInt: Int { return Int(self) }
    
    var percentDescription: String {
        guard self >= 0 && self <= 100 else { return "ErrorDoubleNotInPercentRange" }
        
        let percent = self > 1 ? self : self * 100
        return "\(percent.toInt)%"
    }
    
}

extension NSSize: Comparable {
    
    var area: CGFloat { return width * height }
    
    public static func <(lhs: CGSize, rhs: CGSize) -> Bool {
        return lhs.width < rhs.width && lhs.height < rhs.height
    }
    
    public static func >(lhs: CGSize, rhs: CGSize) -> Bool {
        return !(lhs < rhs)
    }
    
}

extension NSImage {
    
    func imageWith(tintColor: NSColor) -> NSImage {
        let image = copy() as! NSImage
        image.lockFocus()
        
        tintColor.set()
        __NSRectFillUsingOperation(NSMakeRect(0, 0, image.size.width, image.size.height), NSCompositingOperation.sourceAtop)
        
        image.unlockFocus()
        image.isTemplate = false
        
        return image
    }
    
    func flippedHorizontally() -> NSImage {
        let flippedImage = NSImage(size: size)
        flippedImage.lockFocus()

        let t = NSAffineTransform()
        t.translateX(by: size.width, yBy: 0)
        t.scaleX(by: -1, yBy: 1)
        t.concat()

        let rect = NSRect(x: 0, y: 0, width: size.width, height: size.height)
        draw(at: .zero, from: rect, operation: .sourceOver, fraction: 1)
        flippedImage.unlockFocus()
        
        return flippedImage
    }
    
}

extension Array {
    
    func at(_ index: Index) -> Element? {
        guard index > -1, index < count else { return nil }
        return self[index]
    }
    
}
