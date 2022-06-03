package testing

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

// An example of how to test the Terraform module in examples/terraform-backend-example using Terratest.
func TestTerraformBackendExample(t *testing.T) {
	t.Parallel()

	awsRegion := "us-east-1"
	uniqueId := random.UniqueId()

	// Create an S3 bucket where we can store state
	bucketName := fmt.Sprintf("test-terraform-backend-example-%s", strings.ToLower(uniqueId))
	defer cleanupS3Bucket(t, awsRegion, bucketName)
	aws.CreateS3Bucket(t, awsRegion, bucketName)

	asgName := "terraform-20220601200212409400000001-cluster"
  key := "terraform.tfstate"

	// Deploy the module, configuring it to use the S3 bucket as an S3 backend
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../webserver-cluster",
		Vars: map[string]interface{}{
      "aws_region": awsRegion,
      "cluster_name": "terraform-test-cluster",
      "db_remote_state_bucket": "terraform-webservers-tests",
      "db_remote_state_key": "terraform.tfstate",
		},
		BackendConfig: map[string]interface{}{
			"bucket": bucketName,
			"key":    key,
			"region": awsRegion,
		},
    Reconfigure: true,
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Check a state file actually got stored and contains our data in it somewhere (since that data is used in an
	// output of the Terraform code)
	contents := aws.GetS3ObjectContents(t, awsRegion, bucketName, key)
	require.Contains(t, contents, asgName)
}

func cleanupS3Bucket(t *testing.T, awsRegion string, bucketName string) {
	aws.EmptyS3Bucket(t, awsRegion, bucketName)
	aws.DeleteS3Bucket(t, awsRegion, bucketName)
}
