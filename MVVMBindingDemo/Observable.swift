//
//  Observable.swift
//  MVVMBindingDemo
//
//  Created by Marco Alonso Rodriguez on 25/05/23.
//

import Foundation

class Observable<T> {
    
    var value: T? {
        ///* Cada que cambia este valor se lo informaremos al listener, ademas que puede que el cambio sea en hilo secundario
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init( _ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind( _ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
