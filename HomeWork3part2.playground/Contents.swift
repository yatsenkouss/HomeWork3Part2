import Foundation

/*
 
 Домашнє завдання 3
 
 Частина 2
 
 Є готовий код, але він виконується з помилками. Необхідно їх виправити.
 
 Код нижче умовно можна розділити на 2 секції:
    1 - опис своїх типів (або резервування типів) для їх подальшого використання,
        що виконується не одразу, а десь далі у реалізації сценаріїв, або конкретних дій, або логіки.
    2 - створення констант/змінних для зберігання "екземплярів" (instanse).
        Тобто, щоб звернутися до змінної/поля, або функції, описаної в класі/структурі та записати/прочитати значення,
        необхідно виділити пам'ять, якось її назвати та сказати якого типу вона буде,
        чи простого (String/Int/Double/...), чи того типу, який ви описали (enum/class/struct)
 
 Також, спробуйте подивитись та проаналізувати написаний код - це простенький приклад, як краще і зручніше
 організувати та реалізовувати логіку задач.
 
 Так, можна написати все в одному файлі, або в одному місці і воно працюватиме.
 
 Але, краще відокремити різну логіку в різні області видимості {  } та дати цьому відповідну назву,
 а тоді використовувати, де це необхідно, посилаючись на назву
 
 */


// СЕКЦІЯ 1 - Резервування або опис своїх типів, які будуть використовуватися (ініціюватися та викликатися) у секції 2


// Псевдонім для зберігання деталей товару
typealias ProductInfo = (String, Double, String, String, String)

// Перечислення/Enum - зарезервовано для опису типу знижки
enum Discount {
    case regular
    case vip
    case none
}

// Перечислення/Enum - зарезервовано для опису типу процессора
enum ProcessorType: String {
    case intel = "Intel"
    case amd = "AMD"
    case none = ""
}

// Перечислення/Enum - зарезервовано для опису типу валюти
enum Currency: String {
    case uah = "₴"
    case usd = "$"
    case eur = "€‎‎"
}

// Структура - зарезервовано для опису Материнської плати і зберігання віповідних значень
struct MotherBoard {
    var socet = ""
    var processor: ProcessorType = .intel
}

// Клас - зарезервовано для опису типу продукта і зберігання віповідних значень,
// також має функцію, яка повертає усі значення у тектовому вігляді в певному форматі
class Product {
    // Поля класу
    var name = ""
    var price: Double = 0.0
    var currency: Currency = .uah
    var motherBoard = MotherBoard()
    
    // Функції класу
    func textDescription() -> String {
        
        let stringPrice = String(format: "%.2f", price)
        
        let firstLine = "Назва продукту: \(name), Ціна: \(currency.rawValue) \(stringPrice)"
        let secondLine = "Сокет: \(motherBoard.socet), Процессор: \(motherBoard.processor.rawValue)"
        
        return firstLine + "\n" + secondLine
    }
}

// Клас - зарезервовано для опису типу Кошик і зберігання віповідних значень,
// має декілька функцій для дій з масивом продуктів у кошику
class Cart {
    
    var products: [Product] = []
    var discount: Discount = .none
    
    func removeSelectedProduct(at index: Int) {
        products.remove(at: index)
    }
    
    func clear() {
            products.removeAll()
    }
    
    func totalPrice() -> Double {
        
        var resultPrice: Double = 0.0
        
        for product in products {
            resultPrice += product.price
        }
        
        return resultPrice
    }
    
    func discountPercentValue() -> Int {
        switch discount {
        case .regular:
            return 5
        case .vip:
            return 15
        case .none:
            return 0
        }
    }
    
    func totalPriceWithDiscount() -> Double {
        let price = totalPrice()
        let result = price - (price * (Double(discountPercentValue()) / 100.0) )
        
        return result
    }
}

// Структура - зарезервовано для опису типу Результат Сервера і зберігання списку товарів для виводу в консоль
struct ResponseFromServer {
    // Ціни взяв з розетки 🙃
    let sourceProducts: [ProductInfo] = [
        (productName: "ASRock H310CV-HDV", price: 1717.0, currency: "₴", socet: "s1151", processor: "Intel"),
        (productName: "Asus Prime H310M-E R2.0", price: 2299.0, currency: "₴", socet: "s1151", processor: "Intel"),
        (productName: "Gigabyte H310M H", price: 1939.0, currency: "₴", socet: "s1151", processor: "Intel"),
        (productName: "ASRock Q270 PRO BTC+", price: 4599.0, currency: "₴", socet: "s1151", processor: "Intel"),
        (productName: "Biostar H310MHP", price: 1698.0, currency: "₴", socet: "s1151", processor: "Intel"),
        (productName: "MSI H30M Pro-VDN", price: 1649.0, currency: "₴", socet: "s1151", processor: "Intel"),
        (productName: "Asus WS C246 Pro", price: 10979.0, currency: "₴", socet: "s1151", processor: "Intel"),
        (productName: "Gigabyte B550 AORUS Elite", price: 5599.0, currency: "₴", socet: "sAM4", processor: "AMD"),
        (productName: "Asus TUF Gaming B550-Plus", price: 5798.0, currency: "₴", socet: "sAM4", processor: "AMD"),
        (productName: "Asus TUF Gaming B550M-Plus", price: 4799.0, currency: "₴", socet: "sAM4", processor: "AMD"),
        (productName: "Gigabyte B550M Aorus Elite", price: 4446.0, currency: "₴", socet: "sAM4", processor: "AMD"),
        (productName: "Asus TUF Gaming B550-Plus Wi-Fi II", price: 6599.0, currency: "₴", socet: "sAM4", processor: "AMD"),
        (productName: "Asus ROG Strix B550-A Gaming", price: 6999.0, currency: "₴", socet: "sAM4", processor: "AMD"),
        (productName: "Asus ROG Strix B550-E Gaming", price: 8703.0, currency: "₴", socet: "sAM4", processor: "AMD")
    ]
    
