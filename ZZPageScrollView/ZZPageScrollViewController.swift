//
//  ZZPageScrollViewController.swift
//  ZZPageScrollView
//
//  Created by jsw_cool on 2022/7/1.
//

import UIKit

class ZZPageScrollViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate{

    var currentSelectedIndex:Int
    var subvcTitiles:Array<String> = []
    var subvc:Array<UIViewController> = []
    
    lazy var contentScrollView:UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Int(UIScreen.main.bounds.size.width), height:Int(UIScreen.main.bounds.size.height)-132)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return UICollectionView.init(frame: CGRect.init(x: 0, y: 132, width: Int(UIScreen.main.bounds.size.width), height:Int(UIScreen.main.bounds.size.height)-132), collectionViewLayout: layout)
    }()
    
    lazy var topView:ZZTopScrollView = {
        return ZZTopScrollView.init(frame: CGRect.init(x: 0, y: 88, width: UIScreen.main.bounds.size.width, height: 44), subvcTitles: self.subvcTitiles) { currentIndex in
            self.contentScrollView.contentOffset = CGPoint.init(x: currentIndex*Int((UIScreen.main.bounds.size.width)), y: 0)
        }
    }()
    
    required init(subvcTitiles:Array<String>) {
        let a:BViewController = BViewController();
        let b:CViewController = CViewController();
        let c:DViewController = DViewController();
        self.subvc  = [a,b,c]
        self.currentSelectedIndex = 0
        self.subvcTitiles = subvcTitiles
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
        self.view.addSubview(self.topView)
        self.contentScrollView.register(UINib.init(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ContentCollectionViewCellId")
        self.contentScrollView.dataSource = self;
        self.contentScrollView.delegate = self;
        self.contentScrollView.isPagingEnabled = true;
        self.contentScrollView.contentSize = CGSize.init(width: Int(UIScreen.main.bounds.size.width)*3, height: Int(UIScreen.main.bounds.size.height)-132);
        self.view.addSubview(self.contentScrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subvcTitiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ContentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCellId", for: indexPath) as! ContentCollectionViewCell
        let vc = self.subvc[indexPath.row];
        cell.contentView.addSubview(vc.view)
        return cell;
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex:Int = Int(scrollView.contentOffset.x/UIScreen.main.bounds.size.width)
        self.topView.currentSelectedIndex = currentIndex;
    }
        
    deinit {
        print("123")
    }
    
}
