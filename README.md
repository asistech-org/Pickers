Pickers
=
Реализация различных вариантов селекторов.  
Переключение между дочерними view-контроллерами с помощью панели вкладок.

### Выполнено по книге
Beginning iPhone Development with Swift 3: Exploring the iOS SDK  
by Molly Maskrey, Kim Topley, David Mark, Fredrik Olsson and Jeff Lamarche

### Описание
В качестве корневого контроллера используется экземпляр UITabBarController.

Для реализации селектора даты использован библиотечный компонент Date Picker.

Реализация протоколов UIPickerViewDataSource, UIPickerViewDelegate во всех view-контроллерах (кроме DatePicker) обеспечивает работу источника данных и делегата для каждого селектора.

Одно и двухкомпонентные селекторы хранят данные в контроллере представления.  
Для реализации селекторов использован библиотечный компонент Picker View.

Данные для зависимых компонентов селектора Dependent хранятся в property list.  
Для загрузки данных из plist в селектор используется ссылка на основной пакет приложения Bundle.main и класс NSDictionary.

Представление каждого дочернего контроллера (кроме CustomPicker) содержит кнопку для вызова всплывающего окна (экземпляр класса UIAlertController).

Звуковые эффекты в CustomPicker реализованы функциями из библиотеки AudioToolbox.

Для создания паузы используется метод asyncAfter класса DispatchQueue.

### Компоненты
UITabBarController, UITabBar, UITabBarItem

UIPickerView, UIDatePicker, UIImageView, UIImage, UIButton

UIAlertController, UIAlertAction

NSDictionary, Bundle.main, DispatchQueue

AudioServicesCreateSystemSoundID, AudioServicesPlaySystemSound
