//
//  Created by Alexander Svalov on 11.03.2021.
//

import UIKit

class DependentComponentPickerViewController: UIViewController,
    UIPickerViewDelegate, UIPickerViewDataSource {
        
    private let stateComponent = 0
    private let zipComponent = 1
    private var stateZips: [String : [String]]!
    private var states: [String]!
    private var zips: [String]!

    @IBOutlet weak var dependentPicker: UIPickerView!
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        
        let stateRow = dependentPicker.selectedRow(inComponent: stateComponent)
        let zipRow = dependentPicker.selectedRow(inComponent: zipComponent)
        let state = states[stateRow]
        let zip = zips[zipRow]
        
        let title = "You selected zip code \(zip)"
        let message = "\(zip) is in \(state)"
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let bundle = Bundle.main  // получаем ссылку на основной пакет приложения
        
        let plistURL = bundle.url(forResource:"statedictionary", withExtension: "plist")
        stateZips = (NSDictionary.init(contentsOf: plistURL!) as! [String : [String]])
        let allStates = stateZips.keys
        states = allStates.sorted()
        let selectedState = states[0]
        zips = stateZips[selectedState]
    }
    
    // MARK:-
    // MARK: Picker Data Source Methods

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2  // возвращаем количество компонентов селектора
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // возвращаем количество значений для каждого компонента
        if component == stateComponent {
            return states.count
        } else {
            return zips.count
        }
    }

    // MARK:-
    // MARK: Picker Delegate Methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {  // загрузка значений в селектор
        if component == stateComponent {
            return states[row]
        } else {
            return zips[row]
        }
    }
    
    // вызывается при изменении выбранной строки в компоненте селектора
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == stateComponent {
            let selectedState = states[row]
            zips = stateZips[selectedState]
            dependentPicker.reloadComponent(zipComponent)
            dependentPicker.selectRow(0, inComponent: zipComponent, animated: true)
        }
    }

    // устанавливаем требуемую ширину компонента
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let pickerWidth = pickerView.bounds.size.width
        if component == zipComponent {
            return pickerWidth / 3      // если индекс, то ширина 1/3
        } else {
            return 2 * pickerWidth / 3  // если штат, то ширина 2/3
        }
    }
}
