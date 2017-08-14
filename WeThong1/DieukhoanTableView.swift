//
//  DieukhoanTableView.swift
//  WeThong1
//
//  Created by jenkins on 6/23/17.
//  Copyright © 2017 VietCat. All rights reserved.
//

import UIKit

class DieukhoanTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    @IBOutlet weak var searchBar: UISearchBar!

    func initSearch() {
        self.tableHeaderView = searchBar        
    }    
}
