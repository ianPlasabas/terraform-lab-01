#=================================================
# CodeBuild Projects
#=================================================
resource "aws_codebuild_project" "plan" {
  name         = "base-network-plan"
  service_role = "arn:aws:iam::772056227259:role/CodeBuildTerraformRole"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:6.0"
    type         = "LINUX_CONTAINER"
    privileged_mode = true
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file(".buildspec-plan.yaml")
  }
}

resource "aws_codebuild_project" "apply" {
  name         = "base-network-apply"
  service_role = "arn:aws:iam::772056227259:role/CodeBuildTerraformRole"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:6.0"
    type         = "LINUX_CONTAINER"
    privileged_mode = true
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file(".buildspec-apply.yaml")
  }
}

#=================================================
# CodePipeline
#=================================================
resource "aws_codepipeline" "pipeline" {
  name     = "base-network-pipeline"
  role_arn = "arn:aws:iam::772056227259:role/CodeBuildTerraformRole"

  artifact_store {
    location = "terraform-artifact-0192731237"
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = data.terraform_remote_state.repo_connection.outputs.github_arn
        FullRepositoryId = "ianPlasabas/terraform-lab-01"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Plan"
    action {
      name             = "Plan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["plan_output"]
      configuration = {
        ProjectName = aws_codebuild_project.plan.name
      }
    }
  }

  stage {
    name = "Approval"
    action {
      name     = "ManualApproval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
      configuration = {
        CustomData = "Approve apply for base-network"
      }
    }
  }

  stage {
    name = "Apply"
    action {
      name            = "Apply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["plan_output"] # artifact with tfplan.binary
      configuration = {
        ProjectName = aws_codebuild_project.apply.name
      }
    }
  }
}