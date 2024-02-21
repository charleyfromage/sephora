import XCTest
@testable import Sephora

final class SephoraTests: XCTestCase {
    func test_itemsListPresenter_formatItems() {
        let items = [Item(id: 0, isSpecialBrand: false),
                     Item(id: 1, isSpecialBrand: true)]

        let itemsListPresenter = ItemsListPresenter()
        itemsListPresenter.itemsDidUpdate = { formattedItems in
            let expectedItems = [Item(id: 1, isSpecialBrand: true),
                                 Item(id: 0, isSpecialBrand: false)]

            XCTAssertEqual(formattedItems, expectedItems)
        }

        itemsListPresenter.formatItems(items: items)
    }
}
