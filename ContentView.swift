
import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var jailbroken = false
    @State private var running = false
    @State private var progress = 0.0
    @State private var installed: Set<String> = []
    
    @State private var logs = [
        "[C00K13] Initialised",
        "[INFO] Device detected",
        "[INFO] iPadOS 27.2",
        "[INFO] Ready"
    ]
    
    private let accent = Color(
        red: 0.67,
        green: 0.43,
        blue: 1.0
    )
    
    private let background = Color(
        red: 0.035,
        green: 0.035,
        blue: 0.045
    )
    
    var body: some View {
        ZStack {
            background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                
                Divider()
                    .overlay(.white.opacity(0.12))
                
                Group {
                    switch selectedTab {
                    case 0:
                        home
                    case 1:
                        packages
                    default:
                        settings
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                navigation
            }
            .padding(.horizontal, 17)
        }
        .preferredColorScheme(.dark)
    }
    
    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("C00k13")
                    .font(.system(size: 27, weight: .bold))
                
                Text("JAILBREAK UTILITY")
                    .font(.system(size: 9, weight: .medium, design: .monospaced))
                    .tracking(2)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Text("v1.0.0")
                .font(.system(size: 11, design: .monospaced))
                .foregroundStyle(accent)
        }
        .padding(.vertical, 18)
    }
    
    private var home: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 19) {
                HStack(spacing: 8) {
                    Circle()
                        .fill(jailbroken ? .green : .orange)
                        .frame(width: 7, height: 7)
                    
                    Text(jailbroken ? "JAILBROKEN" : "NOT JAILBROKEN")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                    
                    Spacer()
                    
                    Text("READY")
                        .font(.system(size: 9, design: .monospaced))
                        .foregroundStyle(.gray)
                }
                .padding(.vertical, 13)
                
                VStack(spacing: 15) {
                    Image(systemName: jailbroken
                          ? "checkmark.shield.fill"
                          : "bolt.fill")
                    .font(.system(size: 43))
                    .foregroundStyle(jailbroken ? .green : accent)
                    
                    Text(jailbroken ? "Jailbroken" : "C00k13")
                        .font(.system(size: 25, weight: .bold))
                    
                    Text(jailbroken
                         ? "Process completed successfully."
                         : "Ready to start.")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(.gray)
                    
                    if running {
                        ProgressView(value: progress)
                            .tint(accent)
                        
                        Text("PROCESSING \(Int(progress * 100))%")
                            .font(.system(size: 10, design: .monospaced))
                            .foregroundStyle(accent)
                    }
                    
                    Button(action: startJailbreak) {
                        HStack {
                            Image(systemName: jailbroken ? "checkmark" : "bolt.fill")
                            
                            Text(
                                jailbroken ? "JAILBROKEN" :
                                    running ? "PLEASE WAIT..." :
                                    "JAILBREAK"
                            )
                        }
                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                        .tracking(1)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(jailbroken ? Color.green.opacity(0.2) : accent)
                        .foregroundStyle(.white)
                    }
                    .disabled(jailbroken || running)
                }
                .padding(.vertical, 25)
                
                Divider()
                    .overlay(.white.opacity(0.15))
                
                section("DEVICE INFORMATION")
                
                detail("Device", "iPad")
                detail("System", "iPadOS 27.2")
                detail("Architecture", "ARM64")
                detail("Environment", "Local")
                
                Divider()
                    .overlay(.white.opacity(0.15))
                
                section("PROCESS LOG")
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(Array(logs.enumerated()), id: \.offset) { _, log in
                        Text(log)
                            .font(.system(size: 10, design: .monospaced))
                            .foregroundStyle(log.contains("ERROR") ? .red : .gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(12)
                .background(.white.opacity(0.035))
                
                Text("C00K13 INTERFACE")
                    .font(.system(size: 9, design: .monospaced))
                    .foregroundStyle(.gray)
            }
            .padding(.bottom, 25)
        }
    }
    
    private var packages: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 17) {
                section("PACKAGE MANAGER")
                
                Text("Packages")
                    .font(.system(size: 24, weight: .bold))
                
                Text("PACKAGE DATABASE")
                    .font(.system(size: 9, design: .monospaced))
                    .foregroundStyle(.gray)
                
                packageRow("PreferenceLoader", "2.2.6", "Preference bundle loader")
                packageRow("RocketBootstrap", "1.0.10", "Inter-process communication")
                packageRow("NewTerm 3", "3.0.2", "Terminal emulator")
                packageRow("SnowBoard", "1.5.31", "Theme manager")
                packageRow("Filza", "4.0.1", "File manager")
                
                Divider()
                    .overlay(.white.opacity(0.15))
                
                Text("Package actions are simulated.")
                    .font(.system(size: 10, design: .monospaced))
                    .foregroundStyle(.gray)
            }
            .padding(.top, 20)
            .padding(.bottom, 25)
        }
    }
    
    private var settings: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 19) {
                section("SETTINGS")
                
                Text("Configuration")
                    .font(.system(size: 24, weight: .bold))
                
                detail("Application", "C00k13")
                detail("Version", "1.0.0")
                detail("Interface", "Dark")
                detail("Accent", "Purple")
                detail("Mode", "Local")
                
                Divider()
                    .overlay(.white.opacity(0.15))
                
                section("ABOUT")
                
                Text("C00k13 Jailbreak Utility")
                    .font(.system(size: 13, weight: .semibold))
                
                Text("An experimental jailbreak-style interface built with SwiftUI.")
                    .font(.system(size: 11))
                    .foregroundStyle(.gray)
                
                Text("No system modifications are performed.")
                    .font(.system(size: 10, design: .monospaced))
                    .foregroundStyle(.gray)
            }
            .padding(.top, 20)
        }
    }
    
    private var navigation: some View {
        HStack {
            navigationButton("bolt.fill", "Home", 0)
            navigationButton("shippingbox.fill", "Packages", 1)
            navigationButton("gearshape.fill", "Settings", 2)
        }
        .padding(.vertical, 14)
        .background(background)
        .overlay(alignment: .top) {
            Divider()
                .overlay(.white.opacity(0.15))
        }
    }
    
    private func navigationButton(
        _ icon: String,
        _ title: String,
        _ index: Int
    ) -> some View {
        Button {
            selectedTab = index
        } label: {
            VStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 17))
                
                Text(title)
                    .font(.system(size: 9, weight: .medium))
            }
            .foregroundStyle(selectedTab == index ? accent : .gray)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
    
    private func section(_ name: String) -> some View {
        return Text(name)
            .font(.system(size: 10, weight: .bold, design: .monospaced))
            .tracking(1.5)
            .foregroundStyle(accent)
    }
    
    private func detail(_ name: String, _ value: String) -> some View {
        return HStack {
            Text(name)
                .foregroundStyle(.gray)
            
            Spacer()
            
            Text(value)
                .foregroundStyle(.white)
        }
        .font(.system(size: 12, design: .monospaced))
    }
    
    private func packageRow(
        _ name: String,
        _ version: String,
        _ description: String
    ) -> some View {
        return VStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(systemName: "shippingbox")
                    .font(.system(size: 23))
                    .foregroundStyle(accent)
                    .frame(width: 38)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.system(size: 13, weight: .semibold))
                    
                    Text(description)
                        .font(.system(size: 10))
                        .foregroundStyle(.gray)
                    
                    Text(version)
                        .font(.system(size: 9, design: .monospaced))
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Button {
                    if installed.contains(name) {
                        installed.remove(name)
                    } else {
                        installed.insert(name)
                    }
                } label: {
                    Text(installed.contains(name) ? "OPEN" : "GET")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundStyle(accent)
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, 12)
            
            Divider()
                .overlay(.white.opacity(0.1))
        }
    }
    
    private func startJailbreak() {
        guard !running && !jailbroken else { return }
        
        running = true
        progress = 0
        
        logs.append("[INFO] Starting process")
        
        let stages = [
            "[INFO] Checking environment",
            "[INFO] Preparing interface",
            "[INFO] Processing",
            "[INFO] Finalising"
        ]
        
        for (index, stage) in stages.enumerated() {
            DispatchQueue.main.asyncAfter(
                deadline: .now() + Double(index + 1)
            ) {
                logs.append(stage)
                progress = Double(index + 1) / Double(stages.count)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            jailbroken = true
            running = false
            progress = 1
            logs.append("[SUCCESS] Process completed")
        }
    }
}
