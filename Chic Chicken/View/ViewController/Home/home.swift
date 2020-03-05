//
//  home.swift
//  Chic Chicken
//
//  Created by Tariq on 11/18/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class home: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTitleImage()
        
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
        productsCollectionView.register(UINib.init(nibName: "productCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
    }

}
extension home: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productsCollectionView{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? productCell{
                return cell
            }
            else{
                return productCell()
            }
        }else{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as? sliderCell{
                return cell
            }
            else{
                return sliderCell()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == productsCollectionView{
            let screenWidth = collectionView.frame.width
            var width = (screenWidth-10)/2
            width = width < 130 ? 160 : width
            return CGSize.init(width: width, height: 300)
        }else{
            return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productsCollectionView{
            performSegue(withIdentifier: "details", sender: nil)
        }
    }
}
