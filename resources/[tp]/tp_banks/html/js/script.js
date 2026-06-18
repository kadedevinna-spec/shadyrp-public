

$(function() {

	window.addEventListener('message', function(event) {
		
    var item = event.data;

    if (item.action === 'toggle') {
      item.toggle ? $("#banking").fadeIn() : $("#banking").fadeOut();

      if (item.toggle){
        
        LOGGED_IN_ACCOUNT_TYPE  = "MAIN";
        TRANSACTION_ACTION_TYPE = "MAIN";

        TRANSACTION_DEFAULT_DEPOSIT       = item.transaction_fees.DEFAULT_DEPOSIT;
        TRANSACTION_DEFAULT_DEPOSIT_GOLD  = item.transaction_fees.DEFAULT_DEPOSIT_GOLD;

        TRANSACTION_DEFAULT_WITHDRAW      = item.transaction_fees.DEFAULT_WITHDRAW;
        TRANSACTION_DEFAULT_WITHDRAW_GOLD = item.transaction_fees.DEFAULT_WITHDRAW_GOLD;
        
        TRANSACTION_JOINT_DEPOSIT         = item.transaction_fees.JOINT_DEPOSIT;
        TRANSACTION_JOINT_DEPOSIT_GOLD    = item.transaction_fees.JOINT_DEPOSIT_GOLD;

        TRANSACTION_JOINT_WITHDRAW        = item.transaction_fees.JOINT_WITHDRAW;
        TRANSACTION_JOINT_WITHDRAW_GOLD   = item.transaction_fees.JOINT_WITHDRAW_GOLD;

        TRANSACTION_DEFAULT_TRANSFER      = item.transaction_fees.DEFAULT_TRANSFER;
        TRANSACTION_JOINT_TRANSFER        = item.transaction_fees.JOINT_TRANSFER;

        CREATE_JOINT_ACCOUNT_COST         = item.joint_account_cost;

        // We hide the BACK TO MAIN ACCOUNT since the player when opening the Bank is already on MAIN.
        $("#banking_account_page_back_to_main_button").hide();

        if (!item.has_account){

          TRANSACTION_ACTION_TYPE = "MAIN";

          LoadBackgroundImage('default_empty');

          let $description = Locales['ACCOUNT_REGISTER_DESCRIPTION'].replace('<cost>', item.account_cost);
          $("#banking_account_create_page_description").text($description);

          $('.banking_account_create_page').fadeIn();

        }else{

          LoadBackgroundImage('default');

          $('.banking_mainpage').fadeIn();
        }
      
      }

    } else if (event.data.action == 'loadAccount'){

      TRANSACTION_ACTION_TYPE = "MAIN";
      CURRENT_IBAN            = event.data.iban;
      LOGGED_IN_ACCOUNT_TYPE  = event.data.account_type;

      $("#banking_account_page_create_joint_button").hide();

      $(".banking_account_page").fadeOut();
      $(".banking_account_create_joint_page").fadeOut();

      $('#banking_account_money_balance').fadeIn();
      $('#banking_account_gold_balance').fadeIn();

      LoadBackgroundImage('default');
      $('.banking_mainpage').fadeIn();

    } else if (event.data.action == 'registeredAccount') {

      $('.banking_account_create_page').hide();

      LoadBackgroundImage('default');
      $('.banking_mainpage').fadeIn();

    } else if (event.data.action == "loadBankingInformation"){
      var prod_client = event.data.client_det;

      $('#banking_account_iban').text(Locales['IBAN'] + prod_client.iban)
      $('#banking_account_username').text(prod_client.username);

      $("#banking_account_management_page_joint_rename_input").val(prod_client.username);

      $('#banking_account_money_balance').text(prod_client.cash);
      $('#banking_account_gold_balance').text(prod_client.gold);

      $("#banking_account_management_page_job_title").text(Locales['ACCOUNT_MANAGEMENT_CURRENT_JOB'].replace("<job>", prod_client.job_name.toUpperCase()));

      CURRENT_IBAN = prod_client.iban;

      if (prod_client.isOwner != null && prod_client.isOwner != undefined) {
        IS_ACCOUNT_OWNER = prod_client.isOwner;
      }

    } else if (event.data.action == 'resetBillingResults'){

      $('#billings').html('');
      $('#billings_pages_list').html('');

    } else if (event.data.action == "insertBill"){
      var prod_bill = event.data.result;

			$("#billings").append(
				`<div id="billings_main"> </div>` +
        `<div date = "` + prod_bill.date + `" class = "billings_label" id="billings_button">` + Locales['BILLING_PAY_BILL_BUTTON'] + `</div>` +
				`<div class = "billings_label" id="billings_reason">` + prod_bill.reason + `</div>` +
				`<div class = "billings_label" id="billings_issuer">` + prod_bill.issuer + `</div>` +
        `<div class = "billings_label" id="billings_account">` + prod_bill.account + `</div>` +
        `<div class = "billings_label" id="billings_cost">` + prod_bill.cost + `</div>` +
        `<div class = "billings_label" id="billings_date">` + prod_bill.date + `</div>`
      );

    } else if (event.data.action == 'setBillingTotalPages') {
      let pages    = event.data.total;
      let selected = event.data.selected;

      if (pages > 1 ) {

        $.each(new Array(pages + 1), function( value ) {
          if (value != 0){
            var opacity = selected == value ? '0.7' : null;
            $("#billings_pages_list").append(`<div page = "` + value + `" id="billings_pages_list_value" style = "opacity: ` + opacity + `;" >` + value + `</div>`);
          }
        });

      }else{
        $("#billings_pages_list").append(`<div page = "1" id="billings_pages_list_value" style = "opacity: 0.7;">1</div>`);
      }

    } else if (event.data.action == 'resetTransactionHistoryResults'){

      $('#history_records').html('');
      $('#history_records_pages_list').html('');

    } else if (event.data.action == "insertTransactionHistoryRecord"){
      var prod_record = event.data.result;

			$("#history_records").append(
				`<div id="history_records_main" ></div>` +
				`<div class = "history_record_label" id="history_records_reason">` + prod_record.reason + `</div>` +
				`<div class = "history_record_label" id="history_records_account">` + prod_record.account + `</div>` +
        `<div class = "history_record_label" id="history_records_amount">` + prod_record.amount + `</div>` +
        `<div class = "history_record_label" id="history_records_date">` + prod_record.date + `</div>`
      );
    
    } else if (event.data.action == 'setTransactionHistoryTotalPages') {
      let pages    = event.data.total;
      let selected = event.data.selected;

      if (pages > 1 ) {

        $.each(new Array(pages + 1), function( value ) {
          if (value != 0){
            var opacity = selected == value ? '0.7' : null;
            $("#history_records_pages_list").append(`<div page = "` + value + `" id="history_records_pages_list_value" style = "opacity: ` + opacity + `;" >` + value + `</div>`);
          }
        });

      }else{
        $("#history_records_pages_list").append(`<div page = "1" id="history_records_pages_list_value" style = "opacity: 0.7;">1</div>`);
      }
  
    } else if (event.data.action == 'resetAccounts'){

      $('#accounts').html('');

    } else if (event.data.action == "insertJointAccount"){
      let prod_account = event.data.result;

			$("#accounts").append(
				`<div id="accounts_main"> </div>` +
        `<div iban = "` + prod_account.iban + `" class = "accounts_label" id="accounts_button">` + Locales['ACCOUNT_ACTION_BUTTON'] + `</div>` +
				`<div class = "accounts_label" id="accounts_iban">` + prod_account.iban + `</div>` +
				`<div class = "accounts_label" id="accounts_name">` + prod_account.username + `</div>` +
        `<div class = "accounts_label" id="accounts_members">` + prod_account.members_count + `</div>`
      );

        
    } else if (event.data.action == 'resetJointAccountMembers'){

      $('#members').html('');

    } else if (event.data.action == "insertJointAccountMembers"){
      let prod_account = event.data.member_det;

			$("#members").append(
				`<div id="members_main"> </div>` +
				`<div class = "members_label" id="members_iban">` + prod_account.iban + `</div>` +
				`<div class = "members_label" id="members_username">` + prod_account.username + `</div>` +
        `<div fullname = "` + prod_account.username + `" iban = "` + prod_account.iban + `" class = "members_label" id="members_perms_button">` + Locales['MEMBERS_MANAGEMENT_ACCOUNT_PERMS_ACTION_BUTTON'] + `</div>` +
        `<div iban = "` + prod_account.iban + `" class = "members_label" id="members_button">` + Locales['MEMBERS_MANAGEMENT_ACCOUNT_ACTION_BUTTON'] + `</div>`
      );

    } else if (event.data.action == 'resetSelectedMemberPermissionsList') {

      $('#banking_account_member_perms_page_panel_list').html('');

    } else if (event.data.action == "insertSelectedMemberPermission") {
      let res = event.data.result;

      $("#banking_account_member_perms_page_panel_list").append(
        `<div id="banking_account_member_perms_page_panel_list_main"> </div>` +
        `<div class = "members_label" id="banking_account_member_perms_page_panel_list_label">` + res.label + `</div>` +
        // 👇 Add only ONE switch here
        `<div class="option">
        <label class="switch">
          <input type="checkbox" id="permission-switch" permission="` + res.permission + `" ${res.toggled == 1 ? 'checked' : ''}>
          <span class="slider"></span>
        </label>
     </div>`
      );


    } else if (event.data.action == 'setCreateJointAccountButtonVisibility'){

      if (LOGGED_IN_ACCOUNT_TYPE == 'MAIN') {
        $("#banking_account_page_back_to_main_button").hide();
        event.data.hide ? $("#banking_account_page_create_joint_button").hide() : $("#banking_account_page_create_joint_button").show();

      }else{
        $("#banking_account_page_create_joint_button").hide();
        $("#banking_account_page_back_to_main_button").show();
      }

    } else if (event.data.action == 'updateRegisteredJob'){

      $("#banking_account_management_page_job_title").text(Locales['ACCOUNT_MANAGEMENT_CURRENT_JOB'].replace("<job>", event.data.job.toUpperCase()));

    } else if (event.data.action == "sendNotification") {
      var prod_notify = event.data.notification_data;
      sendNotification(prod_notify.message, prod_notify.color);

    } else if (event.data.action == "close") {
  closeBanking();

} else if (event.data.action == "hardCloseBanking") {
  // Run TP Banks' normal close function first.
  // This is important because it usually tells the Lua/client side that the UI is closed.
  closeBanking();

  // Then force-reset all visible pages so they do not stack when reopened.
  setTimeout(function() {
    $(".banking_account_create_page").hide();
    $(".banking_mainpage").hide();
    $(".banking_account_page").hide();
    $(".banking_account_create_joint_page").hide();
    $(".banking_transaction_options_page").hide();
    $(".banking_transactions_action_page").hide();
    $(".banking_transactions_history_page").hide();
    $(".banking_billing_page").hide();
    $(".banking_account_management_page").hide();
    $(".banking_account_management_members_page").hide();
    $(".banking_account_member_perms_page").hide();

    $("#banking").hide();

    TRANSACTION_CLASS_TYPE = "mainpage";
    TRANSACTION_ACTION_TYPE = "MAIN";
    SELECTED_ACCOUNT_TYPE = 0;
  }, 150);
}

  });

  $("#banking").on("change", "#permission-switch", function () {
    let $switch = $(this);
    let $permission = $switch.attr('permission');

    const isOn = $(this).is(":checked") ? 1 : 0;

    $.post("http://tp_banks/update_member_permission", JSON.stringify({ 
      iban: CURRENT_IBAN, 
      targetIban: SELECTED_IBAN_ACCOUNT, 
      permission : $permission,
      toggle : isOn,
    }));

  });

  /* REGISTRATION */

  $("#banking").on("click", "#banking_account_create_page_button", function() {
    playAudio("button_click.wav");
    $.post("http://tp_banks/register", JSON.stringify({ }));
  });

  
  $("#banking").on("click", "#banking_account_create_page_exit_button", function() {
    playAudio("button_click.wav");
    closeBanking();
  });

  /*
    MAIN PAGE ACTIONS
  */

  // The specified button is used for closing the NUI.
  $("#banking").on("click", "#banking_exit_button", function() {
    playAudio("button_click.wav");
    closeBanking();
  });

  // The specified button is used for opening the transaction actions page.
  $("#banking").on("click", "#banking_transactions_button", function() {
    TRANSACTION_CLASS_TYPE  = "transaction_options_page";
    TRANSACTION_ACTION_TYPE = "TRANSACTION_OPTIONS";

    OnSelectedButtonPageOpen(false);
  });

  // The specified button is used for opening the transaction actions page.
  $("#banking").on("click", "#banking_management_button", function() {

    if (!IS_ACCOUNT_OWNER){
      playAudio("button_click.wav");
      sendNotification(Locales['ACTION_NOT_PERMITTED'], "rgba(255, 0, 0, 0.79)")
      return;
    }

    TRANSACTION_CLASS_TYPE  = "account_management_page";
    TRANSACTION_ACTION_TYPE = "ACCOUNT_MANAGEMENT";

    if (LOGGED_IN_ACCOUNT_TYPE == "MAIN") {
      $("#banking_account_management_page_storage_button").show();
      $("#banking_account_management_page_job_button").show();
      $("#banking_account_management_page_job_title").show();

      $("#banking_account_management_page_joint_members_button").hide();
      $("#banking_account_management_page_joint_rename_title").hide();
      $("#banking_account_management_page_joint_rename_button").hide();
      $("#banking_account_management_page_joint_rename_input").hide();

    }else{
      $("#banking_account_management_page_joint_members_button").show();
      $("#banking_account_management_page_joint_rename_title").show();
      $("#banking_account_management_page_joint_rename_button").show();
      $("#banking_account_management_page_joint_rename_input").show();

      $("#banking_account_management_page_storage_button").hide();
      $("#banking_account_management_page_job_button").hide();
      $("#banking_account_management_page_job_title").hide();
    }
      

    OnSelectedButtonPageOpen(false);
  });

  // The specified button is used for opening the billing page.
  $("#banking").on("click", "#banking_billing_button", function() {
    TRANSACTION_CLASS_TYPE  = "billing_page";
    TRANSACTION_ACTION_TYPE = "BILLING";

    OnSelectedButtonPageOpen(true);

    $('#billings').html('');
    $('#billings_pages_list').html('');

    $.post("http://tp_banks/requestBills", JSON.stringify({ iban : CURRENT_IBAN }));

  });

  // The specified button is used for opening the accounts page.
  $("#banking").on("click", "#banking_account_button", function() {
    TRANSACTION_CLASS_TYPE  = "account_page";
    TRANSACTION_ACTION_TYPE = "ACCOUNTS";

    OnSelectedButtonPageOpen(true);

    $('#accounts').html('');

    $.post("http://tp_banks/requestAccounts", JSON.stringify({}));

  });

  /*
    #1 TRANSACTIONS PAGE ACTIONS
  */

  $("#banking").on("click", "#banking_transaction_deposit_options_page", function() {
    TRANSACTION_CLASS_TYPE  = "transactions_action_page"; TRANSACTION_ACTION_TYPE = "DEPOSIT";

    // Action Texts
    $("#banking_transactions_title_action_page").text(Locales['TRANSACTIONS_DEPOSIT_TITLE']);
    $("#banking_transaction_input_title").text(Locales['TRANSACTIONS_DESC_AMOUNT_TO_DEPOSIT']);

    // reset
    SELECTED_ACCOUNT_TYPE = 0;
    $("#banking_transaction_current").text(Locales[0]);
    $("#banking_transaction_amount_input").val(1);

    let fee = LOGGED_IN_ACCOUNT_TYPE  == "MAIN" ? TRANSACTION_DEFAULT_DEPOSIT : TRANSACTION_JOINT_DEPOSIT;
    $("#banking_transactions_fees_description_action_page").text(Locales['TRANSACTIONS_DESC_FEE'].replace('<fee>', fee));

    OnSelectedButtonPageOpen(false);
  });

  $("#banking").on("click", "#banking_transaction_withdraw_options_page", function() {
    TRANSACTION_CLASS_TYPE  = "transactions_action_page"; TRANSACTION_ACTION_TYPE = "WITHDRAW";

    // Action Texts
    $("#banking_transactions_title_action_page").text(Locales['TRANSACTIONS_WITHDRAW_TITLE']);
    $("#banking_transaction_input_title").text(Locales['TRANSACTIONS_DESC_AMOUNT_TO_WITHDRAW']);

    // reset
    SELECTED_ACCOUNT_TYPE = 0;
    $("#banking_transaction_current").text(Locales[0]);
    $("#banking_transaction_amount_input").val(1);

    let fee = LOGGED_IN_ACCOUNT_TYPE  == "MAIN" ? TRANSACTION_DEFAULT_WITHDRAW : TRANSACTION_JOINT_WITHDRAW;
    $("#banking_transactions_fees_description_action_page").text(Locales['TRANSACTIONS_DESC_FEE'].replace('<fee>', fee));

    OnSelectedButtonPageOpen(false);
  });

  $("#banking").on("click", "#banking_transaction_transfer_options_page", function() {
    TRANSACTION_CLASS_TYPE = "transactions_action_page"; TRANSACTION_ACTION_TYPE = "TRANSFER";

    // Action Texts
    $("#banking_transactions_title_action_page").text(Locales['TRANSACTIONS_TRANSFER_TITLE']);
    $("#banking_transaction_input_title").text(Locales['TRANSACTIONS_DESC_AMOUNT_TO_TRANSFER']);
    
    // reset
    SELECTED_ACCOUNT_TYPE = 0;
    $("#banking_transaction_current").text(Locales[0]);
    $("#banking_transaction_amount_input").val(1);

    let fee = LOGGED_IN_ACCOUNT_TYPE == 'MAIN' ? TRANSACTION_DEFAULT_TRANSFER : TRANSACTION_JOINT_TRANSFER;
    $("#banking_transactions_fees_description_action_page").text(Locales['TRANSACTIONS_DESC_FEE'].replace('<fee>', fee));

    $("#banking_transaction_previous").hide();
    $("#banking_transaction_current").hide();
    $("#banking_transaction_next").hide();

    $("#banking_transaction_iban_input").val('');
    $("#banking_transaction_iban_input").show();

    OnSelectedButtonPageOpen(false);
  });

  $("#banking").on("click", "#banking_transaction_transactions_options_page", function() {
    TRANSACTION_CLASS_TYPE  = "transactions_history_page";
    TRANSACTION_ACTION_TYPE = "RECORDS";

    OnSelectedButtonPageOpen(true);

    $('#history_records').html('');
    $('#history_records_pages_list').html('');

    $.post("http://tp_banks/requestTransactionHistoryRecords", JSON.stringify({ iban : CURRENT_IBAN }));
  });


  $("#banking").on("click", "#banking_transaction_back_options_page", function() {
    OnBackButtonAction();
  });

  /*
    #1 TRANSACTION ACTIONS PAGE (DEPOSIT, WITHDRAW, TRANSFER, TRANSACTIONS HISTORY)
  */

  // The specified button is going back to the transaction options page.
  $("#banking").on("click", "#banking_transactions_back_action_page", function() {
    playAudio("button_click.wav");

    $(".banking_" + TRANSACTION_CLASS_TYPE).fadeOut();

    TRANSACTION_CLASS_TYPE  = "transaction_options_page";
    TRANSACTION_ACTION_TYPE = "TRANSACTION_OPTIONS";

    LoadBackgroundImage('default');

    $(".banking_" + TRANSACTION_CLASS_TYPE).fadeIn();

    $('#banking_account_money_balance').fadeIn();
    $('#banking_account_gold_balance').fadeIn();


    /* The following elements are from Transactions Actions Page. Those elements are getting reset because deposit, withdraw between transfer and transactions history,
       have element differences.
    */
    $("#banking_transaction_previous").show();
    $("#banking_transaction_current").show();
    $("#banking_transaction_next").show();

    $("#banking_transaction_iban_input").hide();

  });

  
  $("#banking").on("click", "#banking_transactions_history_page_back_button", function() {
    playAudio("button_click.wav");

    $(".banking_" + TRANSACTION_CLASS_TYPE).fadeOut();

    TRANSACTION_CLASS_TYPE  = "transaction_options_page";
    TRANSACTION_ACTION_TYPE = "TRANSACTION_OPTIONS";

    LoadBackgroundImage('default');

    $(".banking_" + TRANSACTION_CLASS_TYPE).fadeIn();

    $('#banking_account_money_balance').fadeIn();
    $('#banking_account_gold_balance').fadeIn();
  });

  $("#banking").on("click", "#history_records_pages_list_value", function() {
    playAudio("button_click.wav");

    var $button = $(this);
    var $selectedPage = $button.attr('page');

    $.post("http://tp_banks/selectTransactionsHistoryPage", JSON.stringify({ iban : CURRENT_IBAN, page: $selectedPage }));
  });

  $("#banking").on("click", "#billings_pages_list_value", function() {
    playAudio("button_click.wav");

    var $button = $(this);
    var $selectedPage = $button.attr('page');

    $.post("http://tp_banks/selectBillingPage", JSON.stringify({ iban : CURRENT_IBAN, page: $selectedPage }));
  });

  /*
    #2 ACCOUNT MANAGEMENT
  */

    $("#banking").on("click", "#banking_account_management_page_back_button", function() {
      OnBackButtonAction();
    });

    $("#banking").on("click", "#banking_account_management_page_job_button", function() {
      playAudio("button_click.wav");

      $.post("http://tp_banks/registerJob", JSON.stringify({ iban : CURRENT_IBAN }));
    });

$("#banking").on("click", "#banking_account_management_page_storage_button", function() {
  playAudio("button_click.wav");

  $.post("http://tp_banks/openOrBuyVInventoryVault", JSON.stringify({ iban : CURRENT_IBAN }));
});

    $("#banking").on("click", "#banking_account_management_page_joint_rename_button", function() {
      playAudio("button_click.wav");

      let $name = $("#banking_account_management_page_joint_rename_input").val();

      $('#banking_account_username').text($name);
      $.post("http://tp_banks/rename", JSON.stringify({ iban : CURRENT_IBAN, username : $name }));
    });


    $("#banking").on("click", "#banking_account_management_page_joint_members_button", function() {
      playAudio("button_click.wav");

      $(".banking_" + TRANSACTION_CLASS_TYPE).fadeOut();

      TRANSACTION_CLASS_TYPE  = "account_management_members_page";

      $.post("http://tp_banks/requestMembers", JSON.stringify({ iban : CURRENT_IBAN }));

      $('#banking_account_money_balance').fadeOut();
      $('#banking_account_gold_balance').fadeOut();

      LoadBackgroundImage('default_empty');
  
      $(".banking_" + TRANSACTION_CLASS_TYPE).fadeIn();
    });

    
    $("#banking").on("click", "#banking_account_management_members_page_back_button", function() {
      playAudio("button_click.wav");

      $(".banking_" + TRANSACTION_CLASS_TYPE).fadeOut();

      $('#banking_account_money_balance').fadeIn();
      $('#banking_account_gold_balance').fadeIn();

      LoadBackgroundImage('default');
  
      TRANSACTION_CLASS_TYPE  = "account_management_page";
      $(".banking_" + TRANSACTION_CLASS_TYPE).fadeIn();
    });

    $("#banking").on("click", "#banking_account_member_perms_page_back_button", function () {
      playAudio("button_click.wav");

      $(".banking_" + TRANSACTION_CLASS_TYPE).fadeOut();

      LoadBackgroundImage('default_empty');

      TRANSACTION_CLASS_TYPE = "account_management_members_page";
      $(".banking_" + TRANSACTION_CLASS_TYPE).fadeIn();
    });
  
    $("#banking").on("click", "#banking_account_management_members_page_add_button", function() {
      playAudio("button_click.wav");

      let $targetIban = $("#banking_account_management_members_page_add_input").val();

      $('#banking_account_management_members_page_add_input').val('');
      $.post("http://tp_banks/addMember", JSON.stringify({ iban : CURRENT_IBAN, targetIban : $targetIban }));
    });

    $("#banking").on("click", "#members_button", function() {
      playAudio("button_click.wav");

      let $button     = $(this);
      let $targetIban = $button.attr('iban'); 
  
      $.post("http://tp_banks/removeMember", JSON.stringify({ iban : CURRENT_IBAN, targetIban : $targetIban }));
    });

  $("#banking").on("click", "#members_perms_button", function () {
    playAudio("button_click.wav");

    let $button = $(this);
    let $targetIban = $button.attr('iban');
    let $fullname = $button.attr('fullname');

    $(".banking_" + TRANSACTION_CLASS_TYPE).fadeOut();

    $("#banking_account_member_perms_page_title").text($fullname);

    SELECTED_IBAN_ACCOUNT  = $targetIban;
    TRANSACTION_CLASS_TYPE = "account_member_perms_page";

    $.post("http://tp_banks/request_member_permissions", JSON.stringify({ iban: CURRENT_IBAN, targetIban: $targetIban }));

    LoadBackgroundImage('default_empty');

    $(".banking_" + TRANSACTION_CLASS_TYPE).fadeIn();
  });


  /*
    #3 BILLING PAGE
  */

  $("#banking").on("click", "#banking_billing_page_back_button", function() {
    playAudio("button_click.wav");
    $(".banking_" + TRANSACTION_CLASS_TYPE).fadeOut();

    TRANSACTION_CLASS_TYPE  = "mainpage";
    TRANSACTION_ACTION_TYPE = "MAIN";

    LoadBackgroundImage('default');

    $(".banking_" + TRANSACTION_CLASS_TYPE).fadeIn();

    $('#banking_account_money_balance').fadeIn();
    $('#banking_account_gold_balance').fadeIn();
  });

  /*
    #4 ACCOUNT PAGE
  */

  $("#banking").on("click", "#banking_account_page_back_button", function() {
    playAudio("button_click.wav");
    $(".banking_" + TRANSACTION_CLASS_TYPE).fadeOut();

    TRANSACTION_CLASS_TYPE  = "mainpage";
    TRANSACTION_ACTION_TYPE = "MAIN";

    LoadBackgroundImage('default');

    $(".banking_" + TRANSACTION_CLASS_TYPE).fadeIn();

    $('#banking_account_money_balance').fadeIn();
    $('#banking_account_gold_balance').fadeIn();
  });

  $("#banking").on("click", "#banking_account_page_create_joint_button", function() {
    playAudio("button_click.wav");

    $(".banking_account_page").fadeOut();

    let $description = Locales['ACCOUNT_CREATE_DESCRIPTION'].replace('<cost>', CREATE_JOINT_ACCOUNT_COST);
    $("#banking_account_create_joint_page_description").text($description);

    $(".banking_account_create_joint_page").fadeIn();
  });

  $("#banking").on("click", "#banking_account_create_joint_page_back_button", function() {
    playAudio("button_click.wav");

    $('#accounts').html('');
    $.post("http://tp_banks/requestAccounts", JSON.stringify({}));

    $(".banking_account_create_joint_page").fadeOut();
    $(".banking_account_page").fadeIn();

  });

  $("#banking").on("click", "#banking_account_create_joint_page_button", function() {
    playAudio("button_click.wav");

    $.post("http://tp_banks/createJointAccount", JSON.stringify({ iban : CURRENT_IBAN }));

    $(".banking_account_create_joint_page").fadeOut();
    $(".banking_account_page").fadeIn();
  });


  $("#banking").on("click", "#accounts_button", function() {
    playAudio("button_click.wav");

    let $button = $(this);
    let $iban = $button.attr('iban');

    $.post("http://tp_banks/changeAccount", JSON.stringify({ iban : $iban }));

  });

  $("#banking").on("click", "#banking_account_page_back_to_main_button", function() {
    playAudio("button_click.wav");

    $.post("http://tp_banks/changeToMainAccount", JSON.stringify({ }));
  });


  /*-----------------------------------------------------------
   Back Button Actions
  -----------------------------------------------------------*/

  function OnBackButtonAction(){
    playAudio("button_click.wav");

    LoadBackgroundImage('default');

    $('.banking_' + TRANSACTION_CLASS_TYPE).fadeOut();
    $('.banking_mainpage').fadeIn();

    $('#banking_transaction_amount_input').val(1);
    $("#banking_transaction_current").text(Locales[0]);

    TRANSACTION_CLASS_TYPE  = "mainpage";
    TRANSACTION_ACTION_TYPE = "MAIN";
    SELECTED_ACCOUNT_TYPE   = 0;

    $("#banking_transaction_transfer_fee_footer").text("");

    $("#banking_transaction_previous").show();
    $("#banking_transaction_current").show();
    $("#banking_transaction_next").show();

    $("#banking_transaction_iban_input").hide();

    $('#banking_transaction_iban_input').val(null);
  }

  /*-----------------------------------------------------------
  Currency Account Button Actions
  -----------------------------------------------------------*/

  $("#banking").on("click", "#banking_transaction_previous", function() {
    playAudio("button_click.wav");

    SELECTED_ACCOUNT_TYPE--;

    if (SELECTED_ACCOUNT_TYPE <= 0){
      SELECTED_ACCOUNT_TYPE = 0;
    }

    $("#banking_transaction_current").text(Locales[SELECTED_ACCOUNT_TYPE]);

    let feeDescription = 0;

    if (TRANSACTION_ACTION_TYPE == 'DEPOSIT') {
      feeDescription = SELECTED_ACCOUNT_TYPE == 0 ? TRANSACTION_DEFAULT_DEPOSIT : TRANSACTION_DEFAULT_DEPOSIT_GOLD;

      if (LOGGED_IN_ACCOUNT_TYPE != 'MAIN') {
        feeDescription = SELECTED_ACCOUNT_TYPE == 0 ? TRANSACTION_JOINT_DEPOSIT : TRANSACTION_JOINT_DEPOSIT_GOLD;
      }

    } else if (TRANSACTION_ACTION_TYPE == 'WITHDRAW') {
      feeDescription = SELECTED_ACCOUNT_TYPE == 0 ? TRANSACTION_DEFAULT_WITHDRAW : TRANSACTION_DEFAULT_WITHDRAW_GOLD;

      if (LOGGED_IN_ACCOUNT_TYPE != 'MAIN') {
        feeDescription = SELECTED_ACCOUNT_TYPE == 0 ? TRANSACTION_JOINT_WITHDRAW : TRANSACTION_JOINT_WITHDRAW_GOLD;
      }
      
    } else if (TRANSACTION_ACTION_TYPE == 'TRANSFER') {
      feeDescription = LOGGED_IN_ACCOUNT_TYPE == 'MAIN' ? TRANSACTION_DEFAULT_TRANSFER : TRANSACTION_JOINT_TRANSFER;
    }

    $("#banking_transactions_fees_description_action_page").text(Locales['TRANSACTIONS_DESC_FEE'].replace('<fee>', feeDescription));

  });


  $("#banking").on("click", "#banking_transaction_next", function() {
    playAudio("button_click.wav");

    SELECTED_ACCOUNT_TYPE++;

    if (SELECTED_ACCOUNT_TYPE >= 1){
      SELECTED_ACCOUNT_TYPE = 1;
    }

    $("#banking_transaction_current").text(Locales[SELECTED_ACCOUNT_TYPE]);

    let feeDescription = 0;

    if (TRANSACTION_ACTION_TYPE == 'DEPOSIT') {
      feeDescription = SELECTED_ACCOUNT_TYPE == 0 ? TRANSACTION_DEFAULT_DEPOSIT : TRANSACTION_DEFAULT_DEPOSIT_GOLD;

      if (LOGGED_IN_ACCOUNT_TYPE != 'MAIN') {
        feeDescription = SELECTED_ACCOUNT_TYPE == 0 ? TRANSACTION_JOINT_DEPOSIT : TRANSACTION_JOINT_DEPOSIT_GOLD;
      }

    } else if (TRANSACTION_ACTION_TYPE == 'WITHDRAW') {
      feeDescription = SELECTED_ACCOUNT_TYPE == 0 ? TRANSACTION_DEFAULT_WITHDRAW : TRANSACTION_DEFAULT_WITHDRAW_GOLD;

      if (LOGGED_IN_ACCOUNT_TYPE != 'MAIN') {
        feeDescription = SELECTED_ACCOUNT_TYPE == 0 ? TRANSACTION_JOINT_WITHDRAW : TRANSACTION_JOINT_WITHDRAW_GOLD;
      }
      
    } else if (TRANSACTION_ACTION_TYPE == 'TRANSFER') {
      feeDescription = LOGGED_IN_ACCOUNT_TYPE == 'MAIN' ? TRANSACTION_DEFAULT_TRANSFER : TRANSACTION_JOINT_TRANSFER;
    }

    $("#banking_transactions_fees_description_action_page").text(Locales['TRANSACTIONS_DESC_FEE'].replace('<fee>', feeDescription));

  });


  /*-----------------------------------------------------------
  Deposit Banking Page & Buttons Action
  -----------------------------------------------------------*/

  $("#banking").on("click", "#banking_transaction_accept_button", function() {
    playAudio("button_click.wav");

    var inputAmount = $('#banking_transaction_amount_input').val();

    if (TRANSACTION_ACTION_TYPE == "DEPOSIT" ) {

      $.post("http://tp_banks/executeTransactionType", JSON.stringify({ 
        iban    : CURRENT_IBAN,
        type    : 'DEPOSIT',
        account : SELECTED_ACCOUNT_TYPE,
        amount  : inputAmount,
      }));

      $('#banking_transaction_amount_input').val(1);

    }else if (TRANSACTION_ACTION_TYPE == "WITHDRAW" ) {

      $.post("http://tp_banks/executeTransactionType", JSON.stringify({ 
        iban    : CURRENT_IBAN,
        type    : 'WITHDRAW',
        account : SELECTED_ACCOUNT_TYPE,
        amount : inputAmount,
      }));

      $('#banking_transaction_amount_input').val(1);

    }else if (TRANSACTION_ACTION_TYPE == "TRANSFER" ) {
      var iban = $('#banking_transaction_iban_input').val();

      $.post("http://tp_banks/executeTransactionType", JSON.stringify({ 
        iban    : CURRENT_IBAN,
        type    : 'TRANSFER',
        account : 0,
        to_iban : iban,
        amount  : inputAmount,
      }));

      //$('#banking_transaction_iban_input').val(null);
      $('#banking_transaction_amount_input').val(1);
    }

  });


  /*-----------------------------------------------------------
  Transfer Banking Page & Buttons Action
  -----------------------------------------------------------*/
  
  $("#banking").on("click", "#banking_transferpage_accept_button", function() {
    playAudio("button_click.wav");

    var accountDropDown = document.getElementById("banking_t_account_select");
    var accountType =  accountDropDown.options[accountDropDown.selectedIndex].text;

    var accountBankDropDown = document.getElementById("banking_bank_select");
    var accountBank =  accountBankDropDown.options[accountBankDropDown.selectedIndex].text;

    var inputAmount = document.getElementById('banking_transfer_amount_input').value;

    $.post("http://tp_banks/requestAccountTransfer", JSON.stringify({ 
      bank : accountBank,
      type : accountType,
      amount : inputAmount,
    }));

    document.getElementById('banking_transfer_amount_input').value = 1;
  });


  /*-----------------------------------------------------------
  Billing Actions
  -----------------------------------------------------------*/

  $("#banking").on("click", "#billings_button", function() {
    playAudio("button_click.wav");

    let $button    = $(this);
    let $date      = $button.attr('date'); // date is the unique parameter.

    $.post("http://tp_banks/payBill", JSON.stringify({ iban : CURRENT_IBAN, date : $date }));

  });

  function OnSelectedButtonPageOpen(cb){
    playAudio("button_click.wav");

    if (cb){ LoadBackgroundImage('default_empty'); $('#banking_account_money_balance').hide(); $('#banking_account_gold_balance').hide(); }
    
    $('.banking_mainpage').fadeOut();
    $('.banking_transaction_options_page').fadeOut();

    // delay?
    $(".banking_" + TRANSACTION_CLASS_TYPE).fadeIn();
  }

window.addEventListener("message", function(event) {
  const data = event.data;

  if (data.action === "buyVaultFromNUI") {
    $.post("http://tp_banks/buyVaultStorage", JSON.stringify({ iban: data.iban }));
  }
});


});

