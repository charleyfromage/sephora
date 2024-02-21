typealias ItemsListInteractorInterface = ItemsListInteractorInputs & ItemsListInteractorOutputs

protocol ItemsListInteractorInputs: AnyObject {
    func loadItems()
}

protocol ItemsListInteractorOutputs: AnyObject {
    var didLoadItems: (([Item]) -> Void)? { get set }
}

final class ItemsListInteractor: ItemsListInteractorInterface {
    // MARK: Outputs
    var didLoadItems: (([Item]) -> Void)?

    // MARK: Logic properties
    private let service: GetItemsService

    // MARK: Inits
    init(service: GetItemsService) {
        self.service = service
    }

    // MARK: Logic methods
    func loadItems() {
        Task {
            let result = try await service.getItems()

            switch result {
                case .success(let items):
                    didLoadItems?(items)
                case .failure:
                    /// Error should be handled obviously. We could call another output.
                    break
            }
        }
    }
}
