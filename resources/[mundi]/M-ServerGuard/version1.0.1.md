# M-ServerGuard — Update Guide: 1.0.0 → 1.0.1

## What's new
- Custom bank script integration — connect any third-party banking script
  (e.g. Murphy's Bank) to the economy log alongside your existing money/gold tracking.

## How to update
You can simply replace all other files except your configs/ folder, but make sure to add the new BankIntegration block to your config as described below.

### Add the BankIntegration block to `configs/config.lua`

Open your `configs/config.lua` and add the following block **above** the
`-- Anti-cheat config moved to configs/anticheat.lua` comment (i.e. after the
`MGuard.Economy` section ends):
(COPY AFTER THE ```lua line, NOT including it)
```lua
---------------------------------------------------------------------------
-- CUSTOM BANK SCRIPT INTEGRATION
---------------------------------------------------------------------------
-- Connect a third-party bank script so its balances are tracked in the
-- economy log alongside framework money/gold.
--
-- Two modes:
--   'sql'    – query the bank table(s) directly. Works for any bank script
--              with a database table. Balances from multiple table entries
--              are SUMMED, so scripts that split savings/checking into
--              separate rows or tables are handled automatically.
--   'export' – call exports[Resource]:Function(charId) → number.
--              More accurate if the bank script exposes an export.
--
-- IdentifierColumn must hold the same value as charIdentifier in mguard_players:
--   RSG  →  citizenid  (e.g. "REF12345")
--   VORP →  charIdentifier (numeric, stored as a string in some scripts)
--
-- Leave Enabled = false to disable entirely with zero performance impact.
MGuard.BankIntegration = {
    Enabled = false,
    Mode    = 'sql',   -- 'sql' | 'export'
    Label   = 'Bank',  -- label shown in economy log UI

    -- SQL mode: list every table that holds a balance you want to track.
    -- All matched rows are summed into a single balance value.
    -- Optional Filter: extra WHERE clause (do NOT include the WHERE keyword).
    SQL = {
        { Table = 'bank_accounts', IdentifierColumn = 'citizenid', BalanceColumn = 'balance' },
        -- Examples:
        -- { Table = 'bank_savings',  IdentifierColumn = 'citizenid', BalanceColumn = 'amount' },
        -- { Table = 'bank_accounts', IdentifierColumn = 'owner',     BalanceColumn = 'balance', Filter = "type = 'checking'" },
    },

    -- Export mode: call exports[Resource]:Function(charIdentifier) → number
    Export = {
        Resource = 'murphysbankorsomeweirdbank',
        Function = 'getBalance',
    },

    -- Flag any single-poll balance change exceeding this amount
    LargeTransactionThreshold = 5000,
}
```

---

## Configuring bank integration (optional)

If you want to hook up your bank script, set `Enabled = true` and choose a mode:

**SQL mode** (recommended for most scripts):
```lua
MGuard.BankIntegration = {
    Enabled = true,
    Mode    = 'sql',
    SQL = {
        { Table = 'bank_accounts', IdentifierColumn = 'citizenid', BalanceColumn = 'balance' },
    },
    LargeTransactionThreshold = 5000,
}
```
Replace `bank_accounts`, `citizenid`, and `balance` with your bank script's actual
table name, player identifier column, and balance column.

**Export mode** (if your bank script exposes an export):
```lua
MGuard.BankIntegration = {
    Enabled = true,
    Mode    = 'export',
    Export = {
        Resource = 'your_bank_resource',  -- resource name in server.cfg
        Function = 'getBalance',          -- export function name
    },
    LargeTransactionThreshold = 5000,
}
```
The export is called as `exports['your_bank_resource']:getBalance(charIdentifier)`
and must return a number.

**Multi-table example** (e.g. bank script with separate account types):
```lua
SQL = {
    { Table = 'bank_accounts', IdentifierColumn = 'citizenid', BalanceColumn = 'balance', Filter = "type = 'checking'" },
    { Table = 'bank_accounts', IdentifierColumn = 'citizenid', BalanceColumn = 'balance', Filter = "type = 'savings'" },
    { Table = 'bank_loans',    IdentifierColumn = 'citizenid', BalanceColumn = 'amount' },
},
```
All matched values are summed into one bank balance that is polled every 30 seconds.
