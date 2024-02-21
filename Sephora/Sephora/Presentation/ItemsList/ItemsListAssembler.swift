final class ItemsListAssembler {
    static func assemble(_ view: ItemsListViewInterface, _ interactor: ItemsListInteractorInterface, _ presenter: ItemsListPresenterInterface) {
        /// View outputs
        view.loadData = interactor.loadItems

        /// Interactor outputs
        interactor.didLoadItems = presenter.formatItems

        /// Presenter outputs
        presenter.itemsDidUpdate = view.updateItems
    }
}
