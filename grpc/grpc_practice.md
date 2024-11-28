## Установка окружения

Установка gRPC и необходимых библиотек:
[Tutorial](https://grpc.io/docs/languages/python/quickstart/)

Устанавливаем в окружение
````shell
python3 -m venv .venv
pip install grpcio grpcio-tools
````

Проходим [Quick start](https://grpc.io/docs/languages/python/quickstart/) и [Basic tutorial](https://grpc.io/docs/languages/python/basics/)

## Проба самостоятельно накидать сервис
### **Задание: gRPC-сервис для работы с пользователями**
1. Сервис будет называться `UserService`.
2. Добавим два метода:
    - **`GetUser`**: принимает запрос с `user_id` и возвращает информацию о пользователе (имя и возраст).
    - **`CreateUser`**: принимает запрос с именем и возрастом, возвращает подтверждение успешного создания с новым `user_id`.
3. Сообщения будут такие:
    - **`UserRequest`** для получения данных по ID.
    - **`UserResponse`** для информации о пользователе.
    - **`CreateUserRequest`** для создания нового пользователя.
    - **`CreateUserResponse`** для подтверждения создания.

- создаем папку `protos` и помещаем туда файл `userservice.proto` 
- компилируем
```bash
python -m grpc_tools.protoc -Iprotos --python_out=. --grpc_python_out=. protos/user.proto
```

4. Запускаем в первом окне терминала сервер `python user_service_server.py`. Во втором окне запускаем клиент `python user_service_client.py`
полученный результат
```shell
-------------- GetUser --------------
User info: ID=1, Name=Rick, Age=20
-------------- CreateUser --------------
Created user: ID=1, Name=Rick, Age=20
```

## Бенчмарки
### Размер файла
Создаем json и grpc одинаковой структуры и замеряем размер
```shell
python comparison_size.py 

JSON size: 120 bytes
Protobuf size: 14 bytes
```

### Скорость передачи данных
создаем простенький rest server и измеряем скорость запросов к нему и к серверу grpc. Измерение проводим на 1000 запросах
```sh
python user_service_server.py
python restapi_server.py
python comparison_speed.py

REST time: 1.9707789160020184 seconds
gRPC time: 0.17792554100742564 seconds
```