    func get3Products() -> [ProductInfo] {
        return sourceProducts.shuffled().suffix(3)
    }
}

// Клас - зарезервовано для опису типу DataMapper.
// Основна задача цього класу - це конвертування данних
// записаних у Псевдонимі ProductInfo у дані, які описані класом Product
// по суті переписати все з ProductInfo у Product, бо це 2 різні типи, наприклад різні, як Int і Double.
class DataMapper {
    
    func products(from productInfoList: [ProductInfo]) -> [Product] {
        
        var productList = [Product]()
        
        for productInfo in productInfoList {
            let product = convertToProduct(from: productInfo)
            productList.append(product)
        }
        
        return productList.shuffled()
    }
    
    func convertToProduct(from productInfo: ProductInfo) -> Product {
        
        let product = Product()
        
        product.name = productInfo.0
        product.price = productInfo.1
        product.currency = Currency(rawValue: productInfo.2) ?? .uah
        
        var motherBoard = MotherBoard()
        motherBoard.socet = productInfo.3
        motherBoard.processor = ProcessorType(rawValue: productInfo.4) ?? .none
        
        product.motherBoard = motherBoard
        
        return product
    }
}

// Клас - зарезервовано для опису типу Sceen - його задача вивести інформацію у консоль
// залежно від Кошика
class Screen {
    
    func printCheck(cart: Cart) {
        
        if cart.products.isEmpty {
                print("Кошик пустий. Для оформлення замовлення додайте хоча б один товар")
                return
            }
        
        var resultStringToPrint = ""
        
        let firstLine = "--------------- ФІСКАЛЬНИЙ ЧЕК ----------------"
        resultStringToPrint += firstLine
        
        let separatorLine = "\n-----------------------------------------------"
        
        for index in 0 ..< cart.products.count {
            let product = cart.products[index]
            resultStringToPrint += "\n\(index + 1)\n"
            resultStringToPrint += product.textDescription()
        }
        
        resultStringToPrint += separatorLine
        
        resultStringToPrint += "\nTotal price: \(String(format: "%.2f", cart.totalPrice())) UAH"
        resultStringToPrint += "\nDiscount: \(cart.discountPercentValue())%"
        
        resultStringToPrint += separatorLine
        
        resultStringToPrint += "\nTotal price with Discount:\n\(String(format: "%.2f", cart.totalPriceWithDiscount())) UAH"
        
        resultStringToPrint += separatorLine + separatorLine
        
        print(resultStringToPrint)
    }
    
    func printCart(cart: Cart, currency: Currency) {
        
        let usd = 36.57 // 1 долар коштує 36.57 грн.
        let eur = 40.32 // 1 євро коштує 40.32 грн.
        
        var selectedCurrencyValue = 0.0
        
        switch currency {
        case .usd:
            selectedCurrencyValue = usd
        case .eur:
            selectedCurrencyValue = eur
        case .uah:
            selectedCurrencyValue = 1.0
        }
        
        var resultStringToPrint = ""
        
        resultStringToPrint += "------------------------ Обрана валюта: \(currency.rawValue) ---------------------------"
        
        var resultProducts = cart.products.compactMap { $0 }
        
        for index in 0 ..< resultProducts.count {
            let product = cart.products[index]
            let productprice = product.price / selectedCurrencyValue
            
            resultStringToPrint += "\n\(index + 1) "
            resultStringToPrint += "Назва продукту: \(product.name), "
            resultStringToPrint += "Ціна: \(currency.rawValue) \(String(format: "%.2f", productprice))"
        }
        
        resultStringToPrint += "\n---------------------------------------------------------------------"
        
        print(resultStringToPrint)
    }
}

// КІНЕЦЬ СЕКЦІЇ 1



// СЕКЦІЯ 2 - Використання типів, описаних у секції 1


/*
 
 Пункт 1
 
 1  Розкоментуйте код нижче
    між коментарем:
        Початок коду сценарію для Пункт 1
    та коментарем:
        Кінець коду сценарію для Пункт 1

 2 Запустіть код і в консолі побачите друк чеку для всіх продуктів у корзині Користувача
 3 Користувач має VIP знижку (discount), але йому друкується чек з ціною без урахування знижки
 
 Необхідно виправити код виконання сценарію, щоб користувачу друкувався чек з ціною, яка враховує знижку VIP
 
 !! Код з Пункту 1 буде використовуватися у сценарію Пункта 2
 
 */

