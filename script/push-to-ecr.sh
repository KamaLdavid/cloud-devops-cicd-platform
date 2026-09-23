#!/usr/bin/env bash

set -euo pipefail

AWS_REGION="${AWS_REGION:-ap-south-1}"
ECR_REPOSITORY="${ECR_REPOSITORY:-cloud-devops-learn-docker}"
IMAGE_NAME="${IMAGE_NAME:-cloud-devops-learn-docker}"
IMAGE_TAG="${IMAGE_TAG:?Image_Tag must be provided}"

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

LOCAL_IMAGE="${IMAGE_NAME}:${IMAGE_TAG}"


ECR_IMAGE="${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}"


echo "AWS Account: ${AWS_ACCOUNT_ID}"

echo "Aws Region: ${AWS_REGION}"

echo "Repository: ${ECR_REPOSITORY}"

echo "Local Image : ${LOCAL_IMAGE}"

echo "ECR Image   : ${ECR_IMAGE}"

echo "Checking local docker image.."

docker image inspect "${LOCAL_IMAGE}" > /dev/null

echo "Local image exists"


echo "Logging into ECR.."

aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "${ECR_REGISTRY}"

echo "ECR login successful"

echo "Tagging image"

docker tag "${LOCAL_IMAGE}" "${ECR_IMAGE}"

echo "Image tagged"

echo "${ECR_IMAGE}"


echo "Pushing image to ecr"

docker push "${ECR_IMAGE}"


echo "================================="
echo "ECR PUSH SUCCESSFUL"
echo "================================="
echo "${ECR_IMAGE}"











