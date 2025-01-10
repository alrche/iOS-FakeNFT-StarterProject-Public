Топорин Богдан
**Когорта:** 20  
**Группа:** 3  
**Эпик:** Корзина
**[Ссылка на доску](https://github.com/users/alrche/projects/1/views/1)**

# Декомпозиция эпика Корзина
## Модуль 1:
### Экран Корзина
-   UI (est: 8 h  | fact: 5 h):
    -  `TableView` для выбранных NFT  (est: 3 h  | fact: 1.5 h);
    -  `TableViewCell` - `ImageView` , `title`, `rating`, `price` (est: 2 h  | fact: 2 h);
    -   `TableView`  для перехода на экран  `Выберите способ оплаты`  (est: 2 h  | fact: 1 h);
    -   `NavBar`  с кнопкой  `Filters`  (est: 1 h  | fact: 0.5 h).
-   Сеть и логика (est: 5 h  | fact: 3 h):
    -   Загрузка данных о выбранных NFT (est: 4 h  | fact: 3 h)

`Total:`  est: 13 h  | fact: 8 h.

## Модуль 2:
### Экран Выберите способ оплаты

-   UI (est: 6 h  | fact: 4.3 h):
    -   `CollectionView`  (est: 4 h  | fact: 3 h);
    -   `Label` для пользовательского соглашения  (est: 1 h  | fact: 1 h);
    -   `NavBar`  с кнопками  `Back`  и лейблом  `Выберите способ оплаты`  (est: 1 h  | fact: 0.3 h).
-   Сеть (est: 5 h  | fact: 3 h):
    -   Загрузка списка способ оплаты (est: 5 h  | fact: 3 h);
-   Экран успешной покупки (est: 2 h  | fact: 2 h):
    -   UI (пустой экран с лейблом, `ImageView` и кнопкой  `Back`  в  `Catalog`  (est: 1 h  | fact: 1 h);
    -   Логика показа пустого экрана (est: 1 h  | fact: 1 h).
-	Алерт ошибки покупки (est: 2h  | fact: 1 h):
	 - `Actions` - `repeat` и `reject` (est: 1h  | fact: 0.5 h)
	 - Логика `repeat` (est: 1h  | fact: 0.5 h)
	 
`Total:`  est: 15 h  | fact: 10.3 h.

## Module 3:
### Сортировка NFT
-   UI (est: 5 h  | fact: 3 h):
    -   `TableViewCell`  (est: 2 h  | fact: 1 h);
    -   `TableView`  (est: 2 h  | fact: 1 h);
    -   `Alert`  с кнопкой  `Back`, `TableView` и лейблом `Сортировка`  (est: 1 h  | fact: 1 h).
-   Сеть (est: 4 h  | fact: 2 h):
    -   Логика сортировки (est: 4h  | fact: 2 h)
-   Пустой экран (est: 1.5 h  | fact: 1 h):
    -   UI (пустой экран с лейблом (est: 0.5 h  | fact: 0.5 h);
    -   Логика показа пустого экрана (est: 1 h  | fact: 0.5 h).

`Total:`  est: 9.5 h  | fact: 5 h.

### Экран Удаление NFT
-   UI (est: 7 h  | fact: 3 h):
    -  `ImageView` для картинки выбранной NFT  (est: 3 h  | fact: 1 h);
    - `Label` для предупреждения (est: 1h  | fact: 1 h);
    - `Stackview` для кнопок `Delete` и `Return` (est: 3h  | fact: 1 h);
-   Сеть и логика (est: 5 h  | fact: 3.5 h):
    -   Открытие экрана  `Удаление NFT`  (est: 1 h  | fact: 1 h)
    -   Удаление NFT (est: 1.5 h  | fact: 1 h);
    -   Сохранение измененных данных о выбранных NFT (est: 3 h  | fact: 1 h);
    -   Закрытие экрана (est: 0.5 h  | fact: 0.5 h).

`Total:`  est: 12 h  | fact: 7.5 h.

## `Total:`  est: 49.5 h  | fact: 30.8 h.
