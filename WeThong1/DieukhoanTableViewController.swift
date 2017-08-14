//
//  DieukhoanTableViewController.swift
//  WeThong
//
//  Created by jenkins on 6/15/17.
//  Copyright © 2017 VietCat. All rights reserved.
//

import UIKit
import os.log

class DieukhoanTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var dieukhoanList = [Dieukhoan]()
    var filteredDieukhoanList = [Dieukhoan]()
    let searchController = UISearchController(searchResultsController: nil)
    var rowCount: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        tableView.contentInset.top = 18
        
        initSearch()
        
        if Utils.database == nil {
            Utils.databaseSetup()
        }
        dieukhoanList=search(keyword: "biển báo cấm")
        rowCount=dieukhoanList.count
    }
    
    func initSearch() {
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    func updateDieukhoanList(arrDieukhoan: Array<Dieukhoan>)  {
        self.dieukhoanList=arrDieukhoan
    }
    
    func search(keyword:String) -> [Dieukhoan]{
        var rs:[Dieukhoan]
        //        rs=Query.selectAllDieukhoan()
        rs=Query.searchDieukhoan(keyword: "%\(keyword)%")
        //        lblKetqua.text = "Có \(rs.count) kết quả cho từ khoá \(keyword)"
        for r in rs {
            print(r.getTieude())
            //            lblResultId.text="\(r.getId())";
        }
        return rs
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowCount
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "tblDieukhoanCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DieukhoanTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Configure the cell...
        var dieukhoan:Dieukhoan
        if searchController.isActive && searchController.searchBar.text != "" {
            if filteredDieukhoanList.count>0 {
                do {
                    if(filteredDieukhoanList.count > indexPath.row){
                        dieukhoan = filteredDieukhoanList[indexPath.row]
                    }else{
                        dieukhoan = Dieukhoan(id: 0, cha: 0, vanban: Vanban(id: 0, ten: "", loai: Loaivanban(id: 0, ten: ""), so: "", nam: "", ma: "", coquanbanhanh: Coquanbanhanh(id: 0, ten: ""), noidung: ""))
                        dieukhoan.setMinhhoa(minhhoa: [""])
                    }
                } catch {
                    dieukhoan = Dieukhoan(id: 0, cha: 0, vanban: Vanban(id: 0, ten: "", loai: Loaivanban(id: 0, ten: ""), so: "", nam: "", ma: "", coquanbanhanh: Coquanbanhanh(id: 0, ten: ""), noidung: ""))
                    dieukhoan.setMinhhoa(minhhoa: [""])
                }
            }else{
                dieukhoan = Dieukhoan(id: 0, cha: 0, vanban: Vanban(id: 0, ten: "", loai: Loaivanban(id: 0, ten: ""), so: "", nam: "", ma: "", coquanbanhanh: Coquanbanhanh(id: 0, ten: ""), noidung: ""))
                dieukhoan.setMinhhoa(minhhoa: [""])
            }            
        } else {
            dieukhoan = dieukhoanList[indexPath.row]
            rowCount=dieukhoanList.count
        }
        
        
        cell.updateDieukhoan(dieukhoan: dieukhoan)
        return cell
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredDieukhoanList = dieukhoanList.filter { dk in            return  dk.getSo().lowercased().contains(
            searchText.lowercased()) || dk.getTieude().lowercased().contains(
                searchText.lowercased()) || dk.getNoidung().lowercased().contains(
                    searchText.lowercased())
        }
        rowCount=filteredDieukhoanList.count
        tableView.reloadData()
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: "All")
        print(searchController.searchBar.text!)
        print("dk: \(dieukhoanList.count) - fdk: \(filteredDieukhoanList.count) - rc: \(rowCount)")
    }
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
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
            
            guard let indexPath = tableView.indexPath(for: selectedDieukhoanCell) else {
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
            
            guard let indexPath = tableView.indexPath(for: selectedDieukhoanCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let images:[String] = ["QC41-Hinh_33","QC41-Hinh_33","QC41-Hinh_33","QC41-Hinh_33","QC41-Hinh_33","QC41-Hinh_33"]
            
            imageViews.updateImages(images: images)
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
     }

    
}
