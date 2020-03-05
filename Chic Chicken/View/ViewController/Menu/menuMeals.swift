//
//  menuMeals.swift
//  Chic Chicken
//
//  Created by Tariq on 11/18/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class menuMeals: UIViewController {

    @IBOutlet weak var mealsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        
        mealsCollectionView.delegate = self
        mealsCollectionView.dataSource = self
        
        mealsCollectionView.register(UINib.init(nibName: "productCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        // Do any additional setup after loading the view.
    }
    

}
extension menuMeals: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? productCell{
            return cell
        }
        else{
            return productCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "mealDetails")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = collectionView.frame.width
        var width = (screenWidth-10)/2
        width = width < 130 ? 160 : width
        return CGSize.init(width: width, height: 300)
    }
    
    
}
