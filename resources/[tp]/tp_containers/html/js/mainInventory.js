function initMainInventoryHandlers(inventory){

    $.each(inventory, function (index, item) {

        // Item Hovering Displays.
        $('.item-' + item.item + "-" + item.itemId).hover(
            
            function () {
                $("#main_inventory_hovered_item_label").text(item.label);

            },
            function () {
                $("#main_inventory_hovered_item_label").text(" ");
            }
        );

        // Item Draggable Actions

        $('.item-' + item.item + "-" + item.itemId).draggable({
            helper: 'clone',
            appendTo: 'body',
            zIndex: 99999,
            revert: 'invalid',
            start: function (event, ui) {

                FirstDraggedItemData = item;
                SecondDraggedItemData = null;

             //   $("#inventory").fadeOut();
            },
            stop: function () {

                FirstDraggedItemData = item;
                
              //  $("#inventory").fadeIn();
            }
        });

    });

    $('#second_inventory').droppable({
        drop: function (event, ui) {

            if (FirstDraggedItemData == null) { return; }

            if (FirstDraggedItemData.quantity == null || FirstDraggedItemData.quantity === undefined || FirstDraggedItemData.quantity == 1) { // Do not ask for a dialog prompt.

                $.post("http://tp_containers/nui:transferItem", JSON.stringify({
                    item : FirstDraggedItemData,
                    inventory : "main",
                    quantity : 1,
                }));

            }else{

                HasDialogOpen = true;

                //displayInventory(false);

                dialog.prompt({ title: Locales.Transfer, button: Locales.Accept, required: true, input: { type: "number", autofocus: "true" },

                    validate: function (value) {
                        if (!value) {
                            dialog.close();
                            HasDialogOpen = false;
                            FirstDraggedItemData = null;
                            //displayInventory(true);
                            return;
                        }

                        if (!isInteger(value)) {
                            return;
                        }

                        if (!isValidating) {
                            //displayInventory(true);

                            processEventValidation();

                            $.post("http://tp_containers/nui:transferItem", JSON.stringify({
                                item : FirstDraggedItemData,
                                inventory : "main",
                                quantity : value,
                            }));

                            FirstDraggedItemData = null;
                            HasDialogOpen = false;
                            dialog.close();
                            
                        }
                    }
                });
            }
        }
    })
}