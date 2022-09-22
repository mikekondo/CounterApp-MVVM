//
//  ViewModel.swift
//  CounterApp-MVVM
//
//  Created by 近藤米功 on 2022/09/22.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

// MARK: Protocol Inputs
protocol ViewModelInputs {
    var plusButtonObservable: Observable<Void> { get }
    var minusButtonObservable: Observable<Void> { get }
    var resetButtonObservable: Observable<Void> { get }
}

// MARK: Protocol Outputs
protocol ViewModelOutputs {
    var countPublishRelay: PublishRelay<Int> { get }
}

class ViewModel: ViewModelInputs,ViewModelOutputs {
    // MARK: - Inputs
    var plusButtonObservable: Observable<Void>
    var minusButtonObservable: Observable<Void>
    var resetButtonObservable: Observable<Void>

    // MARK: Outputs
    var countPublishRelay = PublishRelay<Int>()

    // MARK: Model Connect
    var calculator = Calculator()

    private let disposeBag = DisposeBag()

    // MARK: Init
    init(plusButtonObservable: Observable<Void>,
         minusButtonObservable: Observable<Void>,
         resetButtonObservable: Observable<Void>){
        self.plusButtonObservable = plusButtonObservable
        self.minusButtonObservable = minusButtonObservable
        self.resetButtonObservable = resetButtonObservable
    }

    // MARK: SetupBindings
    func setupBindings() {
        plusButtonObservable.subscribe(onNext: {
            [weak self] in
            self?.calculator.addition()
            self?.countPublishRelay.accept(self?.calculator.number ?? 0)
        })
        .disposed(by: disposeBag)

        minusButtonObservable.subscribe(onNext: {
            [weak self] in
            self?.calculator.subtraction()
            self?.countPublishRelay.accept(self?.calculator.number ?? 0)
        })
        .disposed(by: disposeBag)

        resetButtonObservable.subscribe(onNext: {
            [weak self] in
            self?.calculator.reset()
            self?.countPublishRelay.accept(self?.calculator.number ?? 0)
        })
        .disposed(by: disposeBag)
    }


}
