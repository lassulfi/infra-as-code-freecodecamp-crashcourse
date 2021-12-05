# Infrastructure as Code

## Creating an docker environment

1. Copy .env.example file and edit the environment variables according to your Pulumi and AWS accounts

```shell
cp .env.example .env
```

2. Run the container

```shell
docker-compose up -d
```

3. Execute the container in interactive mode

```shell
docker-compose exec app bash
```

## Creating a new pulumi typescript project

1. Create a folder for the project

```shell
mkdir -p projects/iac-lab1 && \
    cd projects/iac-lab1
```

2. Create a new pulumi project

```shell
pulumi new typescript -y
```

## Configuring aws

1. Adding AWS as dependency

```shell
npm install @pulimi/aws --save
```

2. Configuring aws region

``` shell
pulumi config set aws:region us-east-1
```

3. AWS login

```shell
aws configure
```

## Running your pulumi application

- Updating your stack

```shell
pulumi up
```

- Retrieve all the stack outputs

```shell
pulumi stack output
```

- Retrieve all files from AWS S3 Bucket

```shell
aws s3 ls $(pulumi stack output bucketName)
```

- Setting pulumi configurations

```shell
pulumi config set iac-lab1:<config> <value>
```

- Creating a new stack

```shell
pulumi stack init prod
```

- List all stacks

```shell
pulumi stack ls
```

- Destroy all the resources

```shell
pulumi destroy
```

- Change stacks

```shell
pulumi stack select dev
```
