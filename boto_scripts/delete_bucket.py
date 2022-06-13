import boto3

s3 = boto3.client('s3')

s3.client.delete_bucket(Bucket = 'eng114-akshay-bucket')