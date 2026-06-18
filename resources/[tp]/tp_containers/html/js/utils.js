let hiddenInventoryFunction = null;
let hiddenInventory         = false;
let isValidating            = false; // Block other validation event when a validation prompt is already processing

FirstDraggedItemData        = null;
SecondDraggedItemData       = null;

HasDialogOpen               = false;

let INVENTORY_IMAGES_SOURCE_PATH  = null;

function processEventValidation(ms = 1000) {
    isValidating = true;
    const timer = setTimeout(() => {
        isValidating = false;
        clearTimeout(timer);
    }, ms)
}

function isInteger(n) {
    return n != "" && !isNaN(n) && Math.round(n) == n;
}
function isFloat(n){
    return Number(n) === n && n % 1 !== 0;
}

function displayInventory(cb){

    if (cb) {
        
        $("#inventory").fadeIn();
        $("#second_inventory").fadeIn();

        document.getElementById("inventory").style.visibility = "visible";
        document.getElementById("second_inventory").style.visibility = "visible";
    }else{

        $("#inventory").fadeOut();
        $("#second_inventory").fadeOut();

        document.getElementById("inventory").style.visibility = "hidden";
        document.getElementById("second_inventory").style.visibility = "hidden";
    }
}


function closeContainers() {

    $("#main_inventory_contents").html('');
	$("#second_inventory_contents").html('');
    
	//dialog.removeDialogHolder();

	FirstDraggedItemData   = null;
	SecondDraggedItemData  = null;

    $.post("http://tp_containers/nui:close", JSON.stringify({}));

}

function displayPage(page, cb){
    document.getElementsByClassName(page)[0].style.visibility = cb;
  
    [].forEach.call(document.querySelectorAll('.' + page), function (el) {
      el.style.visibility = cb;
    });
}

function sendNotification(text, color, cooldown){

	cooldown = cooldown == cooldown == null || cooldown == 0 || cooldown === undefined ? 4500 : cooldown;
  
	$("#notification_message").text(text);
	$("#notification_message").css("color", color);
	$("#notification_message").fadeIn();
  
	setTimeout(function() { $("#notification_message").text(""); $("#notification_message").fadeOut(); }, cooldown);
  }
  

function financial(x) {
    return Number.parseFloat(x).toFixed(0);
}

function ConvertWeight(weight, convert){

	let currentWeight = weight;

	if (convert) {
		currentWeight = financial(weight * 100 / 100000);
		
		if (weight < 100) {
			return currentWeight = 0.0;
		}

	}

	return financial(currentWeight);
}

function getItemIMG(item){
	return 'nui://' + INVENTORY_IMAGES_SOURCE_PATH + item + '.png';
}