import SwiftUI

private struct RoutePathKey: EnvironmentKey {
  static let defaultValue: Binding<RoutePath> = .constant(RoutePath())
}
extension EnvironmentValues {
  var baseRoutePath: Binding<RoutePath> {
    get { self[RoutePathKey.self] }
    set { self[RoutePathKey.self] = newValue }
  }
}

private struct NavigationPathKey: EnvironmentKey {
  static let defaultValue: Binding<NavigationPath> = .constant(NavigationPath())
}
extension EnvironmentValues {
  var navPath: Binding<NavigationPath> {
    get { self[NavigationPathKey.self] }
    set { self[NavigationPathKey.self] = newValue }
  }
}
