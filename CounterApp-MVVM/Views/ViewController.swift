//
//  ViewController.swift
//  CounterApp-MVVM
//
//  Created by 近藤米功 on 2022/09/22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    // MARK: - UI Parts
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!

    private let disposeBag = DisposeBag()

    // MARK: - ViewModel Connect
    private lazy var viewModel = ViewModel(plusButtonObservable: plusButton.rx.tap.asObservable(), minusButtonObservable: minusButton.rx.tap.asObservable(), resetButtonObservable: resetButton.rx.tap.asObservable())

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupBindings()
        viewModel.countPublishSubject.subscribe(onNext: { count in
            self.numberLabel.text = String(count)
        })
        .disposed(by: disposeBag)
    }


}

