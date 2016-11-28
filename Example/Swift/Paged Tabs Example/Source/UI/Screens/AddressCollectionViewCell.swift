//
//  AddressCollectionViewCell.swift
//  Paged Tabs Example
//
//  Created by Rishabh Kesarwani on 25/11/16.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

import UIKit

class AddressCollectionViewCell: UICollectionViewCell {
    
    var addressName: UILabel! // rgb(128,138,147)
    var address: UILabel!
    var darkColor = UIColor(red: 0, green: 22.0/255.0, blue: 39.0/255.0, alpha: 1)
    var highlightColor = UIColor(red: 0/255.0, green: 199.0/255.0, blue: 194.0/255.0, alpha: 1)
    
    override init(frame: CGRect) {
        
        addressName = UILabel(frame: CGRect(x: 5, y: 14, width: frame.width - 10, height: 20))
        addressName.font = UIFont.systemFont(ofSize: 10)
        addressName.textAlignment = .left
        
        address = UILabel(frame: CGRect(x: 5, y: 28, width: frame.width - 10, height: 40))
        address.font = UIFont.systemFont(ofSize: 25)
        address.textAlignment = .left
        
        super.init(frame: frame)
        
        contentView.addSubview(addressName)
        contentView.addSubview(address)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            addressName.textColor = isSelected == true ? .white : darkColor.withAlphaComponent(0.5)
            address.textColor = isSelected == true ? .white : darkColor
            contentView.backgroundColor = isSelected == true ? highlightColor : .white
            contentView.layer.borderWidth = isSelected == true ? 0 : 1
        }
    }
    
    func populateItem(address: Address, highlightColor: UIColor, darkColor: UIColor) {
        self.highlightColor = highlightColor
        self.darkColor = darkColor
        
        self.addressName.text = address.getName()
        self.addressName.textColor = isSelected == true ? .white : darkColor.withAlphaComponent(0.5)
        
        self.address.text = address.get(withName: false)
        self.address.textColor = isSelected == true ? .white : darkColor
        
        contentView.layer.borderColor = darkColor.withAlphaComponent(0.2).cgColor
        contentView.backgroundColor = isSelected == true ? highlightColor : .white
    }
    
}
