//
//  TopTabBarView.swift
//  FifTube
//
//  Created by Poing on 1/20/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class TopTabBarView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let barMenuCellId = "homeTopMenuCell"
    
    let nibTopTabCell = UINib(nibName: "TopTabBarCell", bundle: nil)
    
    //let barMenuItemLabels = ["All Videos", "Recent Views"]
    
    var parent: TopBarParent? = nil
    var isUnderBarHidden: Bool = false
    
    //Collection view for menu buttons
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        //Create subview (collection) for the menu buttons
        //Register cell's XIB and class
        cv.register(nibTopTabCell, forCellWithReuseIdentifier: barMenuCellId)
        //Set subview BG color
        cv.backgroundColor = UIColor.white
        cv.contentInsetAdjustmentBehavior = .never
        
        return cv
    }()
    

    


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //collectionView.register(TopTabBarCell.self, forCellWithReuseIdentifier: barMenuCellId)
        
        //Add subview
        self.addSubview(collectionView)
        
        //Set subview constraints
        self.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        self.addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(parent: UIView, navBar: UIView, isUseUnderBar: Bool = true) {
        
        
        self.isUnderBarHidden = !isUseUnderBar
        
        //self.parent = parent as! TopBarParent
        //Add self as parent's subview
        parent.addSubview(self)
        
        //Setup self constraints in the parent
        parent.addConstraintsWithFormat("H:|[v0]|", views: self)
        parent.addConstraintsWithFormat("V:|-[v0(50)]", views: self)
        
        //Set view's BG color
        backgroundColor = UIColor.white
        
        let selectedPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedPath, animated: false, scrollPosition: .centeredVertically)
        
        
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        parent?.scrollToItem(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (parent?.categories.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: barMenuCellId, for: indexPath) as! TopTabBarCell
        cell.setupCell(title: (parent?.categories[indexPath.item])!)
        
        return cell
    }
    
    // MARK: extension UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        //let paddingSpace = CGFloat( 10 )
        let cellWidth = frame.width / CGFloat( (parent?.categories.count)!)
        let cellHeight = frame.height
        
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}




