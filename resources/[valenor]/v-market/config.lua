Config = {
    Framework = 'rsg-core', -- vorp, rsg-core
    OpenKeyHash = 0xA4F1006B,
    OpenKey = "E",
    MarketLimit = 5, -- 0 = unlimited, 5 = max 5 items on market per open market

    Payment = "cash", -- cash or [itemName]

    -- Set a custom image server URL base path (ensure it ends with a slash /)
    -- Example: "nui://vorp_inventory/html/img/items/" or "https://myserver.com/images/"
    -- Leave as nil or "" to use default framework paths (vorp_inventory or rsg-inventory)
    ImageServer = "https://cfx-nui-v-inventory/web/dist/items/",

    Lang = {
        open_menu_key = "Press [{Config.OpenKey}] to open Market",
        market = 'Market',
        market_description = 'Welcome to the Market',
        market_blip = 'Market',
        market_blip_description = 'Welcome to the Market',
        market_access_denied = 'You do not have permission to access this market!',
        market_grade_required = 'You do not have the required job grade!',
        market_closed = 'This market is closed! Open hours: {open}:00 - {close}:00',
        market_not_found = 'Market not found!',
        not_enough_money = 'You do not have enough money!',
        invalid_amount = 'Invalid amount entered!',
        item_added_to_market = 'Item successfully added to the market!',
        item_updated_successfully = 'Item successfully updated!',
        market_withdraw_cash_required = 'You do not have permission to withdraw cash!',
        market_details_updated_successfully = 'Market details successfully updated!',
        not_enough_items = 'Not enough items in the market! Available: {maxQuantityinStore}, Required: {quantity}',
        item_out_of_stock = '{itemName} is out of stock and has been removed from the market!',
        returned_item = '{quantityToReturn}x {itemName} has been returned to your inventory!',
        could_not_return_item = '{quantityToReturn}x {itemName} could not be returned – inventory is full!',
        added_item_to_market = 'You added {quantityToAdd}x {itemName} from your inventory to the market!',
        not_enough_items_in_inventory = 'You don’t have enough {itemName} in your inventory! You have: {playerItemCount}, Required: {quantityToAdd}',
        item_removed_from_market = '{itemName} has been removed from the market.',
        not_enough_cash_in_market_case = 'Not enough money in the market cash register! Available: {case}',
        withdrew_cash_from_market_case = 'You withdrew {amount} cash from the market register!',
        purchase_successful = 'Purchase completed successfully! Total amount:',
        purchase_limit_reached = 'You can buy a maximum of {Config.MarketLimit} items in one transaction!',
        
        added_to_cart = 'Added to cart',
        add_to_cart = 'Add to cart',
        your_cart_is_empty = 'Your cart is empty',
        your_cart_title = 'Your Cart',
        money = 'Money',
        back_products = 'Back to products',
        total_price = 'Total Price',
        processing = 'Processing...',
        pay_via_cash = 'Pay with Cash',
        back_market = 'Back to Market',
        
        merchant_logo = 'Merchant Logo',
        merchant_logo_description = 'Description of the merchant’s logo',
        merchant_name_title = 'Merchant Name',
        merchant_name_title_description = 'Description of the merchant’s name',
        merchant_description_title = 'Merchant Description',
        merchant_description_title_description = 'Information about the merchant',
        
        case_title = 'Cash Register',
        case_description = 'Information about the cash register',
        case_amount_title = 'Amount in Register',
        amount_title = 'Amount',
        
        withdraw_cash = 'Withdraw Cash',
        no_permission = 'You don’t have permission',
        add_item = 'Add Item',
        back = 'Back',
        save = 'Save',
        item_name = 'Item Name',
        price = 'Price',
        category = 'Category',
        cancel = 'Cancel',
        confirm = 'Confirm',
        
        food_category = 'Food',
        description = 'Item description.',
        search_placeholder = 'Search...',
        management = 'Management',
        select_category = 'Select Category',
        
        error_valid_number = 'Please enter a valid number',
        error_greater_than = 'Amount must be greater than 0!',
        error_select_category = 'Please select a category!',
        error_negative_number = 'Amount cannot be negative!',
        sell_tab = 'Sell Items',
        sell_title = 'Sell your items',
        sell_description = 'Select items to sell to the market.',
        sold_item = 'You sold {quantity}x {itemName} for ${totalPrice}!',
        sell_error = 'Could not sell item!',
        
        -- Error Messages
        error_occurred = 'An error occurred!',
        connection_error = 'Connection error!',
        max_available = 'Max available: {max}',
        weapon_quantity_error = '1 Amount only for weapons!',
        error_adding_item = 'Error adding item!',
        update_failed = 'Update failed!',
        successfully_saved = 'Successfully saved!',
        failed_to_save = 'Failed to save!',
        purchase_failed = 'Purchase failed!',
        
        -- UI Labels
        sell_button = 'Sell',
        no_sellable_items = '(No sellable items)',
        
        -- Placeholders
        enter_url_placeholder = 'Enter a url...',
        enter_name_placeholder = 'Enter a name...',
        enter_desc_placeholder = 'Enter a desc...',
        default_item_description = 'Lorem ipsum dolor sit amet.',
    },    
    
    Notify = function(src, msg, time, Core) -- Server Side
        Core.NotifyRightTip(src, msg, time)

        -- TriggerClientEvent('ox_lib:notify', src, { title = msg, type = 'error', duration = time })
    end,    

    NPCSettings = {
        spawnForStandalone = true,
        spawnForCustom = true,
    },
    
    -- Standalone market
    markets = {
        -- {
        --     name = 'Valentine Store',
        --     description = 'Welcome to Valentine Store',
        --     coords = vector4(324.628, 803.9818, 116.88, -81.17),
        --     showBlip = true,
        --     BlipSettings = {
        --         color = 1,
        --         blipTexture = "blip_shop_market_stall",
        --     },
        --     items = {
        --         {
        --             id = 1,
        --             itemName = 'milk',
        --             itemLabel = 'Milk',
        --             description = "Item Description",
        --             price = 100,
        --             category = 'Food', -- Food, Health, Tools
        --             imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
        --         }
        --     }
        -- },
        {
            name = 'Rhodes Store',
            description = 'Welcome to Rhodes Store',
            coords = vector4(1330.227, -1293.41, 76.021, 68.88),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            -- operatingHours = { open = 8, close = 20 }, -- optional: market open 08:00-20:00, remove or nil = always open. Supports overnight e.g. { open = 20, close = 6 }
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
        {
            name = 'Strawberry Store',
            description = 'Welcome to Strawberry Store',
            coords = vector4(-1789.66, -387.918, 159.32, 56.96),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
        {
            name = 'Blackwater Store',
            description = 'Welcome to Blackwater Store',
            coords = vector4(-784.738, -1321.73, 42.884, 179.63),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
        {
            name = 'Armadillo Store',
            description = 'Welcome to Armadillo Store',
            coords = vector4(-3687.34, -2623.53, -15.43, -85.32),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
        {
            name = 'Tumbleweed Store',
            description = 'Welcome to Tumbleweed Store',
            coords = vector4(-5485.70, -2938.08, -2.299, 127.72),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
        {
            name = 'StDenis Store',
            description = 'Welcome to StDenis Store',
            coords = vector4(2824.863, -1319.74, 45.755, -39.61),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
        {
            name = 'Vanhorn Store',
            description = 'Welcome to Vanhorn Store',
            coords = vector4(3025.420, 561.7910, 43.722, -99.20),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
        {
            name = 'BlackwaterFishing Store',
            description = 'Welcome to BlackwaterFishing Store',
            coords = vector4(-756.069, -1360.76, 41.724, -90.80),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
        {
            name = 'Wapiti Store',
            description = 'Welcome to Wapiti Store',
            coords = vector4(449.7435, 2216.437, 245.30, -73.78),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
        {
            name = 'Valentinegunstore Store',
            description = 'Welcome to Valentinegunstore Store',
            coords = vector4(-280.4646, 779.0331, 117.2540, 2.82),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
        {
            name = 'SaintDgunstore Store',
            description = 'Welcome to SaintDgunstore Store',
            coords = vector4(2717.75, -1286.62, 47.64, 44.58),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
        {
            name = 'Rhodesgunstore Store',
            description = 'Welcome to Rhodesgunstore Store',
            coords = vector4(1322.95, -1323.21, 75.89, 350.17),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
        {
            name = 'Annesburggunstore Store',
            description = 'Welcome to Annesburggunstore Store',
            coords = vector4(2948.16, 1318.79, 42.82, 91.34),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
        {
            name = 'Tumbleweedgunstore Store',
            description = 'Welcome to Tumbleweedgunstore Store',
            coords = vector4(-5505.97, -2963.91, -2.64, 103.15),
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            items = {
                {
                    id = 1,
                    itemName = 'milk',
                    itemLabel = 'Milk',
                    description = "Item Description",
                    price = 100,
                    category = 'Food', -- Food, Health, Tools
                    imageUrl = "" -- optional https://cfx-nui-vorp_inventory/html/img/items/example_item.png or https://cfx-nui-rsg-inventory/html/images/consumable_water_filtered.png
                }
            }
        },
    },

    sellMarkets = {
        {
            name = 'ValentineButcher Store',
            description = 'Welcome to ValentineButcher Store',
            coords = vector4(-373.3841, 746.0846, 115.7293, 147.0814),
            showBlip = true,
            -- operatingHours = { open = 8, close = 20 },
            BlipSettings = {
                color = 1,
                blipTexture = "blip_shop_market_stall",
            },
            ped = 'mp_u_m_m_buyer_special_08',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            sellItems = {
                {
                    itemName = 'meat',
                    price = 2.50,
                    imageUrl = ""
                },
            }
        },
    },

    -- Custom market
    customMarkets = {
        {
            id = 1,
            showBlip = true,
            BlipSettings = {
                color = 1,
                blipTexture = "blip_ambient_law",
            },
            ped = 'gc_skinnertorture_males_01',
            scenario = 'WORLD_HUMAN_SHOPKEEPER',
            coords = vector4(-815.16, -1318.56, 43.69, 262.26),
            job = 'rgunsmith',
            grade = {0, 1, 2, 3, 4},
            bossGrade = {0},
            category = "Gunsmith" -- Saloon, Gunsmith
        }
    }
}