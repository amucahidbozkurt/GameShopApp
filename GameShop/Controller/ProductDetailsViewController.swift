//
//  ProductDetailsViewController.swift
//  GameShop
//
//  Created by Ahmet Mücahid BOZKURT on 24.02.2020.
//  Copyright © 2020 Ahmet Mucahid BOZKURT. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var productDetailsViewProductImage: UIImageView!
    @IBOutlet weak var productDetailsViewDeveloperLabel: UILabel!
    @IBOutlet weak var productDetailsViewProductName: UILabel!
    @IBOutlet weak var productDetailsViewPriceLabel: UILabel!
    @IBOutlet weak var productDetailsViewDiscountPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productsTitleLabel: UILabel!
    
    var model: ProductsData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        productsTitleLabel.layer.masksToBounds = true
        productsTitleLabel.layer.cornerRadius = 3.0
        //productsTitleLabel.layer.borderWidth = 3.0
        //productsTitleLabel.layer.borderColor = UIColor.blue.cgColor
        
        if let model = model {
            productDetailsViewProductImage.downloaded(from: model.imageUrl)
            productDetailsViewDeveloperLabel.text = model.developer
            productDetailsViewProductName.text = model.name
            productDetailsViewPriceLabel.text = model.price
            productDetailsViewDiscountPriceLabel.text = model.discountPrice
        }
        
    }
        
}

extension ProductDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = self.model?.Platforms {
            return array.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTable", for: indexPath) as! PlatformsTableViewCell
        
        if let array = self.model?.Platforms {
            let item = array[indexPath.row]
            cell.platformsLabel.text = item.name
            cell.numberOfSalesLabel.text = String(item.NumberOfSales)
            
            /* if item.name == "PC" {
                cell.layer.backgroundColor = UIColor.blue.cgColor
            }*/
            
        }
        return cell
    }
    
}
