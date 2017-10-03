//
//  Utility.swift
//  MusicSearch
//
//  Created by Milan Shah on 10/1/17.
//  Copyright © 2017 Milan Shah. All rights reserved.
//

import Foundation
class Utility: NSObject {
    
    
    
}

extension String {
    func replace(target: String, withString : String) -> String {
        return self.replacingOccurrences(of: target, with: withString)
    }
    mutating func addString (str : String){
        self = self + str
    }
}
