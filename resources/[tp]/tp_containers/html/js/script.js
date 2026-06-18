var ClickedCloseKey = false;

$("document").ready(function () {
	
	$("#inventory").draggable();
	$("#second_inventory").draggable();

	displayPage("notification", "visible");
	$("#notification_message").fadeOut();
	
	document.body.style.display = "none";
	document.getElementById("second_inventory").style.display = 'none';
});

$(function() {
	window.addEventListener('message', function(event) {
		var item = event.data;


		if (item.action == "setContainersState") {

			document.body.style.display = item.enable ? "block" : "none";

			if (item.enable){

				$("#inventory").fadeIn();
				$("#second_inventory").fadeIn();

			}

			document.getElementById("inventory").style.display = "block";
			document.getElementById("second_inventory").style.display = item.enable ? "block" : "none";


		} else if (item.action == 'setItemImagesSourcePath'){

			INVENTORY_IMAGES_SOURCE_PATH = item.imageSrcPath;

			$("#main_inventory_current_header").text(Locales.MainInventoryHeader);

		}
		
		else if (item.action == 'updatePlayerInventoryWeight'){

			let currentWeight = ConvertWeight(item.weight, Boolean(item.convert));
			let maxWeight = ConvertWeight(item.maxWeight, Boolean(item.convert));

			$("#main_inventory_current_weight").text(currentWeight + "/" + maxWeight + "KG");

		}

		else if (item.action == 'updateContainerInventoryWeight'){

			let currentWeight = ConvertWeight(item.weight, Boolean(item.convert));
			let weightDisplay = (item.maxWeight != -1) ? currentWeight + "/" + item.maxWeight + "KG" : currentWeight + "KG";

			$("#second_inventory_current_weight").text(weightDisplay);

		}

		else if (item.action == 'updateContainerInventoryInformation'){

			$("#second_inventory_current_header").text(item.header);

			let currentWeight = ConvertWeight(item.weight, Boolean(item.convert));
			let weightDisplay = (item.maxWeight != -1) ? currentWeight + "/" + item.maxWeight + "KG" : currentWeight + "KG";

			$("#second_inventory_current_weight").text(weightDisplay);
		}

		else if (item.action == 'clearAllContents'){
			$("#main_inventory_contents").html('');
			$("#second_inventory_contents").html('');
		}

		else if (item.action == 'updatePlayerInventoryContents'){

			var prod_item = event.data.item_data;

			if (event.data.transfer_type != null){

				if (event.data.transfer_type == 'ADD'){

					if ($(".item-" + prod_item.item + "-" + prod_item.itemId)[0]){

						let quantity = Number($(".item-count-" + prod_item.item + "-" + prod_item.itemId).text()) + prod_item.transfer_quantity;
						
						$(".item-count-" + prod_item.item + "-" + prod_item.itemId).text(quantity);
	
						return;
					}

					prod_item.quantity = prod_item.transfer_quantity;

				}else if (event.data.transfer_type == 'REMOVE') {

					let quantity = Number($(".item-count-" + prod_item.item + "-" + prod_item.itemId).text()) - prod_item.transfer_quantity;

					if (quantity != undefined && quantity != null && quantity > 0 && prod_item.type != 'weapon' ){
						$(".item-count-" + prod_item.item + "-" + prod_item.itemId).text(quantity);

					}else{

						$("#primary_content-" + prod_item.item + "-" + prod_item.itemId).remove();
					}

					return;
				}
			}

			if (prod_item.type != "weapon") {

				if (prod_item.quantity == 1 && prod_item.unique == 1) {

					if (prod_item.durability != null && prod_item.durability != -1) {
						$("#main_inventory_contents").append(
							`<div id = "primary_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "item-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
							`<img id="main_inventory_item_image_display" src = "` + getItemIMG(prod_item.item) + `"></img>` + 
							`<div id="main_inventory_item_count" style = 'background-color: #9e7a4a; color: snow; font-weight: 100; font-size: 0.5vw; '>` + financial(prod_item.durability) + `%</div>`+
							`</div>`
						);
					}else{
						$("#main_inventory_contents").append(
							`<div id = "primary_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "item-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
							`<img id="main_inventory_item_image_display" src = "` + getItemIMG(prod_item.item) + `"></img>` + 
							`</div>`
						);
					}

				}else{
	
					$("#main_inventory_contents").append(
						`<div id = "primary_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "item-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
						`<img id="main_inventory_item_image_display" src = "` + getItemIMG(prod_item.item) + `"></img>` + 
						`<div class = "item-count-` + prod_item.item + "-" + prod_item.itemId + `" id="main_inventory_item_count">` + prod_item.quantity + `</div>`+
						`</div>`
					);
				}

			}else{
					
				var durability = prod_item.durability

				if (durability == null || durability === undefined) {
					durability = -1;
				}

				if (event.data.framework == 'vorp' || event.data.framework == 'rsg' || event.data.framework == 'rsgv2') {
					durability = -1;
				}

				if (durability != -1 ) {
					
					$("#main_inventory_contents").append(
						`<div id = "primary_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "item-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
						`<img id="main_inventory_item_image_display" src = "` + getItemIMG(prod_item.item) + `"></img>` + 
						`<div id="main_inventory_item_count" style = 'background-color: brown; color: snow; font-weight: 100; font-size: 0.5vw; '>` + financial(durability) + `%</div>`+
						`</div>`
					);

				}else{
					$("#main_inventory_contents").append(
						`<div id = "primary_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "item-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
						`<img id="main_inventory_item_image_display" src = "` + getItemIMG(prod_item.item) + `"></img>` + 
						`</div>`
					);
				}
			}

		}

		else if (item.action == 'updateSecondInventoryContents'){
			var prod_item = event.data.item_data;

			if (event.data.transfer_type != null){

				if (event.data.transfer_type == 'ADD'){

					if ($(".seconditem-" + prod_item.item + "-" + prod_item.itemId)[0]){

						let quantity = Number($(".seconditem-count-" + prod_item.item + "-" + prod_item.itemId).text()) + prod_item.transfer_quantity;
						
						$(".seconditem-count-" + prod_item.item + "-" + prod_item.itemId).text(quantity);
	
						return;
					}

					prod_item.quantity = prod_item.transfer_quantity;

				}else if (event.data.transfer_type == 'REMOVE') {

					let quantity = Number($(".seconditem-count-" + prod_item.item + "-" + prod_item.itemId).text()) - prod_item.transfer_quantity;

					if (quantity != undefined && quantity != null && quantity > 0 && prod_item.type != 'weapon' ){
						$(".seconditem-count-" + prod_item.item + "-" + prod_item.itemId).text(quantity);

					}else{

						$("#second_content-" + prod_item.item + "-" + prod_item.itemId).remove();
					}

					return;
				}
			}

			if (prod_item.type != "weapon") {

				if (prod_item.quantity == 1 && prod_item.unique ) {

					if (prod_item.durability != null && prod_item.durability != -1) {
						$("#second_inventory_contents").append(
							`<div id = "second_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "seconditem-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
							`<img id="second_inventory_item_image_display" src = "` + getItemIMG(prod_item.item) + `"></img>` + 
							`<div id="second_inventory_item_count" style = 'background-color: #9e7a4a; color: snow; font-weight: 100; font-size: 0.5vw; '>` + financial(prod_item.durability) + `%</div>`+
							`</div>`
						);
					}else{
						$("#second_inventory_contents").append(
							`<div id = "second_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "seconditem-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
							`<img id="second_inventory_item_image_display" src = "` + getItemIMG(prod_item.item) + `"></img>` + 
							`</div>`
						);
					}

				}else{
	
					$("#second_inventory_contents").append(
						`<div id = "second_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "seconditem-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
						`<img id="second_inventory_item_image_display" src = "` + getItemIMG(prod_item.item) + `"></img>` + 
						`<div class = "seconditem-count-` + prod_item.item + "-" + prod_item.itemId + `" id="second_inventory_item_count">` + prod_item.quantity + `</div>`+
						`</div>`
					);
				}

			}else{
				var durability = prod_item.durability

				if (durability == null || durability === undefined) {
					durability = -1;
				}

				if (durability != -1){
		
					$("#second_inventory_contents").append(
						`<div id = "second_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "seconditem-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
						`<img id="second_inventory_item_image_display" src = "` + getItemIMG(prod_item.item) + `"></img>` + 
						`<div id="second_inventory_item_count" style = 'background-color: brown; color: snow; font-weight: 100; font-size: 0.5vw; '>` + financial(durability) + `%</div>`+
						`</div>`
					);

				}else{
					$("#second_inventory_contents").append(
						`<div id = "second_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "seconditem-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
						`<img id="second_inventory_item_image_display" src = "` + getItemIMG(prod_item.item) + `"></img>` + 
						`</div>`
					);
				}
			}

		}


		else if (item.action == 'setupSecondInventoryContents'){

			var inventory = event.data.inventory;
			initSecondInventoryHandlers(inventory);
		}

		else if (item.action == 'setupPlayerInventoryContents'){
			var inventory = event.data.inventory;
			initMainInventoryHandlers(inventory);
		}

		else if (item.action == "sendNotification") {
			var prod_notify = item.notification_data;
			sendNotification(prod_notify.message, prod_notify.color);
	
		}

		else if (item.action == 'closeContainers'){
			$("#inventory").fadeOut();
			$("#second_inventory").fadeOut();

			closeContainers();

		}

		$("body").on("keyup", function (key) {
			if ( (key.which == 73 || key.which == 27) && ClickedCloseKey == false){

				if (HasDialogOpen) { return; }

				$("#inventory").fadeOut();
				$("#second_inventory").fadeOut();

				ClickedCloseKey = true;
				closeContainers();

				setTimeout(()=> { ClickedCloseKey = false; },2000);
			}
		});

	});

});

/* Loading Locales */

const loadScript = (FILE_URL, async = true, type = "text/javascript") => {
	return new Promise((resolve, reject) => {
		try {
			const scriptEle = document.createElement("script");
			scriptEle.type = type;
			scriptEle.async = async;
			scriptEle.src =FILE_URL;
  
			scriptEle.addEventListener("load", (ev) => {
				resolve({ status: true });
			});
  
			scriptEle.addEventListener("error", (ev) => {
				reject({
					status: false,
					message: `Failed to load the script ${FILE_URL}`
				});
			});
  
			document.body.appendChild(scriptEle);
		} catch (error) {
			reject(error);
		}
	});
  };
  
loadScript("js/locales/locales-" + Config.Locale + ".js").then( data  => { 
	
}) .catch( err => { console.error(err); });

