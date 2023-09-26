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
        let eraser = DrawingTool(color: .clear, delay: 2.0) { [weak self] in
            self?.canvasView?.eraseAll()
        }
        canvasView?.activate(tool: eraser)
    }
}
