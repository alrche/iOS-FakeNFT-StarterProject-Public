// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L {
  /// Потяните, чтобы обновить
  public static let ptr = L.tr("Localizable", "ptr", fallback: "Потяните, чтобы обновить")
  public enum Alert {
    /// Отменить
    public static let cancel = L.tr("Localizable", "alert.cancel", fallback: "Отменить")
    /// Закрыть
    public static let close = L.tr("Localizable", "alert.close", fallback: "Закрыть")
    /// Нет
    public static let no = L.tr("Localizable", "alert.no", fallback: "Нет")
    /// Localizable.strings
    ///   FakeNFT
    /// 
    ///   Created by Aliaksandr Charnyshou on 11.12.2024.
    public static let ok = L.tr("Localizable", "alert.ok", fallback: "ОК")
    /// Повторить
    public static let `repeat` = L.tr("Localizable", "alert.repeat", fallback: "Повторить")
    /// Попробовать еще раз
    public static let tryAgain = L.tr("Localizable", "alert.tryAgain", fallback: "Попробовать еще раз")
    /// Да
    public static let yes = L.tr("Localizable", "alert.yes", fallback: "Да")
    public enum Sort {
      /// По количеству NFT
      public static let amount = L.tr("Localizable", "alert.sort.amount", fallback: "По количеству NFT")
      /// По названию
      public static let name = L.tr("Localizable", "alert.sort.name", fallback: "По названию")
      /// По цене
      public static let price = L.tr("Localizable", "alert.sort.price", fallback: "По цене")
      /// По рейтингу
      public static let rating = L.tr("Localizable", "alert.sort.rating", fallback: "По рейтингу")
      /// Сортировка
      public static let title = L.tr("Localizable", "alert.sort.title", fallback: "Сортировка")
    }
  }
  public enum Cart {
    /// Вернуться в каталог
    public static let backCataloge = L.tr("Localizable", "cart.backCataloge", fallback: "Вернуться в каталог")
    /// Корзина пуста
    public static let cartEmpty = L.tr("Localizable", "cart.cartEmpty", fallback: "Корзина пуста")
    /// Выберите способ оплаты
    public static let choosePay = L.tr("Localizable", "cart.choosePay", fallback: "Выберите способ оплаты")
    /// Удалить
    public static let delete = L.tr("Localizable", "cart.delete", fallback: "Удалить")
    /// Вы уверены, что хотите
    /// удалить объект из корзины?
    public static let deleteQuestion = L.tr("Localizable", "cart.deleteQuestion", fallback: "Вы уверены, что хотите\nудалить объект из корзины?")
    /// Не удалось произвести
    /// оплату
    public static let failurePay = L.tr("Localizable", "cart.failurePay", fallback: "Не удалось произвести\nоплату")
    /// Проблема с интернет-соединением
    public static let networkAlertMessage = L.tr("Localizable", "cart.networkAlertMessage", fallback: "Проблема с интернет-соединением")
    /// Что-то пошло не так(
    public static let networkAlertTitle = L.tr("Localizable", "cart.networkAlertTitle", fallback: "Что-то пошло не так(")
    /// Оплатить
    public static let pay = L.tr("Localizable", "cart.pay", fallback: "Оплатить")
    /// Цена
    public static let price = L.tr("Localizable", "cart.price", fallback: "Цена")
    /// Вернуться
    public static let `return` = L.tr("Localizable", "cart.return", fallback: "Вернуться")
    /// Успех! Оплата прошла,
    /// поздравляем с покупкой!
    public static let successPay = L.tr("Localizable", "cart.successPay", fallback: "Успех! Оплата прошла,\nпоздравляем с покупкой!")
    /// Корзина
    public static let title = L.tr("Localizable", "cart.title", fallback: "Корзина")
    /// К оплате
    public static let toBePaid = L.tr("Localizable", "cart.toBePaid", fallback: "К оплате")
    /// Пользовательского соглашения
    public static let userAgreementEnd = L.tr("Localizable", "cart.userAgreementEnd", fallback: "Пользовательского соглашения")
    /// Совершая покупку, вы соглашаетесь с условиями
    public static let userAgreementStart = L.tr("Localizable", "cart.userAgreementStart", fallback: "Совершая покупку, вы соглашаетесь с условиями")
  }
  public enum Catalog {
    /// Добавить в корзину
    public static let addToCart = L.tr("Localizable", "catalog.addToCart", fallback: "Добавить в корзину")
    /// Автор коллекции:
    public static let collectionAuthor = L.tr("Localizable", "catalog.collectionAuthor", fallback: "Автор коллекции:")
    /// ETH
    public static let eth = L.tr("Localizable", "catalog.ETH", fallback: "ETH")
    /// Открыть Nft
    public static let openNft = L.tr("Localizable", "catalog.openNft", fallback: "Открыть Nft")
    /// Каталог
    public static let title = L.tr("Localizable", "catalog.title", fallback: "Каталог")
  }
  public enum Network {
    public enum Error {
      /// Что-то пошло не так
      public static let httpStatusCode = L.tr("Localizable", "network.error.httpStatusCode", fallback: "Что-то пошло не так")
      /// Слишком много запросов. Попробуйте снова позже.
      public static let httpStatusCode429 = L.tr("Localizable", "network.error.httpStatusCode429", fallback: "Слишком много запросов. Попробуйте снова позже.")
      /// Ошибка клиента
      public static let httpStatusCode4xx = L.tr("Localizable", "network.error.httpStatusCode4xx", fallback: "Ошибка клиента")
      /// Ошибка сервера
      public static let httpStatusCode5xx = L.tr("Localizable", "network.error.httpStatusCode5xx", fallback: "Ошибка сервера")
      /// Не удалось обработать ответ сервера
      public static let parsingError = L.tr("Localizable", "network.error.parsingError", fallback: "Не удалось обработать ответ сервера")
      /// Что-то пошло не так
      public static let urlRequestError = L.tr("Localizable", "network.error.urlRequestError", fallback: "Что-то пошло не так")
      /// Что-то пошло не так
      public static let urlSessionError = L.tr("Localizable", "network.error.urlSessionError", fallback: "Что-то пошло не так")
    }
  }
  public enum Profile {
    /// О разработчике
    public static let about = L.tr("Localizable", "profile.about", fallback: "О разработчике")
    /// Описание
    public static let description = L.tr("Localizable", "profile.description", fallback: "Описание")
    /// Plural format key: "%#@VARIABLE@"
    public static func favouriteNFT(_ p1: Int) -> String {
      return L.tr("Localizable", "profile.favouriteNFT", p1, fallback: "Plural format key: \"%#@VARIABLE@\"")
    }
    /// Plural format key: "%#@VARIABLE@"
    public static func myNFT(_ p1: Int) -> String {
      return L.tr("Localizable", "profile.myNFT", p1, fallback: "Plural format key: \"%#@VARIABLE@\"")
    }
    /// Имя
    public static let name = L.tr("Localizable", "profile.name", fallback: "Имя")
    /// Профиль
    public static let title = L.tr("Localizable", "profile.title", fallback: "Профиль")
    /// Сайт
    public static let website = L.tr("Localizable", "profile.website", fallback: "Сайт")
    public enum AboutDeveloper {
      /// О разработчике
      public static let title = L.tr("Localizable", "profile.aboutDeveloper.title", fallback: "О разработчике")
    }
    public enum Alert {
      /// Произошла ошибка во время изменения данных профиля
      public static let editError = L.tr("Localizable", "profile.alert.editError", fallback: "Произошла ошибка во время изменения данных профиля")
      /// Произошла ошибка во время загрузки профиля
      public static let fetchError = L.tr("Localizable", "profile.alert.fetchError", fallback: "Произошла ошибка во время загрузки профиля")
      /// Вы хотите сохранить изменения?
      public static let saveChanges = L.tr("Localizable", "profile.alert.saveChanges", fallback: "Вы хотите сохранить изменения?")
      /// Произошла ошибка при парсинге ссылки
      public static let urlError = L.tr("Localizable", "profile.alert.urlError", fallback: "Произошла ошибка при парсинге ссылки")
      public enum Avatar {
        /// Введите URL
        public static let placeholder = L.tr("Localizable", "profile.alert.avatar.placeholder", fallback: "Введите URL")
        /// Введите URL нового фото
        public static let subtitle = L.tr("Localizable", "profile.alert.avatar.subtitle", fallback: "Введите URL нового фото")
        /// Сменить фото
        public static let title = L.tr("Localizable", "profile.alert.avatar.title", fallback: "Сменить фото")
      }
    }
    public enum Avatar {
      /// Сменить
      /// фото
      public static let change = L.tr("Localizable", "profile.avatar.change", fallback: "Сменить\nфото")
    }
    public enum FavouriteNFT {
      /// У Вас еще нет избранных NFT
      public static let empty = L.tr("Localizable", "profile.favouriteNFT.empty", fallback: "У Вас еще нет избранных NFT")
      /// Ничего не найдено
      public static let nothingFound = L.tr("Localizable", "profile.favouriteNFT.nothingFound", fallback: "Ничего не найдено")
      /// Избранные NFT
      public static let title = L.tr("Localizable", "profile.favouriteNFT.title", fallback: "Избранные NFT")
      public enum Alert {
        /// Произошла ошибка во время загрузки избранных NFT
        public static let fetchError = L.tr("Localizable", "profile.favouriteNFT.alert.fetchError", fallback: "Произошла ошибка во время загрузки избранных NFT")
        /// Произошла ошибка во время снятия лайка
        public static let unlikeError = L.tr("Localizable", "profile.favouriteNFT.alert.unlikeError", fallback: "Произошла ошибка во время снятия лайка")
      }
      public enum Search {
        /// Введите название избранного NFT
        public static let placeholder = L.tr("Localizable", "profile.favouriteNFT.search.placeholder", fallback: "Введите название избранного NFT")
      }
    }
    public enum MyNFT {
      /// У Вас еще нет NFT
      public static let empty = L.tr("Localizable", "profile.myNFT.empty", fallback: "У Вас еще нет NFT")
      /// Ничего не найдено
      public static let nothingFound = L.tr("Localizable", "profile.myNFT.nothingFound", fallback: "Ничего не найдено")
      /// Мои NFT
      public static let title = L.tr("Localizable", "profile.myNFT.title", fallback: "Мои NFT")
      public enum Alert {
        /// Произошла ошибка во время загрузки NFT
        public static let fetchError = L.tr("Localizable", "profile.myNFT.alert.fetchError", fallback: "Произошла ошибка во время загрузки NFT")
      }
      public enum Author {
        /// от
        public static let title = L.tr("Localizable", "profile.myNFT.author.title", fallback: "от")
      }
      public enum Price {
        /// Цена
        public static let title = L.tr("Localizable", "profile.myNFT.price.title", fallback: "Цена")
      }
      public enum Search {
        /// Введите название NFT или имя автора
        public static let placeholder = L.tr("Localizable", "profile.myNFT.search.placeholder", fallback: "Введите название NFT или имя автора")
      }
    }
  }
  public enum Statistics {
    /// По имени
    public static let byName = L.tr("Localizable", "statistics.byName", fallback: "По имени")
    /// По рейтингу
    public static let byRating = L.tr("Localizable", "statistics.byRating", fallback: "По рейтингу")
    /// Закрыть
    public static let close = L.tr("Localizable", "statistics.close", fallback: "Закрыть")
    /// Коллекция NFT
    public static let collectionNFT = L.tr("Localizable", "statistics.collectionNFT", fallback: "Коллекция NFT")
    /// Проблемы с интернет соединением
    public static let error = L.tr("Localizable", "statistics.Error", fallback: "Проблемы с интернет соединением")
    /// Еще раз
    public static let errorAction = L.tr("Localizable", "statistics.ErrorAction", fallback: "Еще раз")
    /// Выход
    public static let errorActionCancel = L.tr("Localizable", "statistics.ErrorActionCancel", fallback: "Выход")
    /// Перейти на сайт пользователя
    public static let goToWebsite = L.tr("Localizable", "statistics.goToWebsite", fallback: "Перейти на сайт пользователя")
    /// Тут пусто
    public static let isEmpty = L.tr("Localizable", "statistics.isEmpty", fallback: "Тут пусто")
    /// Сортировка
    public static let sorted = L.tr("Localizable", "statistics.sorted", fallback: "Сортировка")
    /// Статистика
    public static let title = L.tr("Localizable", "statistics.title", fallback: "Статистика")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
