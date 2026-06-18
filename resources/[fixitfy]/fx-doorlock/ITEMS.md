### rsg-core/shared/items.lua

```lua
    -- FX-DOORLOCK
    doorkey = { name = 'doorkey', label = 'Door Key', weight = 1, type = 'item', image = 'doorkey.png', unique = false, useable = true, shouldClose = true, description = 'Doorkey..' },

```

### FX-DOORLOCK (VORP)
```sql
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `metadata`, `desc`)
VALUES
    ('doorkey', 'Door Key', 100, 1, 'item_standard', 1, '{}', 'Door Key..')

ON DUPLICATE KEY UPDATE
    `item` = VALUES(`item`),
    `label` = VALUES(`label`),
    `limit` = VALUES(`limit`),
    `can_remove` = VALUES(`can_remove`),
    `type` = VALUES(`type`),
    `usable` = VALUES(`usable`),
    `metadata` = VALUES(`metadata`),
    `desc` = VALUES(`desc`);

```