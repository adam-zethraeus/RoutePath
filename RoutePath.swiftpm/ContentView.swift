import SwiftUI

struct ContentView: View {

  enum RootRoute: String, Route, CaseIterable {
    case one
    case two
    case three
  }

  @State var localState: String
  @Binding var path: RoutePath
  @Environment(\.baseRoutePath) var baseRootPath
  @Environment(\.navPath) var navPath

  var body: some View {
    Form {
      Section {
        List(RootRoute.allCases) { route in
          Button("next: \(route.rawValue)") {
            path = RoutePath(route)
          }
          .padding()
        }
      } header: {
        Label(localState, systemImage: "info.circle.fill")
      }
      Section {
        Button("do lots") {
          path = RoutePath(
            RootRoute.one,
            NextView.NextRoute.two,
            RootRoute.three,
            NextView.NextRoute.three,
            RootRoute.one
          )
        }
      }
      Section {
        Button(role: .destructive) {
          baseRootPath.wrappedValue = RoutePath()
        } label: {
          Label("reset", systemImage: "trash")
        }
      }
    }
    .sheet(item: $path.head) { route in
      NextView(localState: route.description, path: $path.tail)
    }
  }
}
