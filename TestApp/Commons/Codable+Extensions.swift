import Foundation

public extension JSONDecoder {
    
    func model<T: Decodable>(with jsonDictionary: [AnyHashable: Any]) throws -> T {
        let dataJson = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
        return try JSONDecoder().decode(T.self, from: dataJson)
    }
    
    static func model<T: Decodable>(with json: Any) throws -> T {
        let dataJson = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        return try JSONDecoder().decode(T.self, from: dataJson)
    }
}

// MARK: - This extension is used to serialize the Codable entities to dictionaries.
extension Encodable {
    public var asDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension String {
    func subString(from: Int, to: Int) -> String {
        guard from != to else { return "" }
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex..<endIndex])
    }
}
