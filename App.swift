import SwiftUI
import MetalKit

@main
struct WinHubApp: App {
    var body: some Scene {
        WindowGroup {
            EmulatorScreeen()
        }
    }
}

struct EmulatorScreeen: View {
    var body: some View {
        ZStack {
            // 1. The Game Rendering Layer (Where GTA V/Horizon appears)
            MetalView() 
                .ignoresSafeArea()
            
            // 2. Virtual Gamepad Overlay
            VirtualControllerView()
            
            // 3. Performance HUD
            VStack {
                HStack {
                    Text("FPS: 60").foregroundColor(.green).bold()
                    Spacer()
                    Text("JIT: ACTIVE").foregroundColor(.blue).bold()
                }
                .padding()
                Spacer()
            }
        }
    }
}

// Placeholder for the Emulator's Graphics Output
struct MetalView: UIViewRepresentable {
    func makeUIView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.backgroundColor = .black
        // In a full build, the Wine/Box64 output would bind to this layer
        return mtkView
    }
    func updateUIView(_ uiView: MTKView, context: Context) {}
}

// The Virtual Gamepad UI
struct VirtualControllerView: View {
    var body: some View {
        HStack {
            // D-Pad / Joystick Left
            Circle()
                .fill(Color.white.opacity(0.3))
                .frame(width: 120, height: 120)
                .overlay(Text("L").foregroundColor(.white))
                .padding(.leading, 50)
            
            Spacer()
            
            // Action Buttons (A, B, X, Y)
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    ActionButton(label: "Y", color: .yellow)
                }
                HStack(spacing: 40) {
                    ActionButton(label: "X", color: .blue)
                    ActionButton(label: "B", color: .red)
                }
                ActionButton(label: "A", color: .green)
            }
            .padding(.trailing, 50)
        }
    }
}

struct ActionButton: View {
    let label: String
    let color: Color
    var body: some View {
        Circle()
            .fill(color.opacity(0.6))
            .frame(width: 50, height: 50)
            .overlay(Text(label).bold().foregroundColor(.white))
    }
}
