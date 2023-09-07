//
//  Extensions.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import Foundation
import UIKit
import SwiftUI

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    
    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }
}

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}

extension Date {
    static func randomBetween(start: Date, end: Date) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }
}

func saveImageToDocumentDirectory(_ chosenImage: UIImage, filename: String) -> String {
    let directoryPath =  NSHomeDirectory().appending("/Documents/")
    if !FileManager.default.fileExists(atPath: directoryPath) {
        do {
            try FileManager.default.createDirectory(at: NSURL.fileURL(withPath: directoryPath), withIntermediateDirectories: true, attributes: nil)
        } catch {
            print(error)
        }
    }
    
    let filepath = directoryPath.appending(filename)
    let url = NSURL.fileURL(withPath: filepath)
    do {
        try chosenImage.jpegData(compressionQuality: 1.0)?.write(to: url, options: .atomic)
        return String.init("/Documents/\(filename)")
        
    } catch {
        print(error)
        print("file cant not be save at path \(filepath), with error : \(error)");
        return filepath
    }
}
