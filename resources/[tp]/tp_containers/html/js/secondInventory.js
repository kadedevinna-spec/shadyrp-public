function initSecondInventoryHandlers(inventory){
    
    $.each(inventory, function (index, item) {
    
        // Item Draggable Actions
    
        $('.seconditem-' + item.item + "-" + item.itemId).draggable({
            helper: 'clone',
            appendTo: 'body',
            zIndex: 99999,
            revert: 'invalid',
            start: function (event, ui) {
    
                SecondDraggedItemData = item;
                FirstDraggedItemData = null;
    
              //  $("#second_inventory").fadeOut();
            },
            stop: function () {
    
                SecondDraggedItemData = item;
    
               // $("#second_inventory").fadeIn();
            }
        });

        // Item Hovering Displays
        $('.seconditem-' + item.item + "-" + item.itemId).hover(
            function () {
                $("#second_inventory_hovered_item_label").text(item.label);
            },
            function () {
                $("#second_inventory_hovered_item_label").text(" ");
            }
        );                    
    
    });

    // Item Droppable Actions
    $('#inventory').droppable({
        drop: function (event, ui) {
            
            if (SecondDraggedItemData == null) { return; }
    
            if (SecondDraggedItemData.quantity == 1) { // Do not ask for a dialog prompt.
    
                $.post("http://tp_containers/nui:transferItem", JSON.stringify({
                    item : SecondDraggedItemData,
                    inventory : "container",
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
                            SecondDraggedItemData = null;
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
                                item : SecondDraggedItemData,
                                inventory : "container",
                                quantity : value,
                            }));

                            SecondDraggedItemData = null;
                            
                            HasDialogOpen = false;
                            dialog.close();
                        }
                    }
                });
            }
    
        }
    })

}