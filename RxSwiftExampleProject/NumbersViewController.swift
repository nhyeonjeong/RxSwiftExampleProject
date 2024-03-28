//
//  NumbersViewController.swift
//  RxSwiftExampleProject
//
//  Created by 남현정 on 2024/03/28.
//

import UIKit
import RxSwift
import RxCocoa

class NumbersViewController: UIViewController {

    var disposeBag = DisposeBag()
    @IBOutlet weak var number1: UITextField!
    @IBOutlet weak var number2: UITextField!
    
    @IBOutlet weak var number3: UITextField!
    
    @IBOutlet weak var result: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
                return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
            }
            .map { $0.description }
            .bind(to: result.rx.text)
            .disposed(by: disposeBag)
    }

}
