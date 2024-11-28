import time
import requests
import grpc
import user_pb2
import user_pb2_grpc

# REST
def test_rest():
    url = "http://localhost:8020/users"
    start_time = time.perf_counter()
    for _ in range(1000):
        requests.post(url, json={"name": "John", "age": 30})
    end_time = time.perf_counter()
    print(f"REST time: {end_time - start_time} seconds")

# gRPC
def test_grpc():
    with grpc.insecure_channel("localhost:50051") as channel:
        stub = user_pb2_grpc.UserServiceStub(channel)
        start_time = time.perf_counter()
        for _ in range(1000):
            stub.CreateUser(user_pb2.CreateUserRequest(name="John", age=30))
        end_time = time.perf_counter()
        print(f"gRPC time: {end_time - start_time} seconds")

test_rest()
test_grpc()
