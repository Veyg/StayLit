//
//  ContentView.swift
//  StayLit
//
//  Created by Dawid Grochowski on 12/10/2023.
//
import SwiftUI
import LaunchAtLogin

struct ContentView: View {
    @State private var autoCheckForUpdates: Bool = UserDefaults.standard.bool(forKey: "autoCheckForUpdates")

    var body: some View {
        VStack(spacing: 30) {
            Text("StayLit Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)

            GroupBox(label: HStack {
                Image(systemName: "gear")
                Text("General")
                    .fontWeight(.medium)
            }) {
                VStack(alignment: .leading, spacing: 10) {
                    Toggle(isOn: $autoCheckForUpdates) {
                        Label("Automatically Check for updates", systemImage: "arrow.triangle.2.circlepath.circle")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .padding(.vertical, 5)
                }
                .padding()
            }

            GroupBox(label: HStack {
                Image(systemName: "power")
                Text("Startup")
                    .fontWeight(.medium)
            }) {
                VStack(alignment: .leading, spacing: 10) {
                    LaunchAtLogin.Toggle()
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                        .padding(.vertical, 5)
                }
                .padding()
            }

            GroupBox(label: HStack {
                Image(systemName: "info.circle")
                Text("About")
                    .fontWeight(.medium)
            }) {
                VStack(alignment: .leading, spacing: 10) {
                    Button(action: {
                        // Open website
                        if let url = URL(string: "https://yourwebsite.com") {
                            NSWorkspace.shared.open(url)
                        }
                    }) {
                        Label("Visit Our Website", systemImage: "globe")
                    }
                    .buttonStyle(PlainButtonStyle())

                    Button(action: {
                        // Open donation link
                        if let url = URL(string: "https://yourdonationlink.com") {
                            NSWorkspace.shared.open(url)
                        }
                    }) {
                        Label("Support Me with a Donation", systemImage: "heart.fill")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.red)
                }
                .padding()
            }

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
