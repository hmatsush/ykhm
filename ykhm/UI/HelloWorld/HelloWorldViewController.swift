import UIKit
import Foundation
import PureLayout

class HelloWorldViewController: UIViewController {

    // MARK: - Properties

    // MARK: - UI Elements
    let label = UILabel()

    // MARK: - Lifecycle Methods

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

        addSubViews()
        configureSubViews()
        applyStyles()
        addConstraints()
    }

    // MARK: - viewDidApper
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Public Methods

    // MARK: - Private Methods

    // MARK: - addSubViews()
    /// このメソッドで各UI ElementsをaddSubviewする
    fileprivate func addSubViews() {
        view.addSubview(label)
    }

    // MARK: - configureSubViews()
    /// このメソッドで各UI Elementsにテキストなどを設定する
    fileprivate func configureSubViews() {
        // NavigationControllerのテキストを設定
        title = "HelloWorld"

        label.text = "Hello World!"
    }

    // MARK: - applyStyles()
    /// このメソッドで各UI Elementsにスタイル(フォントやテキストカラー)を設定する
    fileprivate func applyStyles() {
        view.backgroundColor = UIColor.white

        label.backgroundColor = UIColor.white
        label.font = UIFont(name: "HiraKakuProN-W6", size: 20.0)
        label.textColor = UIColor.black
    }

    // MARK: - addConstraints()
    /// このメソッドで各UI ElementsにPureLayoutで制約を付ける
    fileprivate func addConstraints() {
        label.autoPinEdge(toSuperviewEdge: .top, withInset: 200.0)
        label.autoAlignAxis(.vertical, toSameAxisOf: view)
    }
}

