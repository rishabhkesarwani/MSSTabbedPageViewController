//
//  CollectionViewPicker.swift
//  Paged Tabs Example
//
//  Created by Rishabh Kesarwani on 25/11/16.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

import UIKit

class CollectionViewPicker: UIView {
    
    var width: CGFloat!
    var height: CGFloat!
    var grooveHeight: CGFloat!
    
    var contentView: UIView!
    
    var addresses: [Address] = [
        Address(name: "Rishabh", flatNo: "505", society: "Yucca", street: "Nahar Amrit Shakti", locality: "Chandivali", landmark: "Nahar International School", flatSize: "3 BHK"),
        Address(name: "Mukesh", flatNo: "C5116", society: "Oberoi Garden Estates", street: "Chandivali Farm Rd", locality: "Chandivali", landmark: "Chandivali Studio", flatSize: "2 BHK")
    ]
    
    var selectedAddressIndex: Int = 0
    
    var backgroundViewColor: UIColor = .clear {
        didSet {
            backgroundColor = backgroundViewColor
        }
    }
    var highlightColor = UIColor(red: 0/255.0, green: 199.0/255.0, blue: 194.0/255.0, alpha: 1) {
        didSet {
//            todayButton.setTitleColor(highlightColor, for: .normal)
        }
    }
    
    var darkColor = UIColor(red: 0, green: 22.0/255.0, blue: 39.0/255.0, alpha: 1)
    var daysBackgroundColor = UIColor(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, alpha: 1)
    
    private func configureView() {
        
        if self.contentView != nil {
            self.contentView.removeFromSuperview()
        }
        
        let screenSize = UIScreen.main.bounds.size
        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        
        // content view
        let contentHeight: CGFloat = 400
        
        contentView = UIView(frame: CGRect(x: 0, y: frame.height, width: frame.width, height: contentHeight))
        contentView.layer.shadowColor = UIColor(white: 0, alpha: 0.3).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: -1.5)
        contentView.layer.shadowRadius = 0
        contentView.layer.shadowOpacity = 0.5
        contentView.backgroundColor = .white
        contentView.isHidden = true
        contentView.backgroundColor = UIColor.darkGray
        
        addSubview(contentView)
        
        // Layout
        let layout = StepCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: 75, height: 75)
        
        // Collection View
        let collectionRect = CGRect(x: 0, y: 44, width: contentView.frame.width, height: 100)
        let collectionView = UICollectionView(frame: collectionRect, collectionViewLayout: layout)
        collectionView.backgroundColor = daysBackgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AddressCollectionViewCell.self, forCellWithReuseIdentifier: "dateCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension CollectionViewPicker: UICollectionViewDataSource, UICollectionViewDelegate {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addresses.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as! AddressCollectionViewCell
        
        let address = addresses[indexPath.item]
        cell.populateItem(address: address, highlightColor: highlightColor, darkColor: darkColor)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //workaround to center to every cell including ones near margins
        if let cell = collectionView.cellForItem(at: indexPath) {
            let offset = CGPoint(x: cell.center.x - collectionView.frame.width / 2, y: 0)
            collectionView.setContentOffset(offset, animated: true)
        }
        
        // update selected dates
        selectedAddressIndex = indexPath.item
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        alignScrollView(scrollView)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            alignScrollView(scrollView)
        }
    }
    
    func alignScrollView(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            let centerPoint = CGPoint(x: collectionView.center.x + collectionView.contentOffset.x, y: 50);
            if let indexPath = collectionView.indexPathForItem(at: centerPoint) {
                // automatically select this item and center it to the screen
                // set animated = false to avoid unwanted effects
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
                if let cell = collectionView.cellForItem(at: indexPath) {
                    let offset = CGPoint(x: cell.center.x - collectionView.frame.width / 2, y: 0)
                    collectionView.setContentOffset(offset, animated: false)
                }
                
                // update selected dates
                selectedAddressIndex = indexPath.item
            }
        } else if let tableView = scrollView as? UITableView {
//            let relativeOffset = CGPoint(x: 0, y: tableView.contentOffset.y + tableView.contentInset.top )
//            // change row from var to let.
//            let row = round(relativeOffset.y / tableView.rowHeight)
//            tableView.selectRow(at: IndexPath(row: Int(row), section: 0), animated: true, scrollPosition: .middle)
//            
//            // add 24 to hour and 60 to minute, because datasource now has buffer at top and bottom.
//            if tableView == hourTableView {
//                components.hour = Int(row - 24)%24
//            } else if tableView == minuteTableView {
//                components.minute = Int(row - 60)%60
//            }
//            
//            if let selected = calendar.date(from: components) {
//                selectedDate = selected
//            }
        }
    }
}
