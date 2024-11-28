import json
import user_pb2

# Пример объекта
data = {
    "id": 1,
    "name": "John Doe",
    "age": 30,
    "email": "johndoe@example.com",
    "address": "1234 Elm Street, Springfield, USA"
}

# JSON сериализация
json_data = json.dumps(data)
json_size = len(json_data)
print(f"JSON size: {json_size} bytes")

# Protobuf сериализация
proto_user = user_pb2.UserResponse(
    id=data["id"],
    name=data["name"],
    age=data["age"]
)
proto_data = proto_user.SerializeToString()
proto_size = len(proto_data)
print(f"Protobuf size: {proto_size} bytes")
