import SwiftUI

extension Binding {
  fileprivate func compact<V>() -> Binding<V>?
  where Value == V? {
    Binding<V>(self)
  }

  func replaceNil<Downstream>(default defaultValue: Downstream) -> Binding<Downstream>
  where Value == Downstream? {
    Binding<Downstream> {
      wrappedValue ?? defaultValue
    } set: { newValue in
      wrappedValue = newValue
    }
  }
}

extension Binding where Value == RoutePath {
  var maybeTail: Binding<RoutePath?> {
    get {
      self.tail.unlessEmpty
    }
    set {}
  }
  var maybeHead: Binding<RouteStep?> {
    get {
      self.head
    }
    set {}
  }

  var maybePath: Binding<RoutePath?> {
    get {
      self.unlessEmpty
    }
    set {}
  }
}
