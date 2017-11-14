import UIKit
import Foundation
import PureLayout
import RxSwift
import RxCocoa

class RxSearchBarController: UIViewController {

    // MARK: - Properties
    let item = ["Tokyo", "Osaka", "Nagoya", "New York", "London", "Busan"]
    let disposeBag = DisposeBag()
    let dataSource = DataSource()

    var incrementalText: Driver<String> {
        return rx
            .methodInvoked(#selector(UISearchBarDelegate.searchBar(_:shouldChangeTextIn:replacementText:)))
            .debounce(0.2, scheduler: MainScheduler.instance)
            .flatMap { [weak self] _ -> Observable<String> in .just(self?.searchBar.text ?? "") }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
    }

    // MARK: - UI Elements
    let tableView = UITableView()
    let searchBar = UISearchBar()

    // MARK: - Initialize
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSearchBar()
        RegisterTableViewCell()
        addSubViews()
        configureSubViews()
        applyStyles()
        addConstraints()
    }

    // MARK: - Public Methods

    // MARK: - Private Methods
    fileprivate func configureSearchBar() {
        incrementalText
            .flatMap { [weak self] text -> Driver<[String]> in
                guard let me = self else { return .just([]) }
                return .just(me.item.filter { $0.contains(text.lowercased()) })
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    fileprivate func RegisterTableViewCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CELL")
    }

    // MARK: - addSubViews()
    /// このメソッドで各UI ElementsをaddSubviewする
    fileprivate func addSubViews() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }

    // MARK: - configureSubViews()
    /// このメソッドで各UI Elementsにテキストなどを設定する
    fileprivate func configureSubViews() {
        // NavigationControllerのテキストを設定
        title = "City Search"
        navigationItem.titleView = searchBar
        searchBar.delegate = self

        tableView.separatorStyle = .singleLine
    }

    // MARK: - applyStyles()
    /// このメソッドで各UI Elementsにスタイル(フォントやテキストカラー)を設定する
    fileprivate func applyStyles() {
        view.backgroundColor = UIColor.white

        tableView.backgroundColor = UIColor.white
    }

    // MARK: - addConstraints()
    /// このメソッドで各UI ElementsにPureLayoutで制約を付ける
    fileprivate func addConstraints() {
        tableView.autoPinEdgesToSuperviewEdges()
    }
}

extension RxSearchBarController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}

final class DataSource: NSObject, UITableViewDataSource, RxTableViewDataSourceType {

    typealias  Element = [String]

    private var items: Element = []

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.text = "\(items[indexPath.row])"
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, observedEvent: Event<Element>) {
        Binder(self) { (dataSource, items) in
            if dataSource.items == items { return }
            dataSource.items = items
            tableView.reloadData()
            }
            .on(observedEvent)
    }
}
