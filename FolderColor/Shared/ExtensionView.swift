//
//  View.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/11.
//

import Foundation
import SwiftUI

class NoInsetHostingView<V>: NSHostingView<V> where V: View {
		
		override var safeAreaInsets: NSEdgeInsets {
				return .init()
		}
		
}

public extension NSView {
		
		func bitmapImage() -> NSImage? {
				guard let rep = bitmapImageRepForCachingDisplay(in: bounds) else {
						return nil
				}
				cacheDisplay(in: bounds, to: rep)
				guard let cgImage = rep.cgImage else {
						return nil
				}
				return NSImage(cgImage: cgImage, size: bounds.size)
		}
		
}

public extension View {
		
		func renderAsImage() -> NSImage? {
				let view = NoInsetHostingView(rootView: self)
				view.setFrameSize(view.fittingSize)
				return view.bitmapImage()
		}

}
