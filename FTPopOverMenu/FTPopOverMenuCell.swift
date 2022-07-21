//
//  FTPopOverMenuCell.swift
//  FTPopOverMenu_Swift
//
//  Created by Abdullah Selek on 28/07/2017.
//  Copyright © 2016 LiuFengting (https://github.com/liufengting) . All rights reserved.
//

import UIKit

class FTPopOverMenuCell: UITableViewCell {

    fileprivate lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.contentView.addSubview(imageView)
        return imageView
    }()

    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.backgroundColor = UIColor.clear
        self.contentView.addSubview(label)
        return label
    }()

    func setupCellWith(menuName: FTMenuObject, menuImage: Imageable?, configuration: FTConfiguration) {
        self.backgroundColor = UIColor.clear
        
        // Configure cell text
        nameLabel.font = configuration.textFont
        nameLabel.textColor = configuration.textColor
        nameLabel.textAlignment = configuration.textAlignment
        
        var iconImage: UIImage? = nil
        if menuName is String {
            nameLabel.text = menuName as? String
            iconImage = menuImage?.getImage()
        } else if menuName is FTPopOverMenuModel {
            nameLabel.text = (menuName as! FTPopOverMenuModel).title
            iconImage = (menuName as! FTPopOverMenuModel).image?.getImage()
            if ((menuName as! FTPopOverMenuModel).selected == true) {
                nameLabel.textColor = configuration.selectedTextColor
                self.backgroundColor = configuration.selectedCellBackgroundColor
            }
        }
        
        // Configure cell icon if available
        
        if iconImage != nil {
            if configuration.ignoreImageOriginalColor {
                iconImage = iconImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            }
            iconImageView.tintColor = configuration.textColor
            iconImageView.image = iconImage
            
            let iconImageViewW: CGFloat = configuration.menuIconSize
            let iconImageViewH: CGFloat = configuration.menuIconSize
            let iconImageViewX: CGFloat
            let iconImageViewY: CGFloat = (configuration.menuRowHeight - configuration.menuIconSize)/2
            
            if configuration.isAr {
                iconImageViewX = configuration.menuWidth - iconImageViewW - FT.DefaultCellMargin
            } else {
                iconImageViewX = FT.DefaultCellMargin
            }
            
            iconImageView.frame = CGRect(x: iconImageViewX, y: iconImageViewY, width: iconImageViewW, height: iconImageViewH)
        }
        
        let nameLabelW: CGFloat
        let nameLabelH: CGFloat
        let nameLabelX: CGFloat
        let nameLabelY: CGFloat
        
        if configuration.isAr {
            if iconImage != nil {
                nameLabelW = (configuration.menuWidth - configuration.menuIconSize - FT.DefaultCellMargin*3)
                nameLabelX = FT.DefaultCellMargin
                nameLabelY = (configuration.menuRowHeight - configuration.menuIconSize)/2
                nameLabelH = configuration.menuIconSize
            } else {
                nameLabelW = configuration.menuWidth - FT.DefaultCellMargin*2
                nameLabelX = FT.DefaultCellMargin
                nameLabelY = 0
                nameLabelH = configuration.menuRowHeight
            }
        } else {
            if iconImage != nil {
                nameLabelW = (configuration.menuWidth - configuration.menuIconSize - FT.DefaultCellMargin*3)
                nameLabelX = FT.DefaultCellMargin*2 + configuration.menuIconSize
                nameLabelY = (configuration.menuRowHeight - configuration.menuIconSize)/2
                nameLabelH = configuration.menuIconSize
            } else {
                nameLabelW = configuration.menuWidth - FT.DefaultCellMargin*2
                nameLabelX = FT.DefaultCellMargin
                nameLabelY = 0
                nameLabelH = configuration.menuRowHeight
            }
        }
        nameLabel.frame = CGRect(x: nameLabelX, y: nameLabelY, width: nameLabelW, height: nameLabelH)
    }
}
