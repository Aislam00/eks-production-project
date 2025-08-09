resource "aws_iam_role" "external_dns" {
 name = "${var.cluster_name}-external-dns"
 assume_role_policy = jsonencode({
   Version = "2012-10-17"
   Statement = [
     {
       Action = "sts:AssumeRoleWithWebIdentity"
       Effect = "Allow"
       Principal = {
         Federated = var.oidc_provider_arn
       }
       Condition = {
         StringEquals = {
           "${var.oidc_provider}:sub" = "system:serviceaccount:kube-system:external-dns"
           "${var.oidc_provider}:aud" = "sts.amazonaws.com"
         }
       }
     }
   ]
 })
 tags = var.tags
}

resource "aws_iam_role_policy" "external_dns" {
 name = "${var.cluster_name}-external-dns-policy"
 role = aws_iam_role.external_dns.id
 policy = jsonencode({
   Version = "2012-10-17"
   Statement = [
     {
       Effect = "Allow"
       Action = [
         "route53:ChangeResourceRecordSets"
       ]
       Resource = [
         "arn:aws:route53:::hostedzone/${var.route53_zone_id}"
       ]
     },
     {
       Effect = "Allow"
       Action = [
         "route53:ListHostedZones",
         "route53:ListResourceRecordSets"
       ]
       Resource = ["*"]
     }
   ]
 })
}

resource "helm_release" "external_dns" {
 name       = "external-dns"
 repository = "https://kubernetes-sigs.github.io/external-dns/"
 chart      = "external-dns"
 version    = "1.13.1"
 namespace  = "kube-system"

 values = [
   yamlencode({
     serviceAccount = {
       create = true
       name   = "external-dns"
       annotations = {
         "eks.amazonaws.com/role-arn" = aws_iam_role.external_dns.arn
       }
     }
     provider = "aws"
     aws = {
       zoneType = "public"
     }
     domainFilters = [var.domain_name]
     sources       = ["ingress"]
     registry      = "txt"
     txtOwnerId    = var.cluster_name
     logLevel      = "info"
     namespace     = ""
   })
 ]

 depends_on = [aws_iam_role_policy.external_dns]
}