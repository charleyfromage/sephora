enum APIError: Error {
    case invalidUrl
    case network(Int)
    case server(Int)
    case parsing(Error)
    case encoding
    case unknown
}
