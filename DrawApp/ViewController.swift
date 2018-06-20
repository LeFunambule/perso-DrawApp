//
//  ViewController.swift
//  DrawApp
//
//  Created by etudiant23 on 23/01/2018.
//  Copyright © 2018 etudiant23. All rights reserved.
//

import UIKit
import QuartzCore


class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    // MARK// MARK: - Variables
    // Private variables
    
    @IBOutlet weak var beginLabel: UILabel!
    @IBOutlet weak var movedLabel: UILabel!
    @IBOutlet weak var endedLabel: UILabel!
    @IBOutlet weak var drawUIView: UIView!
    
    @IBOutlet weak var colorPickerButton: UIButton!
    
    private var _shapeColor: UIColor? = .magenta
    
    // Public variables
    
  
    
    // MARK: - Getter & Setter methods
    //appelle des variables privées à l'exterieur de la classe
    
    
    
    
    // MARK: - Constructors
    
    
    
    // MARK: - Init behaviors
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
//        beginLabel.font = UIFont.fontAwesome(ofSize: 20)
//        beginLabel.text = String.fontAwesomeIcon(name: .github)
//
//        movedLabel.font = UIFont.fontAwesome(ofSize: 50)
//        movedLabel.text = String.fontAwesomeIcon(name: .github)
//
//        endedLabel.font = UIFont.fontAwesome(ofSize: 50)
//        endedLabel.text = String.fontAwesomeIcon(name: .github)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Public methods
    
   
    
    
    // MARK: - Private methods
    
    
    // MARK: - Delegates methods
    
    func shapeLayer(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: x, y: y, width: width, height: height), cornerRadius: 20).cgPath
        layer.strokeColor = UIColor.blue.cgColor
    //    layer.fillColor = UIColor.blue.cgColor
        drawUIView.layer.masksToBounds = true // empêche de déborder du drawUIView
        drawUIView.layer.addSublayer(layer) // layer : rendu en pixels
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let position = touch.location(in: drawUIView)
            
            //  print(position)
            beginLabel.text = "x: \(position.x), y: \(position.y)"
            shapeLayer(x: position.x, y: position.y, width: 10, height: 10)
            // drawRect(point: position)
        }
        super.touchesBegan(touches, with: event)
    }
    
    func drawRect(point: CGPoint) {
        let view = UIView(frame: CGRect(origin: point, size: CGSize(width: 6, height: 6)))
      //  view.backgroundColor = .blue
        drawUIView.addSubview(view)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: drawUIView)
            //  print(position)
            movedLabel.text = "x: \(position.x), y: \(position.y)"
            shapeLayer(x: position.x, y: position.y, width: 10, height: 10)
           // drawRect(point: position)
        }
        super.touchesBegan(touches, with: event)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: view)
            //  print(position)
            endedLabel.text = "x: \(position.x), y: \(position.y)"
        }
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func clearButtonHandler(_ sender: Any) {
        guard let sublayers = drawUIView.layer.sublayers else {
            print("error no sublayer")
            return
        }
        for layer in sublayers {
            layer.removeFromSuperlayer()
        }
        //        clearButton.delete(view)
    }
    

    
    @IBAction func colorPickerButton(_ sender: UIButton) {
        
        let popoverVC = storyboard?.instantiateViewController(withIdentifier: "colorPickerPopover") as! ColorPickerViewController
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: 284, height: 446)
        if let popoverController = popoverVC.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = CGRect(x: 0, y: 0, width: 85, height: 30)
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
            popoverVC.delegate = self
        }
        present(popoverVC, animated: true, completion: nil)
    }
    
    // Override the iPhone behavior that presents a popover as fullscreen
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .none
     //return .none // les couleurs restent sur la même page
    }
    
    private func _draw(point: CGPoint, color: UIColor? = .magenta) {
        let dot = Shape(frame: CGRect(origin: point, size: CGSize(width: 20, height: 20)))
        if let myShapeColor = color {
            dot.color = myShapeColor
        }
        shapeLayer.addSubview(dot)
    }
    
    func setButtonColor (_ color: UIColor) {
        colorPickerButton?.setTitleColor(color, for:UIControlState())
        _shapeColor = color
    }
   
}

