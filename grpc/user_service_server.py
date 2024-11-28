from concurrent import futures
import logging
import user_pb2_grpc
import user_pb2
import grpc


class UserServicer(user_pb2_grpc.UserServiceServicer):
    
    def GetUser(self, request, context):
        return user_pb2.UserResponse(id=request.id, name="Rick", age=20)
    
    def CreateUser(self, request, context):
        new_id = 1
        return user_pb2.CreateUserResponse(id=new_id, name='Rick', age=20)


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    user_pb2_grpc.add_UserServiceServicer_to_server(UserServicer(), server)
    server.add_insecure_port("[::]:50051")
    server.start()
    print("Server started on port 50051")
    server.wait_for_termination()


if __name__ == "__main__":
    logging.basicConfig()
    serve()