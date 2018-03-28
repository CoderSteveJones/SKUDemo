//
//  GoodsStandardsCell.swift
//  GlobalHouse_Swift
//
//  Created by 江奔 on 2018/3/27.
//  Copyright © 2018年 yueyi. All rights reserved.
//

import UIKit

class GoodsStandardsCell: UICollectionViewCell {

    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var standardsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setViewBorderRadius(view: self.bgView, radius: 5, width: 1, color: UIColor.darkText)
    }
    
    var tagsChild: GoodsTagsChild? {
        didSet {
            
            standardsLabel.text = tagsChild?.childStr
            /**
             item 总共三种状态： 可点击状态 UIColor.darkText
                            不可点击状态 UIColor.lightGray
                            被选中状态 UIColor.red
             **/
            
            // 可点击状态设置
            let canClickBorderColor = (tagsChild?.isCanClick)! ? UIColor.darkText : UIColor.lightGray
            setViewBorderRadius(view: self.bgView, radius: 5, width: 1, color: canClickBorderColor)
            standardsLabel.textColor = canClickBorderColor
            
            // 被选择颜色(在可点击状态下才能设置被选颜色)
            if (tagsChild?.isCanClick)! {
                let selectedColor = (tagsChild?.isSelected)! ? UIColor.red : canClickBorderColor
                setViewBorderRadius(view: self.bgView, radius: 5, width: 1, color: selectedColor)
                standardsLabel.textColor = selectedColor
            }
            
            
        }
    }

    
}
