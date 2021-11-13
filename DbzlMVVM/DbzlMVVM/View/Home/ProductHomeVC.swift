//
//  ProductHomeVC.swift
//  DbzlMVVM
//
//  Created by Atif on 12/11/2021.
//

import UIKit
import SwiftyProgressHud

class ProductHomeVC: BaseVC {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var hud: SwiftyProgressHud!
    
    // MARK: - Injection
    let viewModel = ItemViewModel(Service())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup() {
        ProductTableViewCell.registerCellXib(with: tableView)
        hud = SwiftyProgressHud()
        fetchViewData()
    }
    
    // MARK: - Networking
    private func fetchViewData() {
        activityIndicatorStart()
        viewModel.fetchDataFromApi()
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                print(error.localizedDescription)
            }
        }
        viewModel.didFinishFetch = {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - UI Setup
    private func activityIndicatorStart() {
        hud.show(view: self.view)
    }
    private func activityIndicatorStop() {
        hud.hide()
    }
}

extension ProductHomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.itemList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.stringFromClass) as! ProductTableViewCell
        cell.configure(with: viewModel.itemList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.itemList[indexPath.row]
        let vc: ProductDetailVC = ProductDetailVC(nibName: "ProductDetailVC", bundle: nil)
        //TODO: Update models
        vc.productTitle = item.productTitle
        vc.productPrice = "\(item.productPrice.label)\(item.productPrice.value)"
        vc.productDate =  "\(item.productDate.label)\(item.productDate.value)"
        let media_array = item.image_urls_thumbnails ?? []
        if (media_array.count > 0) {
            let url = media_array[0]
            vc.productImageUrl = url
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