// Початок коду сценарію для Пункт 1



print("SCENARIO 1:\n")

// Створюємо константу для зберігання "екземпляру" (instanse) ResponseFromServer
let responseFromServer = ResponseFromServer()
// Створюємо константу для зберігання списку товарів, які отримали з сервера,
// у якомусь не дуже зручному форматі (у даному випадку Tuples)
let receivedProducts = responseFromServer.sourceProducts
// Створюємо константу для зберігання "екземпляру" (instanse) DataMapper
let dataMapper = DataMapper()

// Створюємо константу для зберігання "екземпляру" (instanse) Cart
let cart = Cart()
// Звертаємось до поля (змінної класу Cart), щоб записати в неї масив сконвертованих даних
cart.products = dataMapper.products(from: receivedProducts)
// Звертаємось до поля (змінної класу Cart), щоб записати значення discount
cart.discount = .vip

// Створюємо константу для зберігання "екземпляру" (instanse) Screen
let screen = Screen()
// Викликаємо метод printCheck для друку у консоль
// і передаємо константу cart як параметр у функцію
screen.printCheck(cart: cart)



// Кінець коду сценарію для Пункт 1


/*
 
 Пункт 2
 
 Опис сценарію пункта 2:
 
    Інший розробник, який писав код, дуже поспішав і не первірив його виконання,
    відправив додаток на тестування і поїхав у своїх справах.

    Тестувальник звернувся до вас з проханням швидко виправити знайдений критичний баг і надіслав наступний опис:
    
    1 Користувач обрав три продукти
    2 Користувач вирішив очистити кошик, натиснувши кнопку Clear,
    3 Додаток аварійно завершився (crash)
 
    Задача:
    - Виправити crash, який виникає при натисканні на кнопку Clear
    - Якщо кошик порожній і користувач натискає кнопку "Оформити замовлення",
      замість чеку з нулями має виводитись текст:
        "Кошик пустий. Для оформлення замовлення додайте хоча б один товар"
 
    * Примітка:
        Дію кнопки Clear виконує функція з назвою clear()
 
 
 1  Розкоментуйте код нижче
    між коментарем:
        Початок коду сценарію для Пункт 2
    та коментарем:
        Кінець коду сценарію для Пункт 2

 2 Запустіть код і ви побачите підсвітку червоним, що є crash
 
 Необхідно знайти та виправити помилку, щоб не було crash
 
 !! Код з Пункту 1 буде використовуватися у сценарію Пункта 3
 
 */


// Початок коду сценарію для Пункт 2


 
print("\nSCENARIO 2:\n")

// Користувач додає три товари у кошик
cart.products = dataMapper.products(from: responseFromServer.get3Products())
// Користувач натискає десь на екрані кнопку "Очистити кошик" (Clear)
cart.clear()

// Користувач натискає кнопку "Оформити замовлення", щоб побачити чек
screen.printCheck(cart: cart)

 

// Кінець коду сценарію для Пункт 2



/*
 
 Пункт 3
 
 Опис сценарію пункта 3:
 
    Інший розробник, який писав код, відійшов по каву, а його кіт пробігся по клавіатурі.
    Коли розробник повернувся, то не помітив ніяких змін (тому, що не підключив git, де видно всі зміни 😅)
    і відправив build (збірку/додаток) на тестування.

    Тестувальник звернувся до вас з проханням швидко виправити знайдений баг і надіслав наступний опис:
    
    1 Користувач обрав додав продукти (кількість не має значення)
    2 Користувач вирішив подивитись ціни у різних валютах
    3 Коли кооистувач зміню валюту на USD або EUR - символ валюти змінюється, а ціна залишається у гривнях
 
    Задача:
    - Виправити логіку відображення цін відповідно до обраної валюти
 
 
 1  Розкоментуйте код нижче
    між коментарем:
        Початок коду сценарію для Пункт 3
    та коментарем:
        Кінець коду сценарію для Пункт 3

 2 Запустіть код і ви побачите в консолі 3 списки товарів з цінами у різних валютах
 
 Необхідно знайти та виправити помилку, щоб ціни відповідали обраній валюті
 
 */


// Початок коду сценарію для Пункт 3



print("\nSCENARIO 3:\n")

// Користувач обирає якусь кількість товарів
cart.products = dataMapper.products(from: responseFromServer.sourceProducts)

// Користувач натискає кнопку зміни валюти на UAH
screen.printCart(cart: cart, currency: .uah)
// Користувач натискає кнопку зміни валюти на USD
screen.printCart(cart: cart, currency: .usd)
// Користувач натискає кнопку зміни валюти на EUR
screen.printCart(cart: cart, currency: .eur)

 
// Кінець коду сценарію для Пункт 3


// КІНЕЦЬ СЕКЦІЇ 2
