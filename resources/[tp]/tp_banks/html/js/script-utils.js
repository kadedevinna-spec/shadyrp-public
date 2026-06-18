
var TRANSACTION_CLASS_TYPE            = null;
var TRANSACTION_ACTION_TYPE           = "MAIN";
var SELECTED_ACCOUNT_TYPE             = 0;
var CURRENT_IBAN                      = null;


let TRANSACTION_DEFAULT_DEPOSIT       = 0;
let TRANSACTION_DEFAULT_DEPOSIT_GOLD  = 0;

let TRANSACTION_DEFAULT_WITHDRAW      = 0;
let TRANSACTION_DEFAULT_WITHDRAW_GOLD = 0;

let TRANSACTION_JOINT_DEPOSIT         = 0;
let TRANSACTION_JOINT_DEPOSIT_GOLD    = 0;

let TRANSACTION_JOINT_WITHDRAW        = 0;
let TRANSACTION_JOINT_WITHDRAW_GOLD   = 0;

let TRANSACTION_DEFAULT_TRANSFER      = 0;
let TRANSACTION_JOINT_TRANSFER        = 0;

let CREATE_JOINT_ACCOUNT_COST         = 0;

let LOGGED_IN_ACCOUNT_TYPE            = "MAIN";

let IS_ACCOUNT_OWNER                  = true;
let SELECTED_IBAN_ACCOUNT             = null;

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

  $("#banking").hide();

  displayPage("banking_account_create_page", "visible");
  $(".banking_account_create_page").fadeOut();

  displayPage("banking_mainpage", "visible");
  $(".banking_mainpage").fadeOut();

  displayPage("banking_transaction_options_page", "visible");
  $(".banking_transaction_options_page").fadeOut();

  displayPage("banking_transactions_action_page", "visible");
  $(".banking_transactions_action_page").fadeOut();

  displayPage("banking_transactions_history_page", "visible");
  $(".banking_transactions_history_page").fadeOut();

  displayPage("banking_account_management_page", "visible");
  $(".banking_account_management_page").fadeOut();

  displayPage("banking_billing_page", "visible");
  $(".banking_billing_page").fadeOut();

  displayPage("banking_account_page", "visible");
  $(".banking_account_page").fadeOut();

  displayPage("banking_account_create_joint_page", "visible");
  $(".banking_account_create_joint_page").fadeOut();

  displayPage("banking_account_management_members_page", "visible");
  $(".banking_account_management_members_page").fadeOut();

  displayPage("banking_account_member_perms_page", "visible");
  $(".banking_account_member_perms_page").fadeOut();

  displayPage("notification", "visible");
  $("#notification_message").fadeOut();

  $("#banking_transaction_iban_input").hide();

  $("#banking_account_page_create_joint_button").hide();

  $('#banking_transactions_button').text(Locales['MAIN_BUTTON_TRANSACTIONS']);

  $('#banking_management_button').text(Locales['MAIN_BUTTON_MANAGEMENT']);
  $('#banking_billing_button').text(Locales['MAIN_BUTTON_BILLING']);

  $("#banking_account_button").text(Locales['MAIN_BUTTON_ACCOUNTS']);
  $('#banking_exit_button').text(Locales['EXIT']);

  $("#banking_mainpage_title").text(Locales['MAIN_TITLE']);

  $("#banking_account_page_title").text(Locales['ACCOUNT_TITLE']);

  $("#banking_account_create_page_title").text(Locales['ACCOUNT_REGISTER_TITLE']);
  $("#banking_account_create_page_button").text(Locales['ACCOUNT_REGISTER_BUTTON']);
  $("#banking_account_create_page_exit_button").text(Locales['EXIT']);

  /* Transaction Options Page */
  $("#banking_transaction_title_options_page").text(Locales['TRANSACTIONS_TITLE']);
  $("#banking_transaction_deposit_options_page").text(Locales['TRANSACTIONS_BUTTON_DEPOSIT']);
  $("#banking_transaction_withdraw_options_page").text(Locales['TRANSACTIONS_BUTTON_WITHDRAW']);
  $("#banking_transaction_transfer_options_page").text(Locales['TRANSACTIONS_BUTTON_TRANSFER']);
  $("#banking_transaction_transactions_options_page").text(Locales['TRANSACTIONS_BUTTON_TRANSACTIONS_HISTORY']);
  $("#banking_transaction_back_options_page").text(Locales['BACK']);

  $("#banking_transactions_reason_history_page").text(Locales['TRANSACTION_REASON_TITLE']);
  $("#banking_transactions_account_history_page").text(Locales['TRANSACTION_ACCOUNT_TITLE']);
  $("#banking_transactions_amount_history_page").text(Locales['TRANSACTION_AMOUNT_TITLE']);
  $("#banking_transactions_date_history_page").text(Locales['TRANSACTION_DATE_TITLE']);
  $("#banking_transactions_history_page_back_button").text(Locales['BACK']);
  $("#banking_transaction_accept_button").text(Locales['ACCEPT']);
  $("#banking_transactions_back_action_page").text(Locales['BACK']);

  $('#banking_account_management_page_title').text(Locales['MANAGEMENT_ACCOUNT_TITLE']);
  $("#banking_account_management_page_joint_members_button").text(Locales['MANAGEMENT_ACCOUNT_MANAGE_JOINT_MEMBERS']);
  $("#banking_account_management_page_joint_rename_button").text(Locales['MANAGEMENT_ACCOUNT_MANAGE_NAME']);
  $("#banking_account_management_page_storage_button").text(Locales['MANAGEMENT_ACCOUNT_MANAGE_BUY_VAULT']);
  $("#banking_account_management_page_job_button").text(Locales['MANAGEMENT_ACCOUNT_MANAGE_JOB_REGISTRY']);
  $("#banking_account_management_page_back_button").text(Locales['BACK']);

  $("#banking_account_management_page_joint_rename_title").text(Locales['MANAGEMENT_ACCOUNT_MANAGE_NAME_TITLE']);

  $("#banking_billing_page_action").text(Locales['BILLING_ACTIION_TITLE']);
  $("#banking_billing_page_reason").text(Locales['BILLING_REASON_TITLE']);
  $("#banking_billing_page_issuer").text(Locales['BILLING_ISSUER_TITLE']);
  $("#banking_billing_page_account").text(Locales['BILLING_ACCOUNT_TITLE']);
  $("#banking_billing_page_cost").text(Locales['BILLING_COST_TITLE']);
  $("#banking_billing_page_date").text(Locales['BILLING_DATE_TITLE']);

  $("#banking_billing_page_back_button").text(Locales['BACK']);

  /* ACCOUNT PAGE */
  $("#banking_account_page_create_joint_button").text(Locales['ACCOUNT_CREATE_JOINT_ACCOUNT']);
  $("#banking_account_page_back_to_main_button").text(Locales['ACCOUNT_BACK_TO_MAIN_ACCOUNT']);
  
  $("#banking_account_page_action").text(Locales['ACCOUNT_ACTION']);
  $("#banking_account_page_iban").text(Locales['ACCOUNT_IBAN']);
  $("#banking_account_page_name").text(Locales['ACCOUNT_NAME']);
  $("#banking_account_page_members").text(Locales['ACCOUNT_MEMBERS']);

  $("#banking_account_page_back_button").text(Locales['BACK']);
  $("#banking_account_page_title").text(Locales['ACCOUNT_TITLE']);

  $("#banking_account_create_joint_page_title").text(Locales['ACCOUNT_CREATE_TITLE']);
  $("#banking_account_create_joint_page_back_button").text(Locales['BACK']);

  $("#banking_account_create_joint_page_button").text(Locales['ACCOUNT_CREATE_BUTTON']);

  $("#banking_transaction_current").text(Locales[0]);

  /* MEMBERS MANAGEMENT PAGE */

  $("#banking_account_management_members_page_title").text(Locales['MEMBERS_MANAGEMENT_TITLE']);
  $("#banking_account_management_members_page_add_button").text(Locales['MEMBERS_MANAGEMENT_ADD_MEMBER']);

  $("#banking_account_management_members_page_iban").text(Locales['MEMBERS_MANAGEMENT_ACCOUNT_IBAN']);
  $("#banking_account_management_members_page_username").text(Locales['MEMBERS_MANAGEMENT_ACCOUNT_USERNAME']);
  $("#banking_account_management_members_page_action").text(Locales['MEMBERS_MANAGEMENT_ACCOUNT_ACTION']);

  $("#banking_account_management_members_page_back_button").text(Locales['BACK']);
  $("#banking_account_member_perms_page_back_button").text(Locales['BACK']);

}) .catch( err => { console.error(err); });


