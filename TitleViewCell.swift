//
//  TitleViewCell.swift
//  DoubanJSON
//
//  Created by Noirozr on 15/7/1.
//  Copyright (c) 2015年 Yongjia Liu. All rights reserved.
//

import UIKit

class TitleViewCell: UITableViewCell {
    
    var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initLabel()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setTitle(text: String) {
        label.text = text
    }
    
    func initLabel() {
        
        label = UILabel(frame: self.frame)
        //label = UILabel(frame: CGRectMake(40, 0, self.frame.size.width, self.frame.size.height))
        label.font = UIFont(name: "optima", size: 20)
        label.numberOfLines = 0
        label.text = "title"
        label.textColor = UIColor(red:0.09, green:0.17, blue:0.31, alpha:1)
        self.addSubview(label)
    }
    
}
