import boto3

# Crear un cliente para cada servicio AWS que se desea limpiar
ec2_client = boto3.client('ec2')
s3_client = boto3.client('s3')
iam_client = boto3.client('iam')

def delete_ec2_instances():
    instances = ec2_client.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running', 'stopped']}])
    for reservation in instances['Reservations']:
        for instance in reservation['Instances']:
            print(f"Eliminando instancia EC2: {instance['InstanceId']}")
            ec2_client.terminate_instances(InstanceIds=[instance['InstanceId']])

def delete_s3_buckets():
    buckets = s3_client.list_buckets()
    for bucket in buckets['Buckets']:
        print(f"Eliminando bucket S3: {bucket['Name']}")
        s3_client.delete_bucket(Bucket=bucket['Name'])

def delete_iam_users():
    users = iam_client.list_users()
    for user in users['Users']:
        print(f"Eliminando usuario IAM: {user['UserName']}")
        iam_client.delete_user(UserName=user['UserName'])

def main():
    print("Iniciando limpieza de servicios residuales en AWS...")
    delete_ec2_instances()
    delete_s3_buckets()
    delete_iam_users()
    print("Limpieza completada.")

if __name__ == "__main__":
    main()
