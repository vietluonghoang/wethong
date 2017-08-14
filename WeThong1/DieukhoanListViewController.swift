//
//  DieukhoanListViewController.swift
//  WeThong1
//
//  Created by jenkins on 6/29/17.
//  Copyright © 2017 VietCat. All rights reserved.
//

import UIKit
import os.log

class DieukhoanListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var tblView: UITableView!
    
    var dieukhoanList = [Dieukhoan]()
    let searchController = UISearchController(searchResultsController: nil)
    var rowCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tblView.delegate = self
        tblView.dataSource = self
        
        initSearch()
        
        if Utils.database == nil {
            Utils.databaseSetup()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initSearch() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tblView.tableHeaderView = searchController.searchBar
    }
    
    func updateDieukhoanList(arrDieukhoan: Array<Dieukhoan>)  {
        self.dieukhoanList=arrDieukhoan
    }
    
    func search(keyword:String) -> [Dieukhoan]{
        var rs:[Dieukhoan]
        //        rs=Query.selectAllDieukhoan()
        rs=Query.searchDieukhoan(keyword: "\(keyword)")
        //        lblKetqua.text = "Có \(rs.count) kết quả cho từ khoá \(keyword)"
//        for r in rs {
//            print(r.getTieude())
//            //            lblResultId.text="\(r.getId())";
//        }
        return rs
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "showDieukhoan":
            guard let dieukhoanDetails = segue.destination as? DieukhoanDetailsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedDieukhoanCell = sender as? DieukhoanTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tblView.indexPath(for: selectedDieukhoanCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedDieukhoan = dieukhoanList[indexPath.row]
            dieukhoanDetails.updateDetails(dieukhoan: selectedDieukhoan)
        case "viewImages":
            guard let imageViews = segue.destination as? ImageViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedDieukhoanCell = sender as? DieukhoanTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tblView.indexPath(for: selectedDieukhoanCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let images:[String] = ["QC41-Hinh_33","QC41-Hinh_33","QC41-Hinh_33","QC41-Hinh_33","QC41-Hinh_33","QC41-Hinh_33"]
            
            imageViews.updateImages(images: images)
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "tblDieukhoanCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DieukhoanTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Configure the cell...
        
        var dieukhoan:Dieukhoan
        
        if searchController.isActive && searchController.searchBar.text != "" {
            if dieukhoanList.count>0 {
                dieukhoan = dieukhoanList[indexPath.row]
            }else{
                dieukhoan = Dieukhoan(id: 0, cha: 0, vanban: Vanban(id: 0, ten: "", loai: Loaivanban(id: 0, ten: ""), so: "", nam: "", ma: "", coquanbanhanh: Coquanbanhanh(id: 0, ten: ""), noidung: ""))
                dieukhoan.setMinhhoa(minhhoa: [""])
            }
        } else {
            dieukhoan = dieukhoanList[indexPath.row]
        }
        
        cell.updateDieukhoan(dieukhoan: dieukhoan)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowCount
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        updateDieukhoanList(arrDieukhoan: search(keyword: searchText.trimmingCharacters(in: .whitespacesAndNewlines)))
        rowCount = dieukhoanList.count
        tblView.reloadData()
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: "All")
    }
    
}
