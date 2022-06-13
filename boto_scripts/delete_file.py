import boto3

s3 = boto3.client('s3')

s3.client.delete_file(
    Bucket='eng114-akshay-bucket',
    Key='hello.txt'
)