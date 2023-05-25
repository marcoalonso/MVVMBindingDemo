//
//  ViewController.swift
//  MVVMBindingDemo
//
//  Created by Marco Alonso Rodriguez on 25/05/23.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var usersTableView: UITableView!
    
    var viewModel = UsersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTableView.dataSource = self
        usersTableView.delegate = self
        
        ///* Prepara para escuchar cambios en el viewModel
        bindViewModel()
        
        getUsers()
    }
    
    ///Que es lo que hará una vez que el vm tenga los datos
    func bindViewModel(){
        viewModel.users.bind { [weak self] users in
            print("Users: \(users?.count ?? 0)")
            DispatchQueue.main.async {
                self?.usersTableView.reloadData()
            }
        }
    }
    
    func getUsers(){
        viewModel.fetchUsers()
    }
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = viewModel.users.value?[indexPath.row].name
        cell.detailTextLabel?.text = viewModel.users.value?[indexPath.row].email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        vc.userDetailViewModel = viewModel.users.value?[indexPath.row]
        self.present(vc, animated: true)
    }
    
    
}

