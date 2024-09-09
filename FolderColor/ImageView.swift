//
//  ImageView.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/6.
//

import Foundation
import SwiftUI
import Cocoa

extension UIView {
		func asImage(rect: CGRect) -> UIImage {
				let renderer = UIGraphicsImageRenderer(bounds: rect)
			NSGraphicsContext
				return renderer.image { rendererContext in
						layer.render(in: rendererContext.cgContext)
				}
		}
}

struct ImageView: View {
	
		@State private var rect1: CGRect = .zero
		@State private var rect2: CGRect = .zero
		@State private var uiimage: NSImage? = nil
	
		var body: some View {
				VStack {
						HStack {
								VStack {
										Text("LEFT")
										Text("VIEW")
								}
								.padding(20)
								.background(Color.green)
								.border(Color.blue, width: 5)
								.background(RectGetter(rect: $rect1))
								.onTapGesture { self.uiimage = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: self.rect1)
										if(uiimage != nil){
												saveAndShare(img: uiimage!)
										}
								}

								VStack {
										Text("RIGHT")
										Text("VIEW")
								}
								.padding(40)
								.background(Color.yellow)
								.border(Color.green, width: 5)
								.background(RectGetter(rect: $rect2))
								.onTapGesture { self.uiimage = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: self.rect2)
										if(uiimage != nil){
												saveAndShare(img: uiimage!)
										}
								}

						}
						if uiimage != nil {
								VStack {
										Text("Captured Image")
										Image(uiImage: self.uiimage!).padding(20).border(Color.black)
								}.padding(20)
						}

				}
		}
		
		func saveAndShare(img: UIImage) {
				let fileManager = FileManager.default
				let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
				let filePath = "\(rootPath)/share.jpg"
				let imageData = img.jpegData(compressionQuality: 1.0)
				fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
				let url:URL = URL.init(fileURLWithPath: filePath)
				let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
				UIApplication.shared.windows.first?.rootViewController!.present(av, animated: true, completion: nil)
		}
}

struct RectGetter: View {
		@Binding var rect: CGRect

		var body: some View {
				GeometryReader { proxy in
						self.createView(proxy: proxy)
				}
		}

		func createView(proxy: GeometryProxy) -> some View {
				DispatchQueue.main.async {
						self.rect = proxy.frame(in: .global)
				}

				return Rectangle().fill(Color.clear)
		}
}


struct ImageView_Previews: PreviewProvider {
		static var previews: some View {
			ImageView()
		}
}

