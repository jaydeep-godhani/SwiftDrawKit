//
//  ViewController.swift
//  SwiftDrawKit
//
//  Created by Jaydeep Godhani on 03/06/25.
//  Copyright © 2025 JG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var eraserButton: UIButton!
    @IBOutlet weak var drawView: SwiftDrawView!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var shapeCollectionView: UICollectionView!
    @IBOutlet weak var fillModeView: UIView!
    @IBOutlet weak var fillModeButton: UIButton!
    
    // MARK: - Properties
    
    private var colorList: [BrushColorModel] = []
    var selectedColor = BrushColorModel(id: 2, color: "#000000")
    private var magicBrushList: [MagicBrushModel] = []
    var selectedShape = MagicBrushModel(id: 0, icon: "ic_brush", type: .draw)
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.initialConfig()
    }
    
    // MARK: - Selectors
    
    // Undo Button Action
    @IBAction func undoButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.drawView.undo()
        self.updateHistoryButtons()
    }
    
    // Redo Button Action
    @IBAction func redoButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.drawView.redo()
        self.updateHistoryButtons()
    }
    
    // Clear Button Action
    @IBAction func clearButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.drawView.clear()
        self.deactivateEraser()
    }
    
    // Eraser Button Action
    @IBAction func eraserButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if self.drawView.brush.blendMode == .normal {
            self.activateEraser()
        } else {
            self.deactivateEraser()
        }
    }
    
    // Size Slider Action
    @IBAction func sizeSliderAction(_ sender: UISlider) {
        self.drawView.brush.width = CGFloat(sender.value)
    }
    
    // Opacity Slider Action
    @IBAction func opacitySliderAction(_ sender: UISlider) {
        self.drawView.brush.opacity = CGFloat(sender.value)
        self.deactivateEraser()
    }
    
    // Fill Mode Button Action
    @IBAction func fillModeButtonAction(_ sender: UIButton) {
        self.drawView.shouldFillPath = !drawView.shouldFillPath
        if (self.drawView.shouldFillPath) {
            self.fillModeButton.setTitleColor(.accent, for: .normal)
            self.fillModeButton.setTitle("Activate Stroke Mode", for: .normal)
        } else {
            self.fillModeButton.setTitleColor(.black, for: .normal)
            self.fillModeButton.setTitle("Activate Fill Mode", for: .normal)
        }
    }
    
    // MARK: - Helper Functions
    
    // Initial Config
    func initialConfig() {
        self.setupUI()
        self.setupCollectionView()
        self.setBrushColorData()
        self.setMagicBrushData()
        self.updateHistoryButtons()
        self.setupDrawView()
    }
    
    // Setup UI
    func setupUI() {
        self.sizeSlider.setThumbImage(UIImage(named: "custom_thumb"), for: .normal)
        self.sizeSlider.setThumbImage(UIImage(named: "custom_thumb"), for: .highlighted)
        self.opacitySlider.setThumbImage(UIImage(named: "custom_thumb"), for: .normal)
        self.opacitySlider.setThumbImage(UIImage(named: "custom_thumb"), for: .highlighted)
    }
    
    // Setup Collection View
    func setupCollectionView() {
        self.colorCollectionView.delegate = self
        self.colorCollectionView.dataSource = self
        self.colorCollectionView.register(UINib(nibName: PhotoEditingToolColorPickerCell.xibName, bundle: nil), forCellWithReuseIdentifier: PhotoEditingToolColorPickerCell.cellIdentifier)
        
        self.shapeCollectionView.delegate = self
        self.shapeCollectionView.dataSource = self
        self.shapeCollectionView.register(UINib(nibName: PhotoEditingBrushToolShapeCell.xibName, bundle: nil), forCellWithReuseIdentifier: PhotoEditingBrushToolShapeCell.cellIdentifier)
    }
    
    // Set Brush Color Data
    func setBrushColorData() {
        self.colorList = [
            BrushColorModel(id: 1, color: "#FFFFFF"),
            BrushColorModel(id: 2, color: "#000000"),
            BrushColorModel(id: 3, color: "#f44336"),
            BrushColorModel(id: 4, color: "#E91E63"),
            BrushColorModel(id: 5, color: "#EC407A"),
            BrushColorModel(id: 6, color: "#9C27B0"),
            BrushColorModel(id: 7, color: "#3F51B5"),
            BrushColorModel(id: 8, color: "#2196F3"),
            BrushColorModel(id: 9, color: "#03A9F4"),
            BrushColorModel(id: 10, color: "#00BFA5"),
            BrushColorModel(id: 11, color: "#00BCD4"),
            BrushColorModel(id: 12, color: "#009688"),
            BrushColorModel(id: 13, color: "#4CAF50"),
            BrushColorModel(id: 14, color: "#8BC34A"),
            BrushColorModel(id: 15, color: "#CDDC39"),
            BrushColorModel(id: 16, color: "#FFEB3B"),
            BrushColorModel(id: 17, color: "#FFC107"),
            BrushColorModel(id: 18, color: "#FF9800"),
            BrushColorModel(id: 19, color: "#FF5722"),
            BrushColorModel(id: 20, color: "#795548"),
            BrushColorModel(id: 21, color: "#9E9E9E"),
            BrushColorModel(id: 22, color: "#607D8B")
        ]
        self.colorCollectionView.reloadData()
    }
    
    // Set Magic Brush Data
    func setMagicBrushData() {
        self.magicBrushList = [
            MagicBrushModel(id: 0, icon: "ic_brush", type: .draw),
            MagicBrushModel(id: 2, icon: "ic_line", type: .line),
            MagicBrushModel(id: 3, icon: "ic_circle_oval", type: .ellipse),
            MagicBrushModel(id: 4, icon: "ic_rectangle", type: .rect)
        ]
        self.shapeCollectionView.reloadData()
    }
    
    func updateHistoryButtons() {
        self.undoButton.isEnabled = self.drawView.canUndo
        self.redoButton.isEnabled = self.drawView.canRedo
    }
    
    // Setup Draw View
    func setupDrawView() {
        self.drawView.delegate = self
        self.drawView.brush.width = 7
        self.drawView.allowedTouchTypes = [.finger, .pencil]
    }
    
    func activateEraser() {
        self.drawView.brush.blendMode = .clear
        self.eraserButton.tintColor = .accent
        self.headerLabel.text = "Eraser"
    }
    
    func deactivateEraser() {
        self.drawView.brush.blendMode = .normal
        self.eraserButton.tintColor = .black
        self.headerLabel.text = "Brush"
    }
    
}

