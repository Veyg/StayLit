import SwiftUI
import LaunchAtLogin

struct ContentView: View {
    @State private var autoCheckForUpdates: Bool = UserDefaults.standard.bool(forKey: "autoCheckForUpdates")

    func appVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return "Version \(version) (\(build))"
        }
        return "Unknown Version"
    }

    var body: some View {
        VStack(spacing: 30) {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)

            GroupBox(label: HStack {
                Spacer()
                Image(systemName: "gear")
                Text("General")
                    .fontWeight(.medium)
                Spacer()
            }) {
                VStack(spacing: 10) {
                    Toggle(isOn: $autoCheckForUpdates) {
                        Label("Automatically Check for updates", systemImage: "arrow.triangle.2.circlepath.circle")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
                .frame(maxWidth: .infinity)
                .padding()
            }

            GroupBox(label: HStack {
                Spacer()
                Image(systemName: "power")
                Text("Startup")
                    .fontWeight(.medium)
                Spacer()
            }) {
                VStack(spacing: 10) {
                    LaunchAtLogin.Toggle()
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
                .frame(maxWidth: .infinity)
                .padding()
            }

            GroupBox(label: HStack {
                Spacer()
                Image(systemName: "info.circle")
                Text("About")
                    .fontWeight(.medium)
                Spacer()
            }) {
                VStack(spacing: 10) {
                    Button(action: {
                        // Open website
                        if let url = URL(string: "https://veyg.me") {
                            NSWorkspace.shared.open(url)
                        }
                    }) {
                        Label("Visit My Website", systemImage: "globe")
                    }
                    .buttonStyle(PlainButtonStyle())

                    Button(action: {
                        // Open donation link
                        if let url = URL(string: "https://www.buymeacoffee.com/veyg") {
                            NSWorkspace.shared.open(url)
                        }
                    }) {
                        Label("Support Me with a Donation", systemImage: "heart.fill")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.red)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            Text(appVersion())
                .font(.footnote)
                .foregroundColor(.gray)
            Text("Developed with ❤️ by Veyg")
                .font(.caption)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding([.horizontal, .bottom])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(NSColor.windowBackgroundColor).edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
