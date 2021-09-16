resource "aws_iam_role" "linux_instance_role" {
  name = "microseg-demo-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
      "Service": "ec2.amazonaws.com"
    },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "linux_instance_policy" {
  name = "microseg-demo-iam-policy"
  role = aws_iam_role.linux_instance_role.id

  policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:DescribeTags",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "linux_instance_profile" {
  name = "microseg-demo-instance-profile"
  role = aws_iam_role.linux_instance_role.name
  path = "/"
}