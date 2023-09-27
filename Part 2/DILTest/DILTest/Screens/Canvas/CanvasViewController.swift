//
//  CanvasViewController.swift
//  DILTest
//
//  Created by Gazdag Sandor on 2023. 09. 25..
//

import UIKit

class CanvasViewController: UIViewController {
    
    @IBOutlet weak var canvasView: CanvasView?
    @IBOutlet weak var redButton: UIButton?
    @IBOutlet weak var blueButton: UIButton?
    @IBOutlet weak var greenButton: UIButton?
    @IBOutlet weak var eraseButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvasView?.drawingManager = DrawingManager()
        canvasView?.drawingManager?.delegate = canvasView
    }
    
    @IBAction func redButtonPressed() {
        canvasView?.selectedTool = .red
    }
    
    @IBAction func blueButtonPressed() {
        canvasView?.selectedTool = .blue
    }
    
    @IBAction func greenButtonPressed() {
        canvasView?.selectedTool = .green
    }
    
    @IBAction func eraseButtonPressed() {
        var eraser = DrawingTool.eraseAll
        eraser.baseTime = CFAbsoluteTimeGetCurrent()
        eraser.action = { [weak self] in
            self?.canvasView?.eraseAll()
        }
        canvasView?.activate(tool: eraser)
    }
}
