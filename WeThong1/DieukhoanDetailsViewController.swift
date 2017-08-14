//
//  DieukhoanDetailsViewController.swift
//  WeThong1
//
//  Created by jenkins on 6/26/17.
//  Copyright © 2017 VietCat. All rights reserved.
//

import UIKit
import os.log

class DieukhoanDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    
    @IBOutlet weak var lblVanban: UILabel!
    @IBOutlet weak var lblDieukhoan: UILabel!
    @IBOutlet weak var lblNoidung: UILabel!
    @IBOutlet weak var scvDetails: UIScrollView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var svStackview: UIStackView!
    @IBOutlet weak var lblSeeMore: UILabel!
    @IBOutlet weak var consTblView: NSLayoutConstraint!
    
    var images = [String]()
    var children = [Dieukhoan]()
    var dieukhoan: Dieukhoan? = nil
    var search = SearchUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scvDetails.autoresizingMask = UIViewAutoresizing.flexibleHeight
        lblNoidung.numberOfLines = 0
        lblNoidung.lineBreakMode = NSLineBreakMode.byWordWrapping
        // Do any additional setup after loading the view.
        
        tblView.delegate = self
        tblView.dataSource = self
        if(children.count>0){
            lblSeeMore.text = "Xem thêm"
            tblView.isHidden = false
        }else{
            lblSeeMore.text = ""
            tblView.isHidden = true
            consTblView.constant = CGFloat(0)
        }
        showDieukhoan()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func updateDetails(dieukhoan: Dieukhoan) {
        self.dieukhoan = dieukhoan
        let noidung = "\(String(describing: dieukhoan.getTieude().trimmingCharacters(in: .whitespacesAndNewlines))) \n \(String(describing: dieukhoan.getNoidung().trimmingCharacters(in: .whitespacesAndNewlines)))"
        
        for child in getChildren(keyword: String(describing: dieukhoan.id)) {
            appendRelatedChild(child: child)
        }
        
        var keywords: [String] = []
        
        for k in getRelatedDirectKeywords(content: noidung) {
            var key = k.lowercased()
            if key.characters.count>0 {
                if key.contains("điều")||key.contains("chương")||key.contains("phần")||key.contains("mục")||key.contains("phụ lục") {
                    keywords.append(key)
                }else{
                    keywords.append(key.components(separatedBy: " ")[1])
                }
            }
        }
        
        for key in keywords {
            for child in getRelatedChildren(keyword: key) {
                let pattern = "^\\s*\(key.replacingOccurrences(of: ".", with: "\\."))\\.*\\s*$"
                if search.regexSearch(pattern: pattern, searchIn: child.getSo().lowercased()).count>0{
                    appendRelatedChild(child: child)
                }
            }
        }
        
      //  TODO: need to make this simpler
        
        for k in getRelatedPlatKeywords(content: noidung) {
            var key = k.lowercased()
            if key.characters.count>0 {
                keywords.append(key)
                for child in getRelatedChildren(keyword: key)
                {
                    let noidung = child.getTieude() + " "+child.getNoidung()
                    if getParent(keyword: getAncesters(dieukhoan: child).components(separatedBy: "-")[0])[0].getSo().lowercased().contains("phụ lục")&&(search.regexSearch(pattern: "^\\s*\(key.replacingOccurrences(of: ".", with: "\\."))\\s+", searchIn: noidung).count>0 || search.regexSearch(pattern: "\\s+\(key.replacingOccurrences(of: ".", with: "\\."))\\.*\\s+", searchIn: noidung).count>0 || search.regexSearch(pattern: "\\s+\(key.replacingOccurrences(of: ".", with: "\\."))\\.*$", searchIn: noidung).count>0) {
                        appendRelatedChild(child: child)
                    }
                }
            }
        }
        
        for child in getParent(keyword: String(describing: dieukhoan.cha)) {
            appendRelatedChild(child: child)
        }
        
    }
    
    func appendRelatedChild(child: Dieukhoan) {
        if child.id != self.dieukhoan?.id {
            var isExisted = false
            for c in children {
                if c.getId() == child.getId(){
                    isExisted = true
                }
            }
            if !isExisted {
                children.append(child)
            }
        }
    }
    func getAncesters(dieukhoan:Dieukhoan) -> String {
        var ancesters = ""
        if dieukhoan.getCha() == 0 {
            ancesters = "\(dieukhoan.getId())"
        }else{
            ancesters = "\(dieukhoan.getCha())"
            var parents = getParent(keyword: "\(dieukhoan.getCha())")
            while parents[0].getCha() != 0 {
                ancesters = "\(parents[0].getCha())-"+ancesters
                parents = getParent(keyword: "\(parents[0].getCha())")
            }
            
        }
        return ancesters
    }
    func showDieukhoan() {
        lblVanban.text = dieukhoan!.getVanban().getMa().trimmingCharacters(in: .whitespacesAndNewlines)
        lblDieukhoan.text = dieukhoan!.getSo().trimmingCharacters(in: .whitespacesAndNewlines)
        let noidung = "\(String(describing: dieukhoan!.getTieude().trimmingCharacters(in: .whitespacesAndNewlines))) \n \(String(describing: dieukhoan!.getNoidung().trimmingCharacters(in: .whitespacesAndNewlines)))"
        lblNoidung.text = noidung
        
        images = dieukhoan!.getMinhhoa()
        
        if images.count < 1 {
            svStackview.isHidden = true
        }else if (images[0].replacingOccurrences(of: ".png", with: "").replacingOccurrences(of: "\n", with: "")).trimmingCharacters(in: .whitespacesAndNewlines).characters.count < 1{
            svStackview.isHidden = true
        }else{
            svStackview.isHidden = false
            
            svStackview.translatesAutoresizingMaskIntoConstraints = false
            svStackview.axis = UILayoutConstraintAxis.vertical
            
            for img in images {
                let image = UIImage(named: (img.replacingOccurrences(of: ".png", with: "").replacingOccurrences(of: "\n", with: "")).trimmingCharacters(in: .whitespacesAndNewlines))
                let imgView = UIImageView(image: image)
                imgView.clipsToBounds = true
                imgView.contentMode = UIViewContentMode.scaleAspectFit
                imgView.heightAnchor.constraint(equalToConstant: 200).isActive = true
                imgView.widthAnchor.constraint(equalToConstant: 200).isActive = true
                
                svStackview.addArrangedSubview(imgView)
            }
        }
    }
    
    func getChildren(keyword:String) -> [Dieukhoan] {
        if Utils.database == nil {
            Utils.databaseSetup()
        }
        return Query.searchChildren(keyword: "\(keyword)")
    }
    
    func getParent(keyword:String) -> [Dieukhoan] {
        if Utils.database == nil {
            Utils.databaseSetup()
        }
        return Query.searchDieukhoanByID(keyword: "\(keyword)")
    }
    
    func getRelatedChildren(keyword:String) -> [Dieukhoan] {
        if Utils.database == nil {
            Utils.databaseSetup()
        }
        return Query.searchDieukhoan(keyword: "\(keyword)")
    }
    
    //    func getDirectChildren(keyword:String) -> [Dieukhoan] {
    //        if Utils.database == nil {
    //            Utils.databaseSetup()
    //        }
    //        return Query.searchDieukhoanBySo(keyword: "\(keyword)")
    //    }
    
    func getRelatedDirectKeywords(content:String) -> [String] {
        let input = content.lowercased()
        
        let pattern = "((điều|chương|phần)\\s\\d{1,3})|((mục|phụ\\slục)\\s([A-Z]|[a-z]){1,3})|(khoản\\s\\d{1,3}\\.\\d{1,3})|((điểm)\\s\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})"
        
        return search.regexSearch(pattern: pattern, searchIn: input)
    }
    
    func getRelatedPlatKeywords(content:String) -> [String] {
        let input = content.lowercased()
        
        let pattern = "(([A-Z]|[a-z]){1,2}\\.\\d{1,4})|(vạch)\\s(\\d)+(\\.\\d)*"
        return search.regexSearch(pattern: pattern, searchIn: input)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return children.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "dieukhoanSeeMore"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DieukhoanSeeMoreTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        cell.updateDieukhoan(dieukhoan: children[indexPath.row])
        if(consTblView.constant == 0){
            consTblView.constant = CGFloat(CGFloat(children.count)*cell.bounds.height)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "showMore":
            guard let dieukhoanDetails = segue.destination as? DieukhoanDetailsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedDieukhoanCell = sender as? DieukhoanSeeMoreTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tblView.indexPath(for: selectedDieukhoanCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedDieukhoan = children[indexPath.row]
            dieukhoanDetails.updateDetails(dieukhoan: selectedDieukhoan)
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
}