// MARK: - Extension

// MARK: Collection View Setup
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.colorCollectionView:
            return self.colorList.count
        case self.shapeCollectionView:
            return self.magicBrushList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.colorCollectionView:
            let cell = self.colorCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoEditingToolColorPickerCell.cellIdentifier, for: indexPath) as! PhotoEditingToolColorPickerCell
            let item = self.colorList[indexPath.item]
            cell.setData(data: item)
            if selectedColor.id == item.id {
                cell.colorView.layer.borderColor = UIColor.accent.cgColor
            } else {
                if indexPath.item == 0 {
                    cell.colorView.layer.borderColor = UIColor.black.cgColor
                } else {
                    cell.colorView.layer.borderColor = UIColor.clear.cgColor
                }
            }
            return cell
        case self.shapeCollectionView:
            let cell = self.shapeCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoEditingBrushToolShapeCell.cellIdentifier, for: indexPath) as! PhotoEditingBrushToolShapeCell
            let item = self.magicBrushList[indexPath.item]
            cell.setData(data: item)
            if self.selectedShape.id == item.id {
                cell.imageView.tintColor = .accent
            } else {
                cell.imageView.tintColor = UIColor(hex: "212121")
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.colorCollectionView:
            let item = self.colorList[indexPath.item]
            self.selectedColor = item
            self.colorCollectionView.reloadData()
            self.drawView.brush.color = Color(UIColor(hex: item.color))
            self.deactivateEraser()
        case self.shapeCollectionView:
            let item = self.magicBrushList[indexPath.item]
            self.selectedShape = item
            self.shapeCollectionView.reloadData()
            switch item.type {
            case .line:
                self.drawView.drawMode = .line
                self.fillModeView.isHidden = true
                break
            case .ellipse:
                self.drawView.drawMode = .ellipse
                self.fillModeView.isHidden = false
                break
            case .rect:
                self.drawView.drawMode = .rect
                self.fillModeView.isHidden = false
                break
            case .draw:
                self.drawView.drawMode = .draw
                self.fillModeView.isHidden = true
                break
            }
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: SwiftDrawViewDelegate
extension ViewController: SwiftDrawViewDelegate {
    
    func SwiftDraw(shouldBeginDrawingIn drawingView: SwiftDrawView, using touch: UITouch) -> Bool {
        return true
    }
    
    func SwiftDraw(didBeginDrawingIn drawingView: SwiftDrawView, using touch: UITouch) {
        self.updateHistoryButtons()
    }
    
    func SwiftDraw(isDrawingIn drawingView: SwiftDrawView, using touch: UITouch) {
        
    }
    
    func SwiftDraw(didFinishDrawingIn drawingView: SwiftDrawView, using touch: UITouch) {
        
    }
    
    func SwiftDraw(didCancelDrawingIn drawingView: SwiftDrawView, using touch: UITouch) {
        
    }
    
}
