Get a report of occurances across all your Rollbar projects.

```sh
bash report.sh _YOUR_ACCOUNT_ACCESS_TOKEN_ result.csv
```

I use this data in this [Google sheet](https://docs.google.com/a/iorahealth.com/spreadsheets/d/1Nf4eQkJ2vhFyULxz5OoEIIz_wZC--6KiS7XhZEF8MNg/edit?usp=sharing).

The first tab pulls in the data from the second tab. The second tab in the above example is the output of the `report.sh` command.

__Access Token__

You can get your Rollbar access token on this page:

https://rollbar.com/settings/accounts/[ORG_NAME]/access_tokens/

Example: For Iora Health it would be https://rollbar.com/settings/accounts/IoraHealth/access_tokens/
