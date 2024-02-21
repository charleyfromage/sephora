import UIKit
import Kingfisher

final class ItemDetailsViewController: UIViewController {
    // MARK: Internal types
    enum State {
        case loading
        case loaded
    }

    // MARK: Logic properties
    private var state: State = .loading {
        didSet {
            switch state {
                case .loading: break
                case .loaded:
                    DispatchQueue.main.async { [weak self] in
                        UIView.animate(withDuration: 0.5) { [weak self] in
                            (self?.view as? ItemDetailsView)?.activityIndicator.alpha = 0
                            (self?.view as? ItemDetailsView)?.imageView.alpha = 1
                        }
                    }
            }
        }
    }

    private let imageUrlString: String

    // MARK: Inits
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(imageUrlString: String) {
        self.imageUrlString = imageUrlString

        super.init(nibName: nil, bundle: nil)
    }

    // MARK: Life cycle
    override func loadView() {
        view = ItemDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ItemDetailsView"

        if let imageUrl = URL(string: imageUrlString) {
            (view as? ItemDetailsView)?.imageView.kf.setImage(with: imageUrl) { [weak self] _ in
                self?.state = .loaded
            }
        }
    }
}
