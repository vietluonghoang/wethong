//
//  ImageTableViewCell.swift
//  WeThong1
//
//  Created by jenkins on 6/28/17.
//  Copyright © 2017 VietCat. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    var imageName:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setImageName(imageName: String) {
        self.imageName = imageName
    }
    func updateView() {
        let img = UIImage(named: (imageName.replacingOccurrences(of: ".png", with: "").replacingOccurrences(of: "\n", with: "")))
        
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.image = img        
    }
    
}
