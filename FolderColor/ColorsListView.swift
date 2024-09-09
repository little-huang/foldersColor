//
//  ColorsListView.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/8.
//

import Foundation
import SwiftUI
import SwiftUIFlux

struct ColorsListView: ConnectedView {
	
	struct Props {
		let dispatch: DispatchFunction
		let colors: [FolderColor]
		let currentSelectItem: FolderColor?
		let currentSelectIndex: Int
	}

	@State var fColor: CGColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
	
	private var gridItemLayout = [
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center)
	]
	
	private var currentSelectedColorItemIndex: Int = 0
	
	@State var message: String = ""
	
	func emitColors(props: Props, colors: [FolderColor]) {
		
		props.dispatch(
			ColorActions.SetColors(response: colors)
		)

		let selectedItem = ColorListUtil.shared.getCurrentSelectedColorItem(colors: colors)

		props.dispatch(
			ColorActions.setCurrentSelectItem(response: selectedItem)
		)

		let selectedIndex = ColorListUtil.shared.getCurrentSelectedIndex(colors: colors)

		props.dispatch(
			ColorActions.setCurrentSelectIndex(response: selectedIndex)
		)
		
	}
	
	func selectColor(props: Props, index: Int) {
		let newColors: [FolderColor] = ColorListUtil.shared.toggleColorsSelected(colors: props.colors, index: index)
		let components: [CGFloat] = newColors[index].color
		
		fColor = CGColor(red: components[0], green: components[1], blue: components[2], alpha: components[3])
		
		emitColors(props: props, colors: newColors)
	}
	
	func clearColor(props: Props) {
		let newColors: [FolderColor] = ColorListUtil.shared.toggleColorsSelected(colors: props.colors, index: nil)
		emitColors(props: props, colors: newColors)
	}
	
	func addColor(props: Props) {
	  
		var newColors: [FolderColor] = ColorListUtil.shared.toggleColorsSelected(colors: props.colors, index: nil)
		
		var newColorComponents: [CGFloat] = ColorListUtil.shared.randomColorComponents();
		
		let newColor: FolderColor = FolderColor(
			color: newColorComponents,
			isSelected: true
		)
		
		newColors.append(newColor)
	  
		emitColors(props: props, colors: newColors)

		fColor = CGColor(red: newColorComponents[0], green: newColorComponents[1], blue: newColorComponents[2], alpha: newColorComponents[3])
		
	}
	
	func removeColor(props: Props) {
		
		if (TypeUtil.shared.isNull(value: props.currentSelectItem)) {
			return
		}
		
		var index: Int = 0
	  
		if (props.currentSelectIndex == 0) {
			index = props.colors.count > 1 ? props.currentSelectIndex + 1 : 0
		} else {
			index = props.currentSelectIndex - 1
		}
		
		var newColors: [FolderColor] = ColorListUtil.shared.toggleColorsSelected(
			colors: props.colors,
			index: index
		)
	  
		newColors.remove(at: props.currentSelectIndex)
		
		emitColors(props: props, colors: newColors)

		fColor = CGColor(red: newColors[index].color[0], green: newColors[index].color[1], blue: newColors[index].color[2], alpha: newColors[index].color[3])
		
	}
	
	func changeColor(props: Props, newColor: CGColor) {
		
		if (TypeUtil.shared.isNull(value: props.currentSelectItem)) {
			return
		}
		
		var newColors: [FolderColor] = ColorListUtil.shared.toggleColorsSelected(colors: props.colors, index: props.currentSelectIndex)
		let components = newColor.components
		
		newColors[props.currentSelectIndex].color = [
			components?[0] ?? defaultFolderColorComponents[0],
			components?[1] ?? defaultFolderColorComponents[1],
			components?[2] ?? defaultFolderColorComponents[2],
			components?[3] ?? defaultFolderColorComponents[3]
		]
		
		emitColors(props: props, colors: newColors)
	}
	
	func folderSVGView(props: Props) -> some View {
		return SVGView(item: props.currentSelectItem!)
	}
	
	func header(props: Props) -> some View {
		
		let color = props.currentSelectItem?.color ?? defaultFolderColorComponents
		
		return HStack (alignment: .center) {
			
			if (TypeUtil.shared.isNotNull(value: props.currentSelectItem)) {
				
				HStack {
					
					ZStack(alignment: .center) {
						
						Image(systemName: "xmark.circle")
							.resizable()
							.frame(width: 20, height: 20)
							.padding(
								EdgeInsets(top: 0, leading: -15, bottom: 40, trailing: 75)
							)
							.onTapGesture {
								clearColor(props: props)
							}
						
						SVGDisplayView(item: props.currentSelectItem!)
						
					}.padding(0)
					
				}
				
			} else {
				Image("Folder")
					.resizable()
					.frame(width: 66, height: 62)
			}
				
			
		}
	}
	
	func footer(props: Props) -> some View {
		return HStack {
			
			Button(action: {
				addColor(props: props)
			}) {
				Text("+")
					.frame(width: 30)
			}
			
			if (TypeUtil.shared.isNotNull(value: props.currentSelectItem)) {
				
				Button(action: {
					removeColor(props: props)
				}) {
					Text("-")
						.frame(width: 30)
				}
				
			}
			
		}
	}
	
	func setIcon(props: ColorsListView.Props, url: URL) {
		
		if (TypeUtil.shared.isNull(value: props.currentSelectItem)) {
			setDefaultIcon(props: props, url: url)
		} else {
			setCustomIcon(props: props, url: url)
		}
		
	}

	func setDefaultIcon(props: ColorsListView.Props, url: URL) {
		let image: NSImage = NSImage.init(named: "Folder") ?? NSImage()
		setIconBase(url: url, image: image)
	}

	func setCustomIcon(props: ColorsListView.Props, url: URL) {
		
		DispatchQueue.main.async {
			
			var image: NSImage = folderSVGView(props: props).renderAsImage() ?? NSImage()
			
			setIconBase(url: url, image: image)
			
		}
		
	}

	func setIconBase(url: URL, image: NSImage?) {
		
		if (TypeUtil.shared.isNull(value: image)) {
			return
		}
		
		let path = url.path.replacingOccurrences(of: "file://", with: "")
		
		let workSpace = NSWorkspace.shared
												
		let option = NSWorkspace.IconCreationOptions.excludeQuickDrawElementsIconCreationOption
		
		workSpace.setIcon(image, forFile: path, options: option)
	}

	func describeDroppedURL(_ url: URL, props: ColorsListView.Props) -> String {
		 
			do {
				
					let messageRows: [String] = []

					if try url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory == true {
						setIcon(props: props, url: url)
					}

					return messageRows.joined(separator: "\n")
				
			} catch {
					return "Error: \(error)"
			}
	}

	func handleDrop(providers: [NSItemProvider], props: ColorsListView.Props) {
		let dispatchGroup = DispatchGroup()
		var handled = false

		for provider in providers {
			let isURL = provider.hasItemConformingToTypeIdentifier("public.url")
			if !isURL {
				print("not url")
				continue
			}

			handled = true
			dispatchGroup.enter()
			provider.loadItem(forTypeIdentifier: "public.file-url", options: nil) { (urlData, error) in
				DispatchQueue.main.async {
					if let data = urlData as? Data,
					   let url = URL(dataRepresentation: data, relativeTo: nil),
					   url.hasDirectoryPath {
						describeDroppedURL(url, props: props)
						// 通知 Finder 文件系统已更改
						NSWorkspace.shared.noteFileSystemChanged(url.path)
					}
					dispatchGroup.leave()
				}
			}
		}

		dispatchGroup.notify(queue: DispatchQueue.main) {
			print("dispatchGroup notify")
		}
	}

	func initFcColor(props: Props) {
		if (TypeUtil.shared.isNotNull(value: props.currentSelectItem)) {
			let components = props.currentSelectItem?.color ?? defaultFolderColorComponents
			fColor = CGColor(red: components[0], green: components[1], blue: components[2], alpha: components[3])
		}
	}

	func body(props: Props) -> some View {
		
		let currentColor = Binding<CGColor>(
			get: {
				return fColor
			},
			set: { newColor in

				fColor = newColor
				
				if (TypeUtil.shared.isNotNull(value: props.currentSelectItem)) {
					changeColor(props: props, newColor: fColor)
				}
				
			}
		)
		
		return VStack {
			
			HStack {
				HStack {
					header(props: props)
				}
			}
			.frame(width: 400)
			
			HStack {
				Text(TypeUtil.shared.isNotNull(value: props.currentSelectItem) ? "content" : "revertContent")
			}
			.frame(width: 400)
			.padding(
				EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0)
			)
			
			HStack {
				ScrollView {
					LazyVGrid (columns: gridItemLayout) {
						
						ForEach(0..<props.colors.count, id:\.self) { index in
							
							ColorListItemView(item: props.colors[index])
								.onTapGesture(perform: {
									selectColor(props: props, index: index)
								})
							
						}
						
					}
				}
				.onTapGesture(perform: {
					clearColor(props: props)
				})
				
			}.frame(width: 400, height: 200)
			
			HStack {
				footer(props: props)
				Spacer()
				HStack {
					if (TypeUtil.shared.isNotNull(value: props.currentSelectItem)) {
						ColorPicker("", selection: currentColor)
					}
				}
			}
			.padding(
				EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30)
			)
			.frame(width: 400, height: 50)
			
		} // VStack end
		.frame(width: 400, height: 500)
		.onDrop(of: [.fileURL], isTargeted: nil) { providers in
			handleDrop(providers: providers, props: props)
			return true
		} // onDrop end
		.onAppear() {
			initFcColor(props: props)
		} // onAppear end

	} // body end
	
}

extension ColorsListView {
	
	func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
		
		let colors = state.colorState.colors
		let currentSelectItem = state.colorState.currentSelectItem
		let currentSelectIndex = state.colorState.currentSelectIndex
		
		return Props(
			dispatch: dispatch,
			colors: colors,
			currentSelectItem: currentSelectItem,
			currentSelectIndex: currentSelectIndex
		)
	}
	
}


#if DEBUG
struct ColorsListView_Previews: PreviewProvider {
	static var previews: some View {
		ColorsListView().environmentObject(sampleStore)
	}
}
#endif
