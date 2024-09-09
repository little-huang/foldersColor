//
//  ExtensionColor.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/10.
//

import Foundation
import SwiftUI

extension Color {
	
		init(hex: Int, alpha: Double = 1) {
				let components = (
						R: Double((hex >> 16) & 0xff) / 255,
						G: Double((hex >> 08) & 0xff) / 255,
						B: Double((hex >> 00) & 0xff) / 255
				)
				self.init(
						.sRGB,
						red: components.R,
						green: components.G,
						blue: components.B,
						opacity: alpha
				)
		}
}
