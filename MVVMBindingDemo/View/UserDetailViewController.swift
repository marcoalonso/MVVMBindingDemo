//
//  UserDetailViewController.swift
//  MVVMBindingDemo
//
//  Created by Marco Alonso Rodriguez on 25/05/23.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var userDetailViewModel: TableCellViewModel?
    
    @IBOutlet weak var emailUser: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI(){
        guard let userDetailViewModel = userDetailViewModel else { return }
        nameUser.text = userDetailViewModel.name
        emailUser.text = userDetailViewModel.email
    }

}
