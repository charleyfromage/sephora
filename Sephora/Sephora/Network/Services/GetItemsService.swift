import Foundation

protocol GetItemsService {
    func getItems() async throws -> Result<[Item], APIError>
}

final class GetItemsServiceImpl: GetItemsService {
    func getItems() async throws -> Result<[Item], APIError> {
        guard let url = URL(string: Constants.API.baseURL + Constants.API.Endpoints.items)
        else { return .failure(APIError.invalidUrl) }

        let (data, _) = try await URLSession.shared.data(from: url)

        /// We could handle HTTP status code here and return an error accordingly but I'll keep it simple

        do {
            let items = try JSONDecoder().decode([Item].self, from: data)
            return .success(items)
        } catch {
            return .failure(APIError.parsing(error))
        }
    }
}
