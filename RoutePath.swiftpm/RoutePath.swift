import Foundation

protocol Route: CustomStringConvertible, RawRepresentable, Hashable, Identifiable {
  func equals<R: Route>(_ other: R) -> Bool
}
extension Route {
  func equals<R: Route>(_ other: R) -> Bool {
    if let other = other as? Self {
      return other == self
    } else {
      return other.equals(self)
    }
  }
  func erase() -> RouteStep {
    RouteStep(id)
  }
  var id: String { "\(rawValue)" }
  var description: String { id }
}

struct RouteStep: Hashable, Codable, Sendable, Identifiable {

  init(_ description: String) {
    self.description = description
  }
  var description: String
  var id: String { description }
  func erase() -> RouteStep { self }

}

struct RoutePath: Codable, Identifiable, Hashable {
  init(_ steps: (any Route)...) {
    self.steps = steps
      .map { $0.erase() }
  }

  private init(_ steps: some Sequence<RouteStep>) {
    self.steps = steps.map { $0 }
  }
  var steps: [RouteStep]

  var isEmpty: Bool {
    steps.isEmpty
  }

  var unlessEmpty: Self? {
    get {
      if isEmpty {
        return nil
      } else {
        return self
      }
    }
    set {}
  }

  var description: String { id }

  var id: String {
    steps.map(\.description).joined(separator: "->")
  }

  var head: RouteStep? {
    get {
      steps.first
    }
    set {
      steps = newValue.map { [$0] } ?? []
    }
  }

  var tail: RoutePath {
    get {
      guard !steps.isEmpty
      else { return RoutePath()}
      return RoutePath(steps[1...])
    }
    set {
      guard let first = steps.first
      else { return }
      steps = [first] + newValue.steps
    }
  }
}
