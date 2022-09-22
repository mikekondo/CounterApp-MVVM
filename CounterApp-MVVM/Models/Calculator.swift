//
//  Calculator.swift
//  CounterApp-MVVM
//
//  Created by 近藤米功 on 2022/09/22.
//

import Foundation

class Calculator {
    var number  = 0

    func addition() {
       number += 1
    }

    func subtraction() {
       number -= 1
    }

    func reset() {
      number = 0
    }
}
