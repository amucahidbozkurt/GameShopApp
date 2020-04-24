//
//  ProductsListViewController.swift
//  GameShop
//
//  Created by Ahmet Mücahid BOZKURT on 24.02.2020.
//  Copyright © 2020 Ahmet Mucahid BOZKURT. All rights reserved.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    let repository = Repository(apiClient: APIClient())
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var products: [ProductsData]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        repository.getProductsData { (result) in
            switch result {
            case .success(let items):
                self.products = items
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                 }
            case .failure(let error):
                print("\(self) retrive error on get Photos: \(error)")
            }
            
        }

    }

}

extension ProductsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let array = self.products {
            return array.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProductCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 5.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        if let array = self.products {
            let item = array[indexPath.row]
            cell.productImage.downloaded(from: item.imageUrl)
            cell.developerLabel.text = item.developer
            cell.productName.text = item.name
            cell.priceLabel.text = item.price
            cell.discountPriceLabel.text = item.discountPrice
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let array = self.products {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            detailVC.model = array[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
