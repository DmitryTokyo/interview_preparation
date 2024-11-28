import logging
import grpc
import user_pb2_grpc
import user_pb2


def get_user(stub):
    response = stub.GetUser(user_pb2.UserRequest(id=1))
    print(f"User info: ID={response.id}, Name={response.name}, Age={response.age}")

def create_user(stub):
    response = stub.CreateUser(user_pb2.CreateUserRequest(name='John', age=15))
    print(f"Created user: ID={response.id}, Name={response.name}, Age={response.age}")


def run():
    with grpc.insecure_channel("localhost:50051") as channel:
        stub = user_pb2_grpc.UserServiceStub(channel)
        print("-------------- GetUser --------------")
        get_user(stub)
        print("-------------- CreateUser --------------")
        create_user(stub)


if __name__ == "__main__":
    logging.basicConfig()
    run()