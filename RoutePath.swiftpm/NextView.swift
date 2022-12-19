import SwiftUI

struct NextView: View {

  enum NextRoute: String, Route, CaseIterable {
    case one = "ONE"
    case two = "TWO!"
    case three = "THREE?"
  }

  @State var localState: String
  @Binding var path: RoutePath
  @Environment(\.baseRoutePath) var pathRoot
  @Environment(\.navPath) var navPath

  var body: some View {
    Form {
      Section {
        List(NextRoute.allCases) { route in
          Button("next: \(route.rawValue)") {
            path = RoutePath(route)
          }
          .padding()
        }
      } header: {
        Label(localState, systemImage: "info.circle.fill")
      }
      Section {
        Button(role: .destructive) {
          pathRoot.wrappedValue = RoutePath()
        } label: {
          Label("reset", systemImage: "trash")
        }
      }
      Section {
        Button {
          navPath.wrappedValue.append(RoutePath(ContentView.RootRoute.one))
        } label: {
          Label("push navigation", systemImage: "compass.drawing")
        }
      }
    }
    .sheet(item: $path.head) { route in
      ContentView(localState: route.description, path: $path.tail)
    }
  }
}

struct MyView_Previews: PreviewProvider {
  static var previews: some View {
    NextView(localState: "hi", path: .constant(RoutePath(NextView.NextRoute.one)))
  }
}
