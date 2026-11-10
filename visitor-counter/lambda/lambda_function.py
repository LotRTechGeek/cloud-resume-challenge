import json
import boto3
import os

table = boto3.resource("dynamodb").Table(
    os.environ["TABLE_NAME"]
)


def lambda_handler(event, context):

    response = table.update_item(
        Key={
            "id": "visitorCount"
        },
        UpdateExpression="ADD #count :inc",
        ExpressionAttributeNames={
            "#count": "count"
        },
        ExpressionAttributeValues={
            ":inc": 1
        },
        ReturnValues="UPDATED_NEW"
    )

    count = int(
        response["Attributes"]["count"]
    )

    return {
        "statusCode": 200,

        "headers": {
            "Access-Control-Allow-Origin": "*"
        },

        "body": json.dumps({
            "count": count
        })
    }