//
//  ZZTopScrollView.swift
//  ZZPageScrollView
//
//  Created by jsw_cool on 2022/7/1.
//

import UIKit

class ZZTopScrollView: UIView,UICollectionViewDataSource,UICollectionViewDelegate{
    
    lazy var lineView:UIView = {
        return UIView.init(frame: CGRect.init(x: 0, y: 42, width: 50, height: 2))
    }()
    
    var currentSelectedIndex:Int{
        willSet{
            let width:Double = (Double)(UIScreen.main.bounds.size.width)/(Double)(self.subvcTitiles.count)
            currentSelectedIndex = newValue
            self.topScrollView.reloadData()
            UIView.animate(withDuration: 0.5) {
                self.lineView.center.x = Double(newValue)*width+width/2
            }
        }
        didSet{
//            currentSelectedIndex = newValue
        }
    }
    
//    var newCurrentSelectedIndex:Int{
//        get{
//            return currentSelectedIndex
//        }
//        set{
//            currentSelectedIndex = newValue
//        }
//    }
    
    var subvcTitiles:Array<String> = []
    var clickBlock:(Int)->Void
    lazy var topScrollView:UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Int(UIScreen.main.bounds.size.width)/subvcTitiles.count, height:44)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44), collectionViewLayout: layout)
    }()
    
    init(frame: CGRect,subvcTitles:Array<String>,click:@escaping (Int)->Void) {
        self.currentSelectedIndex = 0
        self.subvcTitiles = subvcTitles
        self.clickBlock = click
        super.init(frame: frame);
        self.setupUI()
    }
    
    func setupUI(){
        
        let width:Double = (Double)(UIScreen.main.bounds.size.width)/(Double)(self.subvcTitiles.count)
        
        self.topScrollView.register(UINib.init(nibName: "TopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopCollectionViewCellId")
        self.topScrollView.dataSource = self;
        self.topScrollView.delegate = self;
        self.addSubview(self.topScrollView)
        
        self.lineView.backgroundColor = .black
        self.lineView.center.x = width/2
        self.lineView.layer.cornerRadius = 3
        self.lineView.layer.masksToBounds = true
        self.addSubview(self.lineView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subvcTitiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:TopCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCollectionViewCellId", for: indexPath) as! TopCollectionViewCell
        cell.titleLabel.text = self.subvcTitiles[indexPath.row]
        if self.currentSelectedIndex == indexPath.row {
            cell.titleLabel.textColor = .red
        }else{
            cell.titleLabel.textColor = .black
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == self.currentSelectedIndex{
            return
        }
        self.currentSelectedIndex = indexPath.row
        self.topScrollView.reloadData()
        self.clickBlock(currentSelectedIndex)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
