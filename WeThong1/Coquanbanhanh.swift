//
//  Coquanbanhanh.swift
//  WeThong
//
//  Created by jenkins on 6/13/17.
//  Copyright © 2017 VietCat. All rights reserved.
//

import Foundation
class Coquanbanhanh: NSObject {
    var id:Int64
    var ten:String
    
    init(id:Int64,ten:String) {
        self.id=id
        self.ten=String(describing: ten.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    func getId() -> Int64 {
        return id
    }
    
    func setId(id:Int64) {
        self.id=id
    }
    
    func getTen() -> String {
        return ten
    }
    
    func setTen(ten:String) {
        self.ten=String(describing: ten.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
}
