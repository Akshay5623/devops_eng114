import boto3

s3 = boto3.client('s3')

s3.upload_file(
    Filename = "hello.txt",
    Bucket = "eng114-akshay-bucket",
    Key = "hello.txt"
)