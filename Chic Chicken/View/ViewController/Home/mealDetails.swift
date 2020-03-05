//
//  mealDetails.swift
//  Chic Chicken
//
//  Created by Tariq on 11/19/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class mealDetails: UIViewController {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var includesTableView: UITableView!
    @IBOutlet weak var mealDescription: UILabel!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    var tableheight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTitleImage()
        includesHandleRefresh()
        
        includesTableView.delegate = self
        includesTableView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    
    func includesHandleRefresh(){
        includesTableView.reloadData()
        self.tableheight = 5 * 120
        self.viewHeight.constant = self.tableheight + self.mealDescription.frame.size.height + (self.mealDescription.frame.size.height * 0.2) + 410
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

}
extension mealDetails: UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "includesCell", for: indexPath) as! includesCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! imageCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
}
