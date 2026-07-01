# Event-Driven Routing (EventBridge)

EventBridge enables building event-driven architectures.

## 1. Create Rule
```bash
awslocal events put-rule \
    --name MyOrderRule \
    --event-pattern '{"source": ["my.app"], "detail-type": ["OrderCreated"]}'
```{{exec}}

## 2. Fire Event
```bash
awslocal events put-events --entries '[{
    "Source": "my.app",
    "DetailType": "OrderCreated",
    "Detail": "{\"orderId\": \"1234\", \"status\": \"new\"}"
}]'
```{{exec}}
