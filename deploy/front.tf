resource "aws_s3_bucket" "client" {
  bucket = "360-medics-inapp-${var.project}"
  acl    = "private"

  tags = {
    Name        = "InApp ${var.project}"
    Environment = "Dev"
  }
}

# create S3 Read Access Policy
resource "aws_iam_policy" "s3_policy" {
  name        = "s3-policy-${var.project}"
  description = "Policy for allowing Read the ${var.project} S3 InApp"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetAccessPoint",
        "s3:GetObject",
        "s3:GetObjectAcl"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::360-medics-inapp-${var.project}/*"
    }
  ]
}
EOF
}

# create API Gateway Role
resource "aws_iam_role" "s3_api_gateyway_role" {
  name = "s3-api-gateyway-role-${var.project}"

  # create Trust Policy for API Gateway
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# attach S3 Access Policy to the API Gateway Role
resource "aws_iam_role_policy_attachment" "s3_policy_attach" {
  role       = aws_iam_role.s3_api_gateyway_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

resource "aws_api_gateway_resource" "client-root" {
  rest_api_id = data.aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.task-root.id

  path_part = "client"
}

resource "aws_api_gateway_resource" "get_bucket_object" {
  rest_api_id = data.aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.client-root.id
  path_part   = "{item+}"
}

resource "aws_api_gateway_method" "get_bucket_object" {
  rest_api_id      = data.aws_api_gateway_rest_api.main.id
  resource_id      = aws_api_gateway_resource.get_bucket_object.id
  http_method      = "GET"
  api_key_required = false
  authorization    = "NONE"

  request_parameters = {
    "method.request.path.item" = true
  }
}

resource "aws_api_gateway_integration" "s3-integration" {
  rest_api_id = data.aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.get_bucket_object.id
  http_method = aws_api_gateway_method.get_bucket_object.http_method

  # Included because of this issue: https://github.com/hashicorp/terraform/issues/10501
  integration_http_method = "GET"

  type = "AWS"

  # See uri description: https://docs.aws.amazon.com/apigateway/api-reference/resource/integration/
  uri         = "arn:aws:apigateway:${var.region}:s3:path/${aws_s3_bucket.client.bucket}/{item}"
  credentials = aws_iam_role.s3_api_gateyway_role.arn

  request_parameters = {
    "integration.request.path.item" = "method.request.path.item"
  }
}

resource "aws_api_gateway_method_response" "s3-integration-response" {
  rest_api_id = aws_api_gateway_integration.s3-integration.rest_api_id
  resource_id = aws_api_gateway_integration.s3-integration.resource_id
  http_method = aws_api_gateway_integration.s3-integration.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Timestamp"      = true
    "method.response.header.Content-Length" = true
    "method.response.header.Content-Type"   = true
  }
}

resource "aws_api_gateway_integration_response" "s3-integration-response" {
  rest_api_id = aws_api_gateway_integration.s3-integration.rest_api_id
  resource_id = aws_api_gateway_integration.s3-integration.resource_id
  http_method = aws_api_gateway_integration.s3-integration.http_method
  status_code = aws_api_gateway_method_response.s3-integration-response.status_code

  response_parameters = {
    "method.response.header.Timestamp"      = "integration.response.header.Date"
    "method.response.header.Content-Length" = "integration.response.header.Content-Length"
    "method.response.header.Content-Type"   = "integration.response.header.Content-Type"
  }

  depends_on = [
    aws_api_gateway_integration.s3-integration
  ]
}
