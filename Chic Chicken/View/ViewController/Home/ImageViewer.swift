//
//  sizesGuide.swift
//  Mona
//
//  Created by Tariq on 9/15/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class ImageViewer: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var sizesImage: UIImageView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var image = [productsData]()
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onDrage(_:))))
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        imagesHandleRefresh()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc fileprivate func imagesHandleRefresh() {
        let path = IndexPath(item: index, section: 0)
        imagesCollectionView.scrollToItem(at: path, at: .centeredHorizontally, animated: false)
        self.imagesCollectionView.reloadData()
    }
    
    @objc func onDrage(_ sender:UIPanGestureRecognizer) {
        let percentThreshold:CGFloat = 0.3
        let translation = sender.translation(in: view)
        
        let newX = ensureRange(value: view.frame.minY + translation.y, minimum: 0, maximum: view.frame.maxY)
        let progress = progressAlongAxis(newX, view.bounds.width)
        
        view.frame.origin.y = newX
        
        if sender.state == .ended {
            let velocity = sender.velocity(in: view)
            if velocity.y >= 300 || progress > percentThreshold {
                _ = navigationController?.popViewController(animated: true)
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.frame.origin.y = 0
                })
            }
        }
        
        sender.setTranslation(.zero, in: view)
    }
    
    func progressAlongAxis(_ pointOnAxis: CGFloat, _ axisLength: CGFloat) -> CGFloat {
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
        let positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
        return CGFloat(positiveMovementOnAxisPercent)
    }
    
    func ensureRange<T>(value: T, minimum: T, maximum: T) -> T where T : Comparable {
        return min(max(value, minimum), maximum)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return sizesImage
    }
    
    @IBAction func close(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}
extension ImageViewer: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCell", for: indexPath) as! imagesCell
        cell.configureCell(image: image[indexPath.item].image ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.height)
    }
    
}
