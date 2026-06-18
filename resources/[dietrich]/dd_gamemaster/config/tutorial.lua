Config = Config or {}

-- Tutorial configuration for the Gamemaster UI
-- You can freely edit, add, remove, or reorder pages below.
-- media: path to an image/gif/webp relative to the UI (e.g., 'images/yourfile.webp')

Config.Tutorial = {
    pages = {
        {
            id = 'welcome',
            title = 'Welcome to Gamemaster',
            text = 'Lets take our first steps. It takes under a minute and will help you get started fast and painlessly.',
            media = 'images/animations/redm/tutorial_opener_short.webp',
            mediaAlt = 'Welcome'
        },
        {
            id = 'movement',
            title = 'Movement Controls',
            text = 'You can move the camera while holding down the middle mouse button (pressing the wheel down) and moving your mouse. If you scroll the wheel you can zoom in and out. You can also move the camera with the WASD keys. Press Q and E to roate, R and F to pitch. Pressing `C` will lower the camera, `Space` will raise it.',
            media = 'images/animations/redm/tutorial_movement_controll.webp',
            mediaAlt = 'Movement'
        },
        {
            id = 'favorites',
            title = 'The Favorites Hotbar',
            text = 'Drag items to the bottom bar to assign them to slots 1–9. Press the digit to select quickly. If you now click into the world, you can spawn the selected NPC. You can also just search and select the item directly to spawn it. You dont have to use the favorites bar to spawn NPCs.',
            media = 'images/animations/redm/tutorial_hotbar.webp',
            mediaAlt = 'Favorites'
        },
        {
            id = 'select and move',
            title = 'Select and (Quick)Move',
            text = 'Left-click an NPC to select it. You can select all NPCs, even the natural existing ones! Then hold the right mouse button down while you move your mouse, a line and a marker will appear. Move the marker to the position you want the NPC to move to and release the right mouse button..',
            media = 'images/animations/redm/tutorial_opener_short.webp',
            mediaAlt = 'select and move'
        },
        {
            id = 'multi select',
            title = 'Multi-Select',
            text = 'You can select multiple NPCs by holding the left mouse button down and moving your mouse to create a selection box. You can also move them by holding the right mouse button down and moving your mouse to the position you want the NPC to move to.',
            media = 'images/animations/redm/tutorial_multiselect.webp',
            mediaAlt = 'multi-select'
        },
        {
            id = 'context menu',
            title = 'Context Menu',
            text = 'If you have an NPC selected, you can right click on the NPC to open the context menu. The context menu is a powerful tool that allows you to perform various actions on the NPC. As the name suggests, the menu is context sensitive and will change depending on what you are doing. Selecting an NPC and right clicking on the ground will open a different context menu than right clicking on another NPC. Test it out, you will get the hang of it!',
            media = 'images/animations/redm/tutorial_context_menu.webp',
            mediaAlt = 'context menu'
        },
        {
            id = 'many more',
            title = 'Many More Features',
            text = 'There are many more features to discover. You can find a full list of controls in the Help & Guide menu located on top of the selection bar. For example, there is a convienten copy and paste function. Happy exploring!',
            media = 'images/animations/redm/tutorial_copy_past_shot_simple.webp',
            mediaAlt = 'many more'
        }
    }
}


