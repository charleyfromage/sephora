import UIKit

typealias ItemsListViewInterface = ItemsListViewInputs & ItemsListViewOutputs

protocol ItemsListViewInputs: UIViewController {
    func updateItems(items: [Item])
}

protocol ItemsListViewOutputs: UIViewController {
    var loadData: (() -> Void)? { get set }
    var didTapItem: ((Item) -> Void)? { get set }
}

final class ItemsListViewController: UIViewController, ItemsListViewInterface {
    // MARK: Internal types
    enum State {
        case loading
        case loaded([Item])
    }

    enum Section {
        case first
    }

    // MARK: Outputs
    var loadData: (() -> Void)?
    var didTapItem: ((Item) -> Void)?

    // MARK: View logic properties
    private var state: State = .loading {
        didSet {
            switch state {
                case .loading: break
                case .loaded(let items):
                    DispatchQueue.main.async { [weak self] in
                        UIView.animate(withDuration: 0.5) { [weak self] in
                            (self?.view as? ItemsListView)?.activityIndicator.alpha = 0
                            (self?.view as? ItemsListView)?.tableView.alpha = 1
                        }
                        self?.updateDataSource(items)
                    }
            }
        }
    }

    private lazy var dataSource: UITableViewDiffableDataSource<Section, Item>? = {
        if let tableView = (view as? ItemsListView)?.tableView {
            let dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView, cellProvider: cellProvider)

            return dataSource
        }

        return nil
    }()

    // MARK: Inits
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: Life cycle
    override func loadView() {
        view = ItemsListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ItemsListView"

        (view as? ItemsListView)?.tableView.delegate = self

        loadData?()
    }

    // MARK: View logic methods
    func updateItems(items: [Item]) {
        state = .loaded(items)
    }

    private func updateDataSource(_ items: [Item]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.first])
        snapshot.appendItems(items)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    private func cellProvider(tableView: UITableView, indexPath: IndexPath, item: Item) -> UITableViewCell? {
        guard let cellIdentifier = (view as? ItemsListView)?.cellIdentifier else { return nil }

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        (cell as? ItemCell)?.configure(with: item)

        return cell
    }
}

extension ItemsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let item = dataSource?.itemIdentifier(for: indexPath) {
            didTapItem?(item)
        }
    }
}
