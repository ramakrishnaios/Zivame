//
//  ProdcutListViewController.swift
//  ZivameTask
//
//  Created by ram krishna on 01/05/22.
//

import UIKit
import SDWebImage
class ProdcutListViewController: UIViewController {

    @IBOutlet weak var tblProductList: UITableView!
    var VMProductList : ProductListViewModel!
    private var dataSource : ProductListTableViewDataSource<ProductDetailTableViewCell,Products,Products,Products,ProdcutListViewController>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerProductCell()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.UIUpdateWithData()
    }
    
    func registerProductCell() {
        self.tblProductList.rowHeight = UITableView.automaticDimension
        self.tblProductList.estimatedRowHeight = 150
        let productCellNib = UINib.init(nibName: "ProductDetailTableViewCell", bundle: nil)
        self.tblProductList.register(productCellNib, forCellReuseIdentifier: "ProductDetailTableViewCell")
    }
    
    func UIUpdateWithData(){
        self.VMProductList =  ProductListViewModel()
        self.VMProductList.bindProductsData = { [weak self] in
            self?.updateDataSource()
        }
    }
    
    func updateDataSource(){
        self.dataSource = ProductListTableViewDataSource(cellIdentifier: "ProductDetailTableViewCell", items: self.VMProductList.prodcutListData?.products, priceLessThan1000: self.VMProductList.productsLessThan1000, priceGreaterThan1000: self.VMProductList.productsMoreThan1000, viewcontroller: self, configureCell: {(cell,lessthan1000,morethan1000, indexpath)  in
            cell.lblProductName.numberOfLines = 0
            if indexpath.section == 0 {
            cell.lblProductName.text = lessthan1000?.name ?? ""
                cell.imgProductThumbnai.sd_setImage(with: URL.init(string: lessthan1000?.image_url ?? ""), placeholderImage: UIImage(named: "default_product"))
                cell.lblProductRating.text = "Rating \(lessthan1000?.rating ?? 0)"
                cell.lblProductPrice.text = "Rs: \(lessthan1000?.price ?? "")"
            }
            else {
                cell.lblProductName.text = morethan1000?.name ?? ""
                    cell.imgProductThumbnai.sd_setImage(with: URL.init(string: morethan1000?.image_url ?? ""), placeholderImage: UIImage())
                    cell.lblProductRating.text = "Rating \(morethan1000?.rating ?? 0)"
                    cell.lblProductPrice.text = "Rs: \(morethan1000?.price ?? "")"
                }
            cell.lblProductName.lineBreakMode = .byWordWrapping
            cell.lblProductName.sizeToFit()
            cell.lblProductName.layoutIfNeeded()
            
        })
        
        DispatchQueue.main.async {
            self.tblProductList.dataSource = self.dataSource
            self.tblProductList.delegate = self.dataSource
            self.tblProductList.reloadData()
        }
    }

}

