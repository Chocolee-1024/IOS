//
//  PaletteVC.swift
//  Palette
//
//  Created by imac-1763 on 2023/1/16.
//

import UIKit

class PaletteVC: UIViewController {

    @IBOutlet weak var paletteView: UIView!
    
    @IBOutlet var backView: UIView!
    @IBOutlet weak var redTextField:UITextField!
    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var greenTextField:UITextField!
    
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var blueTextField: UITextField!
    
    @IBOutlet weak var alphaTextField: UITextField!
    @IBOutlet weak var alphaSlider: UISlider!
    
    var redValue: Float = 0.0
    var blueValue: Float  = 0.0
    var greenValue: Float  = 0.0
    var alphaValue: Float  = 1.0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    /// 設定UI元件
    /// - Parameters:
    ///   - tag: Slider和TextField的Tag
    private func setupUI(){
        setupTextField(textField: redTextField, tag: 0)
        setupTextField(textField: greenTextField, tag: 1)
        setupTextField(textField: blueTextField, tag: 2)
        setupTextField(textField: alphaTextField, tag: 3)
        
        setupSlider(slider: redSlider, tag: 0)
        setupSlider(slider: greenSlider, tag: 1)
        setupSlider(slider: blueSlider, tag: 2)
        setupSlider(slider: alphaSlider, tag: 3)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKetborard))
        view.addGestureRecognizer(tap)
        paletteView.layer.borderColor = UIColor.black.cgColor
        paletteView.layer.borderWidth = 5
        paletteView.backgroundColor = .white
    }
    //關鍵盤
    @objc func closeKetborard(){
        view.endEditing(true)
        
    }
    //錯誤訊息
    func showAlert(title: String?, mesage: String?, confirmTitle: String?, confirm: (() -> Void)? = nil){
        let aleartController = UIAlertController(title: title, message: mesage, preferredStyle: .alert)
        let confirmAleart = UIAlertAction(title: confirmTitle, style: .default) { _ in
            confirm?()
        }
        aleartController.addAction(confirmAleart)
        present(aleartController,animated: true)
        
    }
    /// 設定UISlider樣式
    /// - Parameters:
    ///   - slider: 要設定的Slider
    ///   - tag: Slider的Tag
    private func setupSlider(slider: UISlider, tag: Int){
        slider.tag = tag
        slider.value = (tag == 3) ? 1 : 0
    }
    /// 設定UITextField樣式
    /// - Parameters:
    ///   - textField: 要設定的TextField
    ///   - tag: TextField的Tag
    private func setupTextField(textField: UITextField, tag: Int){
        textField.keyboardType = .numberPad
        textField.tag = tag
        textField.text = (tag == 3) ? "1" : "0"

    }
    //textField事件
    @IBAction func textFieldChange(_ sender: UITextField) {
    
        guard let text = sender.text, !(text.isEmpty) else{
            return
        }
        guard let textToFloat = Float(text), textToFloat <= 255 else{
            showAlert(title: "錯誤", mesage: "請輸入0~255", confirmTitle: "關閉"){
                switch sender.tag{
                case 0, 1, 2:
                    sender.text = "0"
                    self.redSlider.value = 0
                    self.redTextField.text = "0"
                    self.blueSlider.value = 0
                    self.blueTextField.text = "0"
                    self.greenSlider.value = 0
                    self.greenTextField.text = "0"
                    self.redSlider.thumbTintColor = .white
                    self.blueSlider.thumbTintColor = .white
                    self.greenSlider.thumbTintColor = .white
                case 3:
                    sender.text = "1"
                    self.redSlider.value = 1
                default:
                    break
                }
                self.paletteView.backgroundColor = .lightGray
                self.backView.backgroundColor = .white
            }
            return
        }
        switch sender.tag{
        case 0:
            redValue = textToFloat
            redSlider.value = textToFloat
        case 1:
            greenValue = textToFloat
            greenSlider.value = textToFloat
        case 2:
            blueValue = textToFloat
            blueSlider.value = textToFloat
        case 3:
            alphaValue = textToFloat
            alphaSlider.value = textToFloat
        default:
            break
        }

        paletteView.backgroundColor = UIColor(red: CGFloat(redValue)/255,
                                              green: CGFloat(greenValue)/255,
                                              blue: CGFloat(blueValue)/255,
                                              alpha: CGFloat(alphaValue))
        
        backView.backgroundColor = UIColor(red: CGFloat(redValue)/255,
                                           green: CGFloat(greenValue)/255,
                                           blue: CGFloat(blueValue)/255,
                                           alpha: CGFloat(alphaValue))
        
    }
    
    //Slider事件
    @IBAction func SliderChange(_ sender: UISlider) {

        switch sender.tag{
        case 0:
            redValue = Float(sender.value)
            redTextField.text = String(format: "%.0f", arguments: [redValue])
            redSlider.minimumTrackTintColor = UIColor(red: CGFloat(redValue)/255,
                                                      green: 0,
                                                      blue: 0,
                                                      alpha: 1)
            
            redSlider.thumbTintColor = UIColor(red: CGFloat(redValue)/255,
                                               green: 0,
                                               blue: 0,
                                               alpha: 1)
        case 1:
            greenValue = Float(sender.value)
            greenTextField.text = String(format: "%.0f", arguments: [greenValue])
            greenSlider.minimumTrackTintColor = UIColor(red: 0,
                                                green: CGFloat(greenValue)/255,
                                                blue: 0,
                                                alpha:1)
            
            greenSlider.thumbTintColor = UIColor(red: 0,
                                                 green: CGFloat(greenValue)/255,
                                                 blue: 0,
                                                 alpha:1)
        case 2:
            blueValue = Float(sender.value)
            blueTextField.text = String(format: "%.0f", arguments: [blueValue])
            blueSlider.minimumTrackTintColor = UIColor(red: 0,
                                                green: 0,
                                                blue: CGFloat(blueValue)/255,
                                                alpha:1)
            blueSlider.thumbTintColor = UIColor(red: 0,
                                                green: 0,
                                                blue: CGFloat(blueValue)/255,
                                                alpha:1)
        case 3:
            alphaValue = Float(sender.value)
            alphaTextField.text = String(format: "%.2f", arguments: [alphaValue])
        default:
            break
        }
        paletteView.backgroundColor = UIColor(red: CGFloat(redValue)/255,
                                              green: CGFloat(greenValue)/255,
                                              blue: CGFloat(blueValue)/255,
                                              alpha: CGFloat(alphaValue))
        
        backView.backgroundColor = UIColor(red: CGFloat(redValue)/255,
                                           green: CGFloat(greenValue)/255,
                                           blue: CGFloat(blueValue)/255,
                                           alpha: CGFloat(alphaValue))
        
    }
    
}
