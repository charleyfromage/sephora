struct Item: Hashable, Decodable {
    var id: Int
    var name: String?
    var description: String?
    var price: Double?
    var imageUrls: ImageUrls?
    var isSpecialBrand: Bool?

    private enum CodingKeys: String, CodingKey {
        case id = "product_id"
        case name = "product_name"
        case description
        case price
        case imageUrls = "images_url"
        case isSpecialBrand = "is_special_brand"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}
