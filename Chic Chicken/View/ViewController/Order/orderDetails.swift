//
//  orderDetails.swift
//  Chic Chicken
//
//  Created by Tariq on 11/24/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class orderDetails: UIViewController {

    @IBOutlet weak var mealsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

}
extension orderDetails: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderDetailsCell", for: indexPath) as! orderDetailsCell
        return cell
    }
    
    
}
