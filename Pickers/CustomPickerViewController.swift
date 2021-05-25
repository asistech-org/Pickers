//
//  Created by Alexander Svalov on 11.03.2021.
//

import UIKit
import AudioToolbox

class CustomPickerViewController: UIViewController,
    UIPickerViewDataSource, UIPickerViewDelegate {
    
    private var images: [UIImage]!
    private var winSoundID: SystemSoundID = 0
    private var crunchSoundID: SystemSoundID = 0
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var button: UIButton!

    @IBAction func spin(_ sender: UIButton) {
        var win = false
        var numInRow = -1
        var lastVal = -1
        
        for i in 0...4 {
            let newValue = Int(arc4random_uniform(UInt32(images.count)))
            if newValue == lastVal {
                numInRow += 1
                if numInRow > 2 {
                    win = true
                }
            } else {
                numInRow = 1
            }
            lastVal = newValue
            
            picker.selectRow(newValue, inComponent: i, animated: true)
            picker.reloadComponent(i)
        }
        
        if crunchSoundID == 0 {
            let soundURL = Bundle.main.url(forResource: "crunch", withExtension: "wav")! as CFURL
            AudioServicesCreateSystemSoundID(soundURL, &crunchSoundID)
        }
        AudioServicesPlaySystemSound(crunchSoundID)
        
        if win {
            // проигрываем звук и показываем сообщение через 0.5 секунд
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute:  {
                self.playWinSound()
            })
        } else {
            // показываем кнопку через 0.5 секунд
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.showButton()
            })
        }
        button.isHidden = true  // прячем кнопку
        winLabel.text = win ? "WINNER!" : " "
    }
  
    func showButton() {
        button.isHidden = false  // показываем кнопку
    }
    
    func playWinSound() {
        if winSoundID == 0 {
            // Если звук не загружен, то загружаем
            let soundURL = Bundle.main.url(forResource: "win", withExtension: "wav")! as CFURL
            AudioServicesCreateSystemSoundID(soundURL, &winSoundID)
        }
        AudioServicesPlaySystemSound(winSoundID)
        winLabel.text = "WINNER!"
        // показываем кнопку через 0.5 секунд
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.showButton()
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Загружаем картинки из Assets.xcassets в массив
        images = [
            UIImage(named: "seven")!,
            UIImage(named: "bar")!,
            UIImage(named: "crown")!,
            UIImage(named: "cherry")!,
            UIImage(named: "lemon")!,
            UIImage(named: "apple")!
        ]
        winLabel.text = " "
        arc4random_stir()  // инициализация генератора случайных чисел
    }
    
    // MARK:-
    // MARK: Picker Data Source Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    // MARK:-
    // MARK: Picker Delegate Methods
    
    // загрузка картинки в селектор
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView {
        let image = images[row]
        let imageView = UIImageView(image: image)
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 64
    }
}
