---
created_date: 18-10-2024
created_time: 17:25
tags: interview
---
### Что такое индекс?

**Индекс** — это специальная структура данных, создаваемая в базе данных для ускорения поиска строк в таблице. Индексы используются для оптимизации выполнения SQL-запросов, особенно тех, которые часто используют команды выборки (`SELECT`), фильтрации (`WHERE`), сортировки (`ORDER BY`) и объединения (`JOIN`).

В PostgreSQL по умолчанию создаются **B-Tree индексы**. При использовании команды `CREATE INDEX` без указания типа индекса, PostgreSQL создает индекс с использованием структуры **B-дерево** (B-Tree).

### Основные виды индексов

1. **B-Tree (балансированные деревья)**
    
    Это наиболее распространенный и стандартный тип индексов в большинстве реляционных баз данных (включая PostgreSQL, MySQL и др.). B-дерево хорошо подходит для поиска по диапазонам значений, равенству, сортировке и группировке.
    
    **Когда использовать B-Tree**:
    
    - Фильтрация по диапазону значений (`WHERE salary BETWEEN 50000 AND 100000`).
    - Сортировка (`ORDER BY`).
    - Условие равенства (`WHERE`).

2. **Hash-индексы**
    
    Этот тип индекса использует хэш-функции для быстрого поиска данных по **равенству**. Однако они не поддерживают поиск по диапазонам или сортировке.
    
    **Когда использовать Hash-индексы**:
    
    - Когда важно очень быстрое сравнение на равенство (`WHERE email = 'someone@example.com'`).
    - В PostgreSQL, Hash-индексы менее популярны, так как B-Tree индекс может выполнять те же операции и быть более универсальным.

3. **GIN и GiST индексы**
    
    Эти индексы используются для поиска по сложным структурам данных, таким как массивы, JSON, географические данные, текстовые поиски и т. д.
    
    - **GIN (Generalized Inverted Index)** — используется для индексации многозначных полей, таких как массивы, JSON и текстовые данные.
    - **GiST (Generalized Search Tree)** — используется для индексации геометрических данных и поиска по пространственным значениям.
    
    **Когда использовать GIN и GiST**:
    
    - Для полнотекстового поиска (`FULL TEXT SEARCH`).
    - Для работы с массивами или JSON-данными.

4. **Clustered и Non-Clustered индексы** (не столь важно на данном этапе)
    
    - **Clustered индекс** определяет физический порядок строк в таблице. В PostgreSQL нет явной поддержки clustered индексов, как в некоторых других СУБД, но можно добиться похожего поведения с помощью команды `CLUSTER`, которая перестраивает таблицу по индексу.
    - **Non-Clustered индексы** не изменяют порядок строк в таблице, но создают отдельную структуру, которая ссылается на исходные данные.

### Почему создание индекса на большой таблице медленное:

1. **Перестройка данных**:
    
    - Когда создается индекс, база данных должна **прочитать все существующие данные** в указанной таблице и **создать для них индексную структуру**. Это значит, что для каждой записи необходимо создать соответствующую запись в индексе, что требует времени.
    - Чем больше записей в таблице, тем дольше будет создаваться индекс.
2. **Использование CPU и диска**:
    
    - Создание индекса требует значительных ресурсов процессора (CPU) для сортировки данных и построения индексной структуры (например, **B-Tree**).
    - Также идет интенсивное использование диска для записи индексных данных, что может повлиять на производительность других запросов.
3. **Блокировки**:
    
    - В зависимости от типа индекса и базы данных, создание индекса может потребовать **блокировки таблицы**. Это может временно ограничить возможность выполнения других операций на таблице (например, вставок, обновлений или чтения).
    - В PostgreSQL для некоторых типов индексов, таких как GIN, можно использовать **параметр CONCURRENTLY**, который позволяет создавать индекс, не блокируя таблицу на запись. Но это требует больше времени и ресурсов:


<font color="#ff0000">Важно</font>
- Для небольших таблиц затраты на использование индекса могут превышать затраты на сканирование всех строк.
- Если в результате запроса находится большое количество строк, использование индекса может оказаться не таким эффективным. PostgreSQL, по сути, использует индекс для поиска, но затем все равно нужно прочитать и вернуть все совпавшие строки.
- Если запрос возвращает большое количество строк (например, более 50% всех записей), PostgreSQL часто предпочитает использовать `Seq Scan`, поскольку он может быть быстрее, чем обращение к индексу.

### Факторы, влияющие на выбор между `Seq Scan` и `Index Scan`:

1. **Процент возвращаемых строк**:
    
    - Если запрос потенциально возвращает **большую долю строк** в таблице, PostgreSQL может выбрать **последовательное сканирование** (`Seq Scan`), поскольку чтение таблицы целиком в таком случае становится выгоднее.
    - Грубо говоря, если запрос выбирает более **10-15% строк** (хотя точное значение зависит от конкретного случая), планировщик может считать, что последовательное сканирование таблицы будет быстрее, чем обращение к индексу.
    - Это связано с тем, что при использовании индекса потребуется сначала найти все нужные строки в индексе, а затем обратиться к самим данным для чтения. Если нужно прочитать почти все строки, то это дополнительное обращение к индексу может быть менее эффективным.

Все можно протестировать скриптами