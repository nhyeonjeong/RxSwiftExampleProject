//
//  SimplePickerViewController.swift
//  RxSwiftExampleProject
//
//  Created by 남현정 on 2024/03/28.
//

import UIKit
import RxSwift
import RxCocoa

class SimplePickerViewController: UIViewController {
    @IBOutlet weak var pickerView1: UIPickerView!
    
    @IBOutlet weak var pickerView3: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.just([1, 2, 3])
            .bind(to: pickerView1.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)

        
        pickerView1.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 1: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.just([1, 2, 3])
            .bind(to: pickerView2.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)", attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.cyan,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue])
            }
            .disposed(by: disposeBag)

        pickerView2.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                
                print("models selected 2: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickerView3.rx.items) { _, item, _ in
                
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)

        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { models in
                print("models selected 3: \(models)")
            })
            .disposed(by: disposeBag)
    }
}
