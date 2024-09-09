//
//  FolderColorApp.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/5.
//

import SwiftUI
import SwiftUIFlux

let store = Store<AppState>(reducer: appStateReducer, state: AppState())

struct WindowAccessor: NSViewRepresentable {
	var callback: (NSWindow) -> ()

	func makeNSView(context: Context) -> NSView {
		let nsView = NSView()
		DispatchQueue.main.async {
			if let window = nsView.window {
				self.callback(window)
			}
		}
		return nsView
	}

	func updateNSView(_ nsView: NSView, context: Context) {}
}

struct FixedSizeWindow: NSViewControllerRepresentable {
	func makeNSViewController(context: Context) -> NSViewController {
		let viewController = NSViewController()
		let hostingController = NSHostingController(rootView: ContentView())

		viewController.view = hostingController.view
		viewController.view.window?.styleMask.remove(.resizable)

		if let window = viewController.view.window {
			window.setContentSize(NSSize(width: 400, height: 500))
			window.minSize = NSSize(width: 400, height: 500)
			window.maxSize = NSSize(width: 400, height: 500)
		}

		return viewController
	}

	func updateNSViewController(_ nsViewController: NSViewController, context: Context) {
		// No update needed
	}
}

@main
struct FolderColorApp: App {
	
	// 应用程序生命周期
	@Environment(\.scenePhase) var scenePhase
	
	// 存档计时器
	let archiveTimer: Timer

	func initColor() {
		// 判断是否是第一次启动
		if LaunchManagerUtil.isFirstLaunch() {
			// 第一次启动时的操作
			print("This is the first launch.")
			// 设置标志为已启动
			LaunchManagerUtil.setFirstLaunchFlag()
		} else {
			// 不是第一次启动时的操作
			print("This is not the first launch.")
		}
	}
	
	init() {
		archiveTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { _ in
			store.state.archiveState()
		})
		initColor()
	}
	
	var body: some Scene {
		WindowGroup {
			StoreProvider(store: store) {
				FixedSizeWindow()
						.frame(width: 400, height: 500)
						.background(WindowAccessor { window in
							window.title = "Folders Color"
						})
			}
		}
		// WindowGroup end
	}
	
} // DouYaDrinkWaterNoFireBaseApp end

