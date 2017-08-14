//
//  Dieukhoan.swift
//  WeThong
//
//  Created by jenkins on 6/13/17.
//  Copyright © 2017 VietCat. All rights reserved.
//

import Foundation

class Dieukhoan: NSObject {
    var id:Int64
    var so:String
    var tieude:String
    var noidung:String
    var minhhoa:[String]=[]
    var cha:Int64
    var vanban:Vanban
    
//    init(id:Int64,so:String,tieude:String,noidung:String,minhhoa:[String],cha:Int64,vanbanid:Int64) {
//        self.id=id
//        self.so=so
//        self.tieude=tieude
//        self.noidung=noidung
//        self.minhhoa=minhhoa
//        self.cha=cha
//        self.vanbanid=vanbanid
//    }
    
    init(id:Int64,so:String,tieude:String,noidung:String,minhhoa:String,cha:Int64,vanban:Vanban) {
        self.id=id
        self.so=so
        self.tieude=tieude
        self.noidung=noidung
        self.cha=cha
        self.vanban=vanban
        for mh in minhhoa.components(separatedBy: ";") {
            self.minhhoa.append(mh)
        }
    }
    
    init(id:Int64,cha:Int64,vanban:Vanban) {
        self.id=id
        self.cha=cha
        self.vanban=vanban
        self.so=""
        self.tieude=""
        self.noidung=""
    }
    
    func getId() -> Int64 {
        return id
    }
    
    func setId(id:Int64) {
        self.id=id
    }
    
    func getSo() -> String {
        return so
    }
    
    func setSo(so:String) {
        self.so=so
    }
    
    func getTieude() -> String {
        return tieude
    }
    
    func setTieude(tieude:String) {
        self.tieude=tieude
    }
    
    func getNoidung() -> String {
        return noidung
    }
    
    func setNoidung(noidung:String) {
        self.noidung=noidung
    }
    
    func getMinhhoa() -> [String] {
        return minhhoa
    }
    
    func setMinhhoa(minhhoa:[String]) {
        self.minhhoa=minhhoa
    }
    
    func addMinhhoa(minhhoa:String) {
        self.minhhoa.append(minhhoa)
    }
    
    func getCha() -> Int64 {
        return cha
    }
    
    func setCha(cha:Int64) {
        self.cha=cha
    }
    
    func getVanban() -> Vanban {
        return vanban
    }
    
    func setVanban(vanban:Vanban) {
        self.vanban=vanban
    }
}
