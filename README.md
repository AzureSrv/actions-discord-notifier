# Discord Actions Notifier

[![Test](https://github.com/AzureSrv/actions-discord-notifier/actions/workflows/test.yml/badge.svg)](https://github.com/AzureSrv/actions-discord-notifier/actions/workflows/test.yml)

An action to send a Discord Webhook in a Github Actions workflow. Automatically wrapped within an embed.

## Inputs

| Name       | Type     | Description           |
|------------|----------|-----------------------|
| `webhook`  | String   | Discord Webhook URL   |
| `message`  | String   | Your escaped message  |

## Example

```yaml
on: push

jobs:
  test:
    name: Test-Action
    runs-on: ubuntu-20.04
    steps:

      - name: Send Test Message
        id: test
        uses: azuresrv/actions-discord-notifier@v1
        with:
          webhook: ${{ secrets.WEBHOOK }}
          message: This is a test message!
```