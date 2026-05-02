# AWS CDK


> https://docs.aws.amazon.com/cdk/v2/guide/hello-world.html



WIP don't do
! Make sure you have environments variables config before running

`cd ~ && mkdir hello-cdk && cd hello-cdk`{{exec}}

Looks like JS is the way to go, not `cdk init app --language python`

`cdk init app --language javascript`{{exec}}

Fllow https://docs.aws.amazon.com/cdk/v2/guide/hello-world.html

END WIP






`npm install -g aws-cdk-local aws-cdk`{{exec}}

`cdklocal --version`{{exec}}

```
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
```

`cdklocal bootstrap`{{exec}}

check cdk.out


`cdklocal init app --language javascript`{{exec}}

check cdk.out

`cdklocal bootstrap`{{exec}}

check cdk.out

`cdklocal deploy`{{exec}}

   check cdk.out


`cdklocal list`{{exec}}

`cdklocal list --verbose`{{exec}}

`awslocal sqs list-queues`{{exec}}

update /lib/*.js
```
const { Stack } = require('aws-cdk-lib');
// Import the Lambda module
const lambda = require('aws-cdk-lib/aws-lambda');

class TestStack extends Stack {
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

module.exports = { TestStack }


```

`awslocal synth`{{exec}}

check cdk.out