function playAudio(sound) {
	var audio = new Audio('./audio/' + sound);
	audio.volume = Config.DefaultClickSoundVolume;
	audio.play();
}

function sendNotification(text, color, cooldown){

  cooldown = cooldown == cooldown == null || cooldown == 0 || cooldown === undefined ? 4000 : cooldown;

  $("#notification_message").text(text);
  $("#notification_message").css("color", color);
  $("#notification_message").fadeIn();

  setTimeout(function() { $("#notification_message").text(""); $("#notification_message").fadeOut(); }, cooldown);
}

function load(src) {
  return new Promise((resolve, reject) => {
      const image = new Image();
      image.addEventListener('load', resolve);
      image.addEventListener('error', reject);
      image.src = src;
  });
}

function randomIntFromInterval(min, max) { // min and max included 
  return Math.floor(Math.random() * (max - min + 1) + min)
}

function displayPage(page, cb){
  document.getElementsByClassName(page)[0].style.visibility = cb;

  [].forEach.call(document.querySelectorAll('.' + page), function (el) {
    el.style.visibility = cb;
  });
}

function onNumbers(evt){
  // Only ASCII character in that range allowed
  var ASCIICode = (evt.which) ? evt.which : evt.keyCode;
  
  if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
      return false;
  return true;
}


function onCostNumbers(evt){
	// Only ASCII character in that range allowed
	var ASCIICode = (evt.which) ? evt.which : evt.keyCode;

	if (ASCIICode == 46) { return true; }
	if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
		return false;
	return true;
}

function LoadBackgroundImage(imageUrl) {
  const image = 'img/' + imageUrl + '.png';
  load(image).then(() => {
    document.getElementById("banking").style.backgroundImage = `url(${image})`;
  });
}

function closeBanking() {
  $('#banking').fadeOut();

  $(".banking_account_create_page").fadeOut();
  $(".banking_mainpage").fadeOut();

  $(".banking_transaction_options_page").fadeOut();
  $(".banking_transactions_action_page").fadeOut();
  $(".banking_transactions_history_page").fadeOut();

  $(".banking_billing_page").fadeOut();
  $(".banking_account_page").fadeOut();

  CurrentPageClassName = null;
  CurrentPageType      = null;
  SELECTED_ACCOUNT_TYPE   = 0;

  $('#banking_transaction_amount_input').val(1);
  $("#banking_transaction_current").text(Locales[0]);

  $('#history_records').html('');
  $('#history_records_pages_list').html('');
  $('#billings').html('');
  $('#billings_pages_list').html('');
  $('#accounts').html('');
  $('#members').html('');

  $("#banking_transaction_transfer_fee_footer").text("");
  $("#banking_transaction_iban_input").hide();

  LOGGED_IN_ACCOUNT_TYPE = "MAIN";

	$.post('http://tp_banks/close', JSON.stringify({}));
}
