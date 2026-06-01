# Scheduled check-ins (cron)

Recurring jobs where the agent **messages you first** on Telegram. Run these on the
VPS after Telegram is connected and `cron.enabled: true` is set in the config.

> Verify flags against `openclaw cron --help` on your version (docs use `cron create`;
> older READMEs implied `cron add`). Replace `<YOUR_TELEGRAM_USER_ID>` and the timezone.

```bash
# Morning brief — 7:00 every day
openclaw cron create "0 7 * * *" \
  "Run my morning check-in: ask my top 1-3 priorities for today and surface anything \
   due or unresolved from gbrain. Keep it short." \
  --name "Morning check-in" --tz "America/Los_Angeles" \
  --session isolated --announce --channel telegram --to "<YOUR_TELEGRAM_USER_ID>"

# Evening review — 21:00 every day
openclaw cron create "0 21 * * *" \
  "Run my evening check-in: ask what got done and what slipped, capture my reply to \
   today's inbox note, and note anything for tomorrow." \
  --name "Evening check-in" --tz "America/Los_Angeles" \
  --session isolated --announce --channel telegram --to "<YOUR_TELEGRAM_USER_ID>"

# Weekly review — Monday 09:00
openclaw cron create "0 9 * * 1" \
  "Run my weekly review: summarize last week from gbrain (shipped, open threads, \
   decisions) and ask my focus for this week." \
  --name "Weekly review" --tz "America/Los_Angeles" \
  --session isolated --announce --channel telegram --to "<YOUR_TELEGRAM_USER_ID>"
```

Manage them:
```bash
openclaw cron list
openclaw cron run <id>        # test one now
openclaw cron edit <id>
```

Tip: to find `<YOUR_TELEGRAM_USER_ID>`, DM your bot once and run `openclaw logs --follow`,
then read the `from.id` field.
