//
//  CartViewController.swift
//  ZivameTask
//
//  Created by ram krishna on 01/05/22.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet var viewEmptyCartBG: UIView!
    @IBOutlet weak var tblCartItems: UITableView!
    var VMCartItems : CartViewModel!
    private var dataSource : CartItemsDataSource<ProductDetailTableViewCell,CartItems,UIView>!

    @IBOutlet weak var viewCheckout: UIView!
    @IBOutlet weak var constrBottom: NSLayoutConstraint!
    @IBOutlet weak var lblTotalValue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerProductCell()
        UIUpdateWithData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.VMCartItems.fetchCartItems()
        updateCheckoutview()
    }
    
    func registerProductCell() {
        self.tblCartItems.backgroundView = viewEmptyCartBG
        self.tblCartItems.rowHeight = UITableView.automaticDimension
        self.tblCartItems.estimatedRowHeight = 150
        let productCellNib = UINib.init(nibName: "ProductDetailTableViewCell", bundle: nil)
        self.tblCartItems.register(productCellNib, forCellReuseIdentifier: "ProductDetailTableViewCell")
    }
    
    func UIUpdateWithData(){
        self.VMCartItems =  CartViewModel()
        self.VMCartItems.bindCartItemsData = { [weak self] in
            self?.updateDataSource()
        }
        self.VMCartItems.bindTotalCartValue = { [weak self] in
            self?.updateCartValue()
        }
    }
    
    func updateCheckoutview(){
        if self.VMCartItems.cartItems?.count ?? 0 > 0 {
            constrBottom.constant = 127
        }
        else{
            constrBottom.constant = 0
        }
    }
    
    func updateCartValue(){
        self.lblTotalValue.text = "Total Amount: \(self.VMCartItems.totalCartValue ?? 0)"
    }
    
    func updateDataSource(){
        self.dataSource = CartItemsDataSource(cellIdentifier: "ProductDetailTableViewCell", items: self.VMCartItems?.cartItems, tableBGView: self.viewEmptyCartBG, configureCell: {(cell, cartItem)  in
            cell.lblProductName.numberOfLines = 0
            cell.lblProductName.text = cartItem?.productName ?? ""
            cell.imgProductThumbnai.sd_setImage(with: URL.init(string: cartItem?.productImagePath ?? ""), placeholderImage: UIImage())
            cell.lblProductRating.text = "Rating \(cartItem?.productRating ?? 0)"
            cell.lblProductPrice.text = "Rs: \(cartItem?.productPrice ?? "")"
            cell.lblProductName.lineBreakMode = .byWordWrapping
            cell.lblProductName.sizeToFit()
            cell.lblProductName.layoutIfNeeded()
            
        })
        
        DispatchQueue.main.async {
            self.tblCartItems.dataSource = self.dataSource
            self.tblCartItems.delegate = self.dataSource
            self.tblCartItems.reloadData()
        }
    }
    
    
    @IBAction func checkOutAction(_ sender: Any) {
        let animatedVCXib = AnimatedChildViewController.init(nibName: "AnimatedChildViewController", bundle: nil)
        self.add(animatedVCXib,frame: self.view.bounds)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.VMCartItems.removeCartItems()
            self.updateCheckoutview()
            self.remove()
        }
    }
    
}


