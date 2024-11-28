from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# Модель данных для запроса
class CreateUserRequest(BaseModel):
    name: str
    age: int

# Модель данных для ответа
class CreateUserResponse(BaseModel):
    id: int
    name: str
    age: int

# Хранилище ID
user_id_counter = 1

@app.post("/users", response_model=CreateUserResponse)
def create_user(request: CreateUserRequest):
    global user_id_counter
    response = CreateUserResponse(
        id=user_id_counter,
        name=request.name,
        age=request.age
    )
    user_id_counter += 1
    return response

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8020)
