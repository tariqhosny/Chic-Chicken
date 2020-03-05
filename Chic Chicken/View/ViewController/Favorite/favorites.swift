//
//  favorites.swift
//  Chic Chicken
//
//  Created by Tariq on 11/20/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class favorites: UIViewController {

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
        favoriteCollectionView.register(UINib.init(nibName: "productCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        // Do any additional setup after loading the view.
    }

}
extension favorites: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! productCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "mealDetails")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.width
        var width = (screenWidth-5)/2
        width = width < 130 ? 160 : width
        return CGSize.init(width: width, height: 300)
    }
}
