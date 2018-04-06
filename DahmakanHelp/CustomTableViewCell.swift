//
//  CustomTableViewCell.swift
//  DahmakanHelp
//
//  Created by Jeelakarra Swathi on 06/04/2018.
//  Copyright © 2018 Jeelakarra Swathi. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var mainHeadingLabel: UILabel!
    @IBOutlet weak var subHeadingLabel: UILabel!
    @IBOutlet weak var contentSubView: UIView!
    @IBOutlet weak var disclosureImg: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        contentSubView.frame = CGRect(x: 20, y: 15, width: ContentView.frame.width-40 , height: 60)
        contentSubView.backgroundColor = UIColor.white
        contentSubView.layer.borderWidth = 0.1
        contentSubView.layer.borderColor = UIColor.black.cgColor
        contentSubView.layer.cornerRadius = 3
        ContentView.addSubview(contentSubView)
        
        mainHeadingLabel.frame = CGRect(x: 15, y: 15, width: 140, height: 15)
        mainHeadingLabel.backgroundColor = UIColor.clear
        mainHeadingLabel.textAlignment = .left
        mainHeadingLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        contentSubView.addSubview(mainHeadingLabel)
        
        subHeadingLabel.frame = CGRect(x: 15, y: 35, width: 230, height: 15)
        subHeadingLabel.backgroundColor = UIColor.clear
        subHeadingLabel.textAlignment = .left
        subHeadingLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        subHeadingLabel.textColor = .gray
        contentSubView.addSubview(subHeadingLabel)
        
        disclosureImg.frame = CGRect(x: contentSubView.frame.size.width-30, y: 19, width: 15, height: 15)
        contentSubView.addSubview(disclosureImg)
    }
}
