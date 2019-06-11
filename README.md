# SwiftBLoC

A [BLoC (Business Logic Component)](https://medium.com/flutterpub/architecting-your-flutter-project-bd04e144a8f1) implementation for SwiftUI.

## Example

```swift
class Counter: BLoCModel {
    enum Event {
        case increment
        case decrement
        case random
        case set(to: Int?)
    }

    var data = 0

    func eventHander(_ event: Counter.Event) {
        switch event {
        case .increment:
            data += 1
        case .decrement:
            data -= 1
        case .random:
            data = Int.random(in: -100 ... 100)
        case let .set(to: value):
            guard let value = value else { return }
            data = value
        }
    }
}

struct ContentView: View {
    @ObjectBinding var bloc = BLoC(initialValue: Counter())

    var body: some View {
        VStack {
            Text(bloc.value.data.description)
                .fontWeight(.black)
                .font(Font.system(size: 120))
                .animation(nil)
            HStack {
                Button(action: bloc.action(.decrement)) {
                    Image(systemName: "minus.circle")
                }
                Button(action: bloc.action(.random)) {
                    Image(systemName: "number.circle.fill")
                }
                Button(action: bloc.action(.increment)) {
                    Image(systemName: "plus.circle")
                }
            }
        }
        .font(.largeTitle)
    }
}
```
