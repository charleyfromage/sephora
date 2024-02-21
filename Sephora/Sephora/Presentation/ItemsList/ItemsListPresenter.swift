typealias ItemsListPresenterInterface = ItemsListPresenterInputs & ItemsListPresenterOutputs

protocol ItemsListPresenterInputs: AnyObject {
    func formatItems(items: [Item])
}

protocol ItemsListPresenterOutputs: AnyObject {
    var itemsDidUpdate: (([Item]) -> Void)? { get set }
}

final class ItemsListPresenter: ItemsListPresenterInterface {
    // MARK: Outputs
    var itemsDidUpdate: (([Item]) -> Void)?

    // MARK: Logic methods
    func formatItems(items: [Item]) {
        let formattedItems = items.sorted { ($0.isSpecialBrand ?? false) && !($1.isSpecialBrand ?? false) }

        itemsDidUpdate?(formattedItems)
    }
}
