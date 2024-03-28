//
//  SimpleTableViewExampleViewController.swift
//  RxSwiftExampleProject
//
//  Created by 남현정 on 2024/03/28.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleTableViewExampleViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )

        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)

        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                
                DefaultWireframe.presentAlert("Tapped \(value)")
            })
            .disposed(by: disposeBag)

        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                
                DefaultWireframe.presentAlert("Tapped Detal @\(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)


    }
    

}
