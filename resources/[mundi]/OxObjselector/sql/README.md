# Database Setup for Soap Items

## VORP Framework

Run the SQL file in your VORP database:
```sql
-- Import the file
mysql -u your_user -p your_database < vorp_items.sql
```

Or manually execute the queries from `vorp_items.sql` in your database management tool (HeidiSQL, phpMyAdmin, etc.)

## RSG Framework

Copy the item definitions from `rsg_items.lua` and paste them into your `rsg-inventory/config.lua` or `rsg-inventory/shared/items.lua` file in the items table.

Example location in config:
```lua
Config.Items = {
    -- ... existing items ...
    
    -- Paste the soap items here
    ['custom_beautyboutique_cowpokecleanser'] = {
        -- ...
    },
    -- etc.
}
```

## Item Images

You'll need to add item images for the inventory. Place PNG images in:
- **VORP**: `vorp_inventory/html/img/items/`
- **RSG**: `rsg-inventory/html/images/`

Image names:
- `custom_beautyboutique_cowpokecleanser.png`
- `custom_beautyboutique_lemonbalmbar.png`
- `custom_beautyboutique_saddlesoap.png`

Recommended size: 256x256 pixels
