//
//  NSAttributedString+Extensions.swift
//  TopRockAlbums
//
//  Created by acon on 22/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    static func bold(str: String, fontSize: CGFloat, color: UIColor = .black) -> NSAttributedString {
        return NSAttributedString(string: str,
                                  attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: fontSize),
                                               NSAttributedString.Key.foregroundColor : color])
    }
    static func normal(str: String, fontSize: CGFloat, color: UIColor = .black) -> NSAttributedString {
        return NSAttributedString(string: str,
                                  attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize),
                                               NSAttributedString.Key.foregroundColor : color])
    }
    
    static func concat(_ strings: [NSAttributedString]) -> NSAttributedString {
        let ret = NSMutableAttributedString()
        for str in strings {
            ret.append(str)
        }
        return NSAttributedString(attributedString: ret)
    }
}
