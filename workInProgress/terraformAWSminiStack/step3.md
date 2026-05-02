# AWS CDK


> https://docs.aws.amazon.com/cdk/v2/guide/hello-world.html





`cd ~ && mkdir hello-cdk && cd hello-cdk`{{exec}}




We'll install the AWS CDK and the addon for local.


`npm install -g aws-cdk-local aws-cdk`{{exec}}

`cdklocal --version`{{exec}}

make sure the env's are set:

```
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
```{{exec}}




`cdklocal init app --language javascript`{{exec}}



`cdklocal bootstrap`{{exec}}

check cdk.out

`cdklocal deploy`{{exec}}

   check cdk.out


`cdklocal list`{{exec}}

`awslocal cloudformation describe-stacks --stack-name HelloCdkStack`{{exec}}

`cdklocal list --verbose`{{exec}}

`awslocal sqs list-queues`{{exec}}

`awslocal s3 ls`{{exec}}

update /lib/*.js
```
const { Stack } = require('aws-cdk-lib');
// Import the Lambda module
const lambda = require('aws-cdk-lib/aws-lambda');

class HelloCdkStack extends Stack {
  constructor(scope, id, props) {
    super(scope, id, props);

    // Define the Lambda function resource
    const myFunction = new lambda.Function(this, "HelloWorldFunction", {
      runtime: lambda.Runtime.NODEJS_20_X, // Provide any supported Node.js runtime
      handler: "index.handler",
      code: lambda.Code.fromInline(`
        exports.handler = async function(event) {
          return {
            statusCode: 200,
            body: JSON.stringify('Hello World!'),
          };
        };
      `),
    });

  }
}

module.exports = { HelloCdkStack }


```

`cdklocal synth`{{exec}}

check cdk.out

`cdklocal diff`{{exec}}

`cdklocal deploy`{{exec}}


`aws lambda list-functions --endpoint-url=http://localhost:4566`{{exec}}

WIP find and test the lambda endpoint

```
$ curl https://<api-id>.lambda-url.<Region>.on.aws/
"Hello CDK!"%
```

```
curl -X POST "http://localhost:4566/2015-03-31/functions/HelloCdkStack-HelloWorldFunctionB2AB6E79-PF0CGSC5VGWVI/invocations" \
     -d '{}' \
     -H "Content-Type: application/json"
```

## And destroy

`cdk destroy`{{exec}}






