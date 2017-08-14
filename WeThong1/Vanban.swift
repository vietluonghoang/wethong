//
//  Vanban.swift
//  WeThong
//
//  Created by jenkins on 6/13/17.
//  Copyright © 2017 VietCat. All rights reserved.
//

import Foundation
class Vanban: NSObject {
    var id:Int64
    var ten:String
    var loai:Loaivanban
    var so:String
    var nam:String
    var ma:String
    var coquanbanhanh:Coquanbanhanh
    var noidung:String
    
    init(id:Int64,ten:String,loai:Loaivanban,so:String,nam:String,ma:String,coquanbanhanh:Coquanbanhanh,noidung:String) {
        self.id=id
        self.ten=ten
        self.loai=loai
        self.so=so
        self.nam=nam
        self.ma=ma
        self.coquanbanhanh=coquanbanhanh
        self.noidung=noidung
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
    
    func getTen() -> String {
        return ten
    }
    
    func setTen(ten:String) {
        self.ten=ten
    }
    
    func getNoidung() -> String {
        return noidung
    }
    
    func setNoidung(noidung:String) {
        self.noidung=noidung
    }
    
    func getNam() -> String {
        return nam
    }
    
    func setNam(nam:String) {
        self.nam=nam
    }
    
    func getLoai() -> Loaivanban {
        return loai
    }
    
    func setLoai(loai:Loaivanban) {
        self.loai=loai
    }
    
    func getCoquanbanhanh() -> Coquanbanhanh {
        return coquanbanhanh
    }
    
    func setCoquanbanhanh(coquanbanhanh:Coquanbanhanh) {
        self.coquanbanhanh=coquanbanhanh
    }
    
    func getMa() -> String {
        return ma
    }
    
    func setma(ma:String) {
        self.ma=ma
    }
}
