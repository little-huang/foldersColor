//
//  ExtensionImage.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/12.
//

import Foundation
import SwiftUI

extension NSImage {
		
		func resize(_ to: CGSize, isPixels: Bool = false) -> NSImage {
				
				var toSize = to
				let screenScale: CGFloat = NSScreen.main?.backingScaleFactor ?? 1.0

				if isPixels {
						
						toSize.width = to.width / screenScale
						toSize.height = to.height / screenScale
				}
		
				let toRect = NSRect(x: 0, y: 0, width: toSize.width, height: toSize.height)
				let fromRect =  NSRect(x: 0, y: 0, width: size.width, height: size.height)
				
				let newImage = NSImage(size: toRect.size)
				newImage.lockFocus()
				draw(in: toRect, from: fromRect, operation: NSCompositingOperation.copy, fraction: 1.0)
				newImage.unlockFocus()
		
				return newImage
		}
}
