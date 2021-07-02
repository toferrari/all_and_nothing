import boto3


def handler(event, context):
    dynamodb = boto3.resource('dynamodb', region_name="eu-west-1")
    dynamodb_table = dynamodb.Table("test_terra_db_name")
    print("hello world")
    print("hello world update")

