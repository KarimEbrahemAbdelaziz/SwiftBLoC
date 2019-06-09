import Combine
import SwiftUI

public protocol BLoCModel {
    associatedtype Data
    associatedtype Event

    var data: Data { get }
    mutating func eventHander(_ event: Event)
}

@propertyDelegate
public class BLoC<Model: BLoCModel>: BindableObject {
    public var value: Model {
        didSet {
            didChange.send(())
        }
    }

    public var didChange = PassthroughSubject<Void, Never>()

    public init(initialValue value: Model) {
        self.value = value
    }

    public func send(_ event: Model.Event) {
        value.eventHander(event)
    }

    public func action(_ event: Model.Event) -> (() -> Void) {
        return {
            self.send(event)
        }
    }
}
