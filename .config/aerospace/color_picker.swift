import AppKit

let app = NSApplication.shared
app.setActivationPolicy(.accessory)
app.activate(ignoringOtherApps: true)

// https://developer.apple.com/documentation/appkit/nscolorsampler
NSColorSampler().show { selectedColor in
    // Escape cancels without changing the clipboard.
    guard let selectedColor else { exit(0) }
    guard let color = selectedColor.usingColorSpace(.sRGB) else { exit(1) }

    func byte(_ component: CGFloat) -> Int {
        Int((min(1, max(0, component)) * 255).rounded())
    }

    let hex = String(
        format: "#%02X%02X%02X",
        byte(color.redComponent),
        byte(color.greenComponent),
        byte(color.blueComponent)
    )
    let clipboard = NSPasteboard.general
    clipboard.clearContents()
    exit(clipboard.setString(hex, forType: .string) ? 0 : 1)
}

app.run()
