import Foundation
import RxSwift

public protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

public extension Optional where Wrapped: Any {
    
    var isNull: Bool {
        return self == nil
    }
    
    func value(or defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
}

public extension ObservableType where Element: OptionalType {
    func ignoreNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { .just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}

public extension OptionalType where Wrapped: ObservableType {
    
    func catchNil(_ handler: @escaping () throws -> Wrapped) rethrows -> Wrapped {
        guard let observable = self.optional else {
            return try handler()
        }
        
        return observable
    }
}
