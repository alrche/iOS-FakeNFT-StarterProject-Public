Чернышев Александр\
<b>Когорта:</b> 20\
<b>Группа:</b> 3\
<b>Эпик:</b> Профиль\
<b>[Ссылка на доску](https://github.com/users/alrche/projects/1/views/1)</b>

# Декомпозиция эпика Профиль

## Модуль 1:
### Экран Профиль
- UI (est: 6 h, fact: 6 h):
    - Основная информация о пользователе - `avatar`, `name`, `description`, `website` (est: 3 h, , fact: 3 h);
    - `TableView` для перехода на экраны `MyNFT`, `FavouriteNFT`, `About` (est: 2.5 h, fact: 2.5 h);
    - `NavBar` с кнопкой `Edit` (est: 0.5 h, fact: 0.5 h).
- Сеть и логика (est: 5 h, fact: X h):
    - Загрузка данных о пользователе (est: 4 h, fact: 3.5 h)
    - Открытие экрана `Редактировать профиль` (est: 1 h, fact: 0.5 h)

`Total:` est: 11 h, fact: 10 h.

### Экран Редактировать профиль
- UI (est: 7 h, fact: 5 h):
    - `TextField` для полей `name`, `website` (est: 2 h, fact: 1 h);
    - `TextView` для поля `description` (est: 1.5 h, fact: 1 h);
    - `ImageView` для аватара с лейблом "Сменить фото" (est: 3 h, fact: 3 h);
    - Лейблы для полей и кнопка `Close` (est: 0.5 h, fact: X h).
- Сеть и логика (est: 5 h, fact: 5 h):
    - Изменение фото (est: 1.5 h, fact: 1.5 h);
    - Сохранение изменных данных о пользователе (est: 3 h, fact: 3 h);
    - Закрытие экрана (est: 0.5 h, fact: 0.5 h).

`Total:` est: 12 h, fact: 10 h.

## Модуль 2:
### Экран Мои NFT
- UI (est: 6 h, fact: X h):
    - Ячейка NFT (иконка, название, автор, цена)`TableViewCell` (est: 3 h, fact: X h);
    - Таблица, в которой лежат ячейки NFT `TableView` (est: 2 h, fact: X h);
    - `NavBar` с кнопками `Back`, `Sort` и лейблом `My NFT` (est: 1 h, fact: X h).
- Сеть (est: 5 h, fact: X h):
    - Загрузка списка NFT (est: 5 h, fact: X h);
- Сортировка (est: 5 h, fact: X h):
    - Логика сортировки и сохранение способа сортировки (est: 4 h, fact: X h);
    - `ActionSheet` (est: 1 h, fact: X h).
- Пустой экран (est: 2 h, fact: X h):
    - UI (пустой экран с лейблом и кнопкой `Back` в `NavBar` (est: 1 h, fact: X h);
    - Логика показа пустого экрана (est: 1 h, fact: X h).
    
`Total:` est: 18 h, fact: X h.

## Модуль 3:
### Экран Избранные NFT
- UI (est: 5 h, fact: X h):
    - Ячейка NFT, добавленная в избранное (иконка, сердечко, название, рейтинг, цена в ETH) `CollectionViewCell` (est: 2 h, fact: X h);
    - Коллекция NFT, доабвленных в избранное `CollectionView` (est: 2 h, fact: X h);
    - `NavBar` с кнопкой `Back` и лейблом `Favourite NFT` (est: 1 h, fact: X h).
- Сеть (est: 10 h, fact: X h):
    - Загрузка списка NFT (est: 5 h, fact: X h);
    - Лайк (est: 5 h, fact: X h).
- Пустой экран (est: 2 h, fact: X h):
    - UI (пустой экран с лейблом и кнопкой `Back` в `NavBar` (est: 1 h, fact: X h);
    - Логика показа пустого экрана (est: 1 h, fact: X h).

`Total:` est: 17 h, fact: X h.
    
## `Total:` est: 58 h, fact: X h.
