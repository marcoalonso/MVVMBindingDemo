//
//  UsersViewModel.swift
//  MVVMBindingDemo
//
//  Created by Marco Alonso Rodriguez on 25/05/23.
//

import Foundation

class UsersViewModel {
    /// * Al ser del tipo Observable, podrá trigerear o actualizar alguna vista cuando este valor cambie
    var users: Observable<[TableCellViewModel]> = Observable([])
    
    func fetchUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let userModels = try JSONDecoder().decode([UserModel].self, from: data)
                
                self.users.value = userModels.compactMap({
                    ///Vamos a convertir en otro tipo
                    TableCellViewModel(name: $0.name, email: $0.email)
                })
            } catch {
                print("Debug: error \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
