import SwiftUI

struct HostView: View {
  
  
  @State var path: RoutePath = RoutePath()

  // TODO: Note
  // Not quite sure how one would best merge these.
  // (not that we can use this API anyway.)
  @State var navigationPath: NavigationPath = .init()
  
  var body: some View {
    NavigationStack(path: $navigationPath) {
      ContentView(localState: "Root", path: $path)
        .navigationDestination(for: RoutePath.self) { path in

          // TODO: az understand
          // This always pushes *under* any presented sheets
          // — possibly because of this being so far down
          // in the view hierarchy?

          var path = path
          ContentView(
            localState: "New path state",
            path: Binding(get: { path }, set: { path = $0 })
          )
        }
    }
    .onChange(of: path) { newValue in
      print(path.description)
    }
    // This turns out to not be stable enough to use :(
    // We would need some sort of repeated-pop behavior to allow
    // resetting like this.
    // (it's also possible that passing the binding is triggering the jank. idk.)
    .environment(\.baseRoutePath, $path)
    .environment(\.navPath, $navigationPath)
    
  }
}

struct HostView_Previews: PreviewProvider {
  static var previews: some View {
    HostView()
  }
}
