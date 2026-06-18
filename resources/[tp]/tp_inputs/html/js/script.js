$(function () {

  window.addEventListener('message', function (event) {

    var item = event.data;

    if (item.action == 'toggle') {

      document.body.style.display = item.toggle ? "block" : "none";

      if (item.toggle) {
        $("#tp_inputs").fadeIn();
      }

    } else if (event.data.action == "open") {

      var data = event.data.inputData;

      $("#buttons").html("");
      $("#buttons").hide();
      $("#buttons-close-button").hide();
      
      $("#text_input").hide();
      $("#left-action-button").show();
      $("#right-action-button").show();

      $("#title").text(data.title);

      let desc = data.desc != null ? data.desc : "";
      $("#description").text(desc);

      CONTAINS_TEXT_INPUT_PARAMETER = event.data.hasTextInput;
      CONTAINS_RETURNED_CLICKED_VALUES = event.data.returnClickedValue;
      CONTAINS_RETURNED_OPTION_VALUES = event.data.returnSelectedOptionValue;
      CONTAINS_RANGE_SELECTOR = event.data.returnSliderValue;
      CONTAINS_ADVANCED_RANGE_SELECTOR = event.data.returnAdvancedSliderValue;
      CONTAINS_ADVANCED_BUTTONS_SELECTOR = event.data.returnAdvancedButtonSelection;

      ADVANCED_RANGE_SELECTOR_DESC = data.cost_description;
      ADVANCED_RANGE_SELECTOR_COST = data.cost;
      ADVANCED_RANGE_SELECTOR_CURRENCY = data.cost_currency;

      if (CONTAINS_TEXT_INPUT_PARAMETER) {
        $("#text_input").show();
      }

      if (CONTAINS_RETURNED_OPTION_VALUES) {
        $("#text_input").hide();
        $("#options_select").fadeIn();

        var options = data.options;
        var x = document.getElementById("options_select");

        options.forEach((val) => {
          var option = document.createElement("option");
          option.text = val;
          x.add(option);

        });

      }

      
      if (CONTAINS_ADVANCED_BUTTONS_SELECTOR) {
        $("#text_input").hide();
        $("#range-selector-description-cost").text("");
        
        $("#left-action-button").hide();
        $("#right-action-button").hide();

        $("#buttons").show();
        $("#buttons-close-button").show();

        let buttons = data.buttons;

        buttons.forEach(function(item) {
          $("#buttons").append(
            `<div id="buttons-list-main" action_type="${item.action_type}">
                <div id="buttons-list-name">${item.label}</div>
                <div id="buttons-list-description">${item.description}</div>
             </div>
             <div>&nbsp;</div>`
          );
        });
      }

      if (CONTAINS_RANGE_SELECTOR) {
        $("#text_input").hide();
        $("#range-selector").attr("value", 1);

        $("#range-selector").attr("min", data.min);
        $("#range-selector").attr("max", data.max);

        $("#range-selector").val(1);
        $("#range-selector-value").text('1');

        $("#range-selector").fadeIn();
        $("#range-selector-value").fadeIn();

        if (CONTAINS_ADVANCED_RANGE_SELECTOR) {

          const desc = ADVANCED_RANGE_SELECTOR_DESC;
          const cost = Number(ADVANCED_RANGE_SELECTOR_COST);
          const currency = ADVANCED_RANGE_SELECTOR_CURRENCY;

          $("#range-selector-description-cost").text(
            `${desc}${cost.toFixed(2)}${currency}`
          );

          $("#range-selector-description-cost").fadeIn();
        }

      }

      $("#left-action-button").text(data.buttonparam1);
      $("#right-action-button").text(data.buttonparam2);

    } else if (event.data.action == "close") {
      CloseDialog();
    }

    const slider = document.getElementById("range-selector");
    const output = document.getElementById("range-selector-value");

    // Show initial value
    output.textContent = slider.value;

    // Update value while dragging
    slider.addEventListener("input", function () {
      output.textContent = this.value;

      if (CONTAINS_ADVANCED_RANGE_SELECTOR) {

        const v = Number(this.value);
        const desc = ADVANCED_RANGE_SELECTOR_DESC;
        const cost = Number(ADVANCED_RANGE_SELECTOR_COST);
        const currency = ADVANCED_RANGE_SELECTOR_CURRENCY;

        const total = v * cost;
        const formatted = total.toFixed(2);

        $("#range-selector-description-cost").text(
          `${desc}${formatted}${currency}`
        );

      }
    });


  });

  /*-----------------------------------------------------------
  General Action
  -----------------------------------------------------------*/

  $("#tp_inputs").on("click", "#buttons-close-button", function (event) {
    playAudio("button_click.wav");

    $.post("http://tp_inputs/sendbuttonclickedinput", JSON.stringify({
      input: "DECLINE",
    }));
  });

  $("#tp_inputs").on("click", "#buttons-list-main", function (event) {
    playAudio("button_click.wav");

    let $button  = $(this);
    let $action  = $button.attr('action_type');

    $.post("http://tp_inputs/sendbuttonclickedinput", JSON.stringify({
      input: $action,
    }));
  });

  $("#tp_inputs").on("click", "#left-action-button", function (event) {
    playAudio("button_click.wav");

    var returnedText = "ACCEPT"

    if (!CONTAINS_RETURNED_CLICKED_VALUES) {

      if (CONTAINS_TEXT_INPUT_PARAMETER) {
        returnedText = $("#text_input").val();

      } else if (CONTAINS_RETURNED_OPTION_VALUES) {
        returnedText = $("#options_select").val();
      }

    } else {
      returnedText = $("#left-action-button").text();
    }

    if (CONTAINS_RANGE_SELECTOR) {
      returnedText = $("#range-selector").val();
    }

    $.post("http://tp_inputs/sendbuttonclickedinput", JSON.stringify({
      input: returnedText,
    }));

  });

  $("#tp_inputs").on("click", "#right-action-button", function (event) {
    playAudio("button_click.wav");

    var returnedText = "DECLINE"

    if (CONTAINS_RETURNED_CLICKED_VALUES) {
      returnedText = $("#right-action-button").text();
    }

    $.post("http://tp_inputs/sendbuttonclickedinput", JSON.stringify({
      input: returnedText,
    }));

  });


});




