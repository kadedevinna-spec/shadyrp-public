var ImgPath = "";
var disabledDrag = false;
var isDropped = false;
var currentInventoryData = []
var targetId = 0;
var targetIsReady = false;
var isReady = false;
var tradesuccess = false;
var isCanCarry = 0;
var isCanCarryTarget = 0;
var currentCash = 0;
var currentGold = 0;
var description = []
var moneyData = {
  cash: 0,
  gold: 0
}

function sendRequest(id) {
  $.post(`https://${GetParentResourceName()}/sendRequest`, JSON.stringify({
      id: id,
  }));
}

$(document).ready(function () {

  function inputCount(data_itemlabel, data_itemname, data_itemCount, data_itemId) {
    $(".player-inventory-container").hide();
    $(".input-container").show();
    isDropped = true;
  
    $(".confirm-btn").off("click").on("click", function () {
      const inputAmount = parseInt($("#iteminputcount").val());
      const intCount = parseInt(data_itemCount);
  
      if (isNaN(inputAmount) || inputAmount < 1 || inputAmount > intCount) {
        return $.post(`https://${GetParentResourceName()}/Notify`, JSON.stringify({ text: "invalidAmount" }));
      }
  
      let found = false;
      for (let key in currentInventoryData) {
        let item = currentInventoryData[key];
        if (!item || (typeof item !== 'object')) continue;
      
        let itemSlotOrId = item.slot ?? item.id;
        if (itemSlotOrId === undefined || itemSlotOrId === null) continue;
      
        if (parseInt(itemSlotOrId) === parseInt(data_itemId)) {
          item.amount = (item.amount || item.count || 0) - inputAmount;
          found = true;
          break;
        }
      }
      
      setupInventory(currentInventoryData);
  
      $(".player-inventory-container").show();
      $(".input-container").hide();
  
      $(".player-trade-container").append(`
        <div class="trade-itembox" data-itemlabel="${data_itemlabel}" data-itemname="${data_itemname}" data-itemcount="${inputAmount}" data-itemid="${data_itemId}">
          <div class="tradeitempng" style="background-image: url(nui://${ImgPath}${data_itemname}.png)"></div>
          <span class="tradeitemcount">${inputAmount}</span>
        </div>
      `);
  
      $(".player-trade-container .trade-itembox").off("contextmenu").on("contextmenu", function () {
        const id = $(this).attr("data-itemid");
        const label = $(this).attr("data-itemlabel");
        const name = $(this).attr("data-itemname");
        const count = parseInt($(this).attr("data-itemcount"));
  
        let restored = false;
        for (let key in currentInventoryData) {
          let item = currentInventoryData[key];
        
          if (!item || (typeof item !== 'object')) continue;
        
          let itemSlotOrId = item.slot ?? item.id;
          if (itemSlotOrId === undefined || itemSlotOrId === null) continue;
        
          if (parseInt(itemSlotOrId) === parseInt(id)) {
            item.amount = (item.amount || item.count || 0) + count;
            restored = true;
            break;
          }
        }
        
        
  
        if (!restored) {
          currentInventoryData.push({
            id: id,
            label: label,
            name: name,
            amount: count
          });
        }
  
        setupInventory(currentInventoryData);
        $(this).remove();
  
        const updated = $(".player-trade-container").html();
        $.post(`https://${GetParentResourceName()}/syncItems`, JSON.stringify({ target: targetId, items: updated }));
      });
  
      const data = $(".player-trade-container").html();
      $.post(`https://${GetParentResourceName()}/syncItems`, JSON.stringify({ target: targetId, items: data }));
    });
  }
  
  
  

  $(".cancel-btn").on("click", function () {
    $(".player-inventory-container").show()
    // $(".player-trade-container").show()
    $(".input-container").hide()
  })
  $(".player-trade-container").droppable({
    accept: ".itembox",
    drop: function (event, ui) {
      var source = ui.draggable;
  
      var data_itemlabel = source.attr("data-itemlabel");
      var data_itemname = source.attr("data-itemname");
      var data_itemCount = source.attr("data-itemcount");
      var data_itemId = source.attr("data-itemid");
  
      // console.log("[DROP] Item: " + JSON.stringify({
      //   data_itemlabel,
      //   data_itemname,
      //   data_itemCount,
      //   data_itemId
      // }));
      
  
      inputCount(data_itemlabel, data_itemname, data_itemCount, data_itemId);
    }
  });
  
  



  $(".trade-itembox").hover(
    function () {
      var x = $(this).offset().left;
      var y = $(this).offset().top;

      var pageWidth = $(window).width();
      var pageHeight = $(window).height();
      var xPercent = (x / pageWidth) * 100;
      var yPercent = (y / pageHeight) * 100;
      $('.information-container').css({
        'top': yPercent + 4 + '%',
        'left': xPercent + 2 + '%'
      });
      $(".information-container").show();
    },
    function () {
      $(".information-container").hide();
    }
  );

  function setProgress(value) {
    $(".progress-value").css({
      'width': '0'
    })
    var curValue = 0;
    setInterval(function () {
      if (curValue == value) {
        return
      }
      curValue++;
      if (curValue > 75) {

        $(".progress-value").css({
          'background': `linear-gradient(90deg, rgba(255,255,255,1) 0%, rgba(255,255,255,1) 46%, rgba(82,255,250,1) 84%, rgba(82,255,250,1) 100%)`
        })
      } else if (curValue > 50) {

        $(".progress-value").css({
          'background': `linear-gradient(90deg, rgba(255,255,255,1) 0%, rgba(255,255,255,1) 46%, rgba(82,255,250,1) 84%, rgba(82,255,250,1) 100%)`
        })
      } else if (curValue > 25) {

        $(".progress-value").css({
          'background': `white`
        })
      } else {

        $(".progress-value").css({
          'background': `white`
        })
      }
      $(".progress-value").css({
        'width': `${curValue}%`
      })
    }, 30);
  }


  $(".information-container").hide();
  $(".container").hide();
  $(".input-container").hide();
  function setupInventory(items) {
    var itemcountttt = 0;
    var totalBoxes = 20;
    var itemArray = Array.isArray(items) ? items : Object.values(items);

    if (itemArray.length > totalBoxes) {
        totalBoxes = itemArray.length;
    }

    $(".inventory-container").html("");

    for (let i = 0; i < totalBoxes; i++) {
        $(".inventory-container").append(`
            <div class="itembox empty" id="draggable-item-${i}" data-itemid="" data-itemlabel="" data-itemname="" data-itemcount="0">
                <div class="itempng"></div>
                <span class="itemcount"></span>
            </div>
        `);
    }
    $(".inventory-container .itembox").each(function (index) {
      if (index < itemArray.length && itemArray[index] && typeof itemArray[index] === 'object') {
        var element = itemArray[index];
    
        var id = element.slot ?? element.id ?? `temp-${index}`;
        var label = element.label || "";
        var name = element.name || "";
        var count = element.amount ?? element.count ?? 0;
        var image = element.image || `${name}.png`;
    
        let meta = (typeof element.metadata === "object" && !Array.isArray(element.metadata)) ? element.metadata :
                   (typeof element.info === "object" && !Array.isArray(element.info)) ? element.info : {};
    
        let baseDesc = "";
    
        if (element.metadata && typeof element.metadata.description === "string" && element.metadata.description.trim() !== "") {
          baseDesc = element.metadata.description;
        }
        else if (element.info && typeof element.info.description === "string" && element.info.description.trim() !== "") {
          baseDesc = `<div>${element.info.description}</div>`;
          for (let key in element.info) {
            if (key !== "description" && element.info.hasOwnProperty(key)) {
              baseDesc += `<div>${key}: ${element.info[key]}</div>`;
            }
          }
        }
        else if (typeof element.description === "string" && element.description.trim() !== "") {
          baseDesc = element.description;
        } else if (typeof element.desc === "string" && element.desc.trim() !== "") {
          baseDesc = element.desc;
        } else {
          baseDesc = "Nice Item";
        }
    
        description[id] = baseDesc;
        itemcountttt += count;
    
        if (count > 0) {
          $(this).removeClass("empty");
          $(this).attr("data-itemid", id);
          $(this).attr("data-itemlabel", label);
          $(this).attr("data-itemname", name);
          $(this).attr("data-itemcount", count);
          $(this).find(".itempng").css('background-image', `url(nui://${ImgPath}${image})`);
          $(this).find(".itemcount").text(count);
        } else {
          $(this).addClass("empty");
          $(this).attr("data-itemid", "");
          $(this).attr("data-itemlabel", "");
          $(this).attr("data-itemname", "");
          $(this).attr("data-itemcount", "0");
          $(this).find(".itempng").css('background-image', "");
          $(this).find(".itemcount").text("");
        }
      }
    });
    
    var progressvalue = Math.floor(100 / Math.floor((200 / itemcountttt)));
    setProgress(progressvalue);
    $(".progressbar-count").html(`${itemcountttt}/200`);
    $(".container").show();

    $(".itembox").hover(
      function () {
          if ($(this).hasClass("empty")) return;
          var x = $(this).offset().left;
          var y = $(this).offset().top;
          var pageWidth = $(window).width();
          var pageHeight = $(window).height();
          var xPercent = (x / pageWidth) * 100;
          var yPercent = (y / pageHeight) * 100;
          $('.information-container').css({
              'top': yPercent + 4 + '%',
              'left': xPercent + 2 + '%'
          });
          $(".information-container").show();
          var id = $(this).attr("data-itemid");
          var desc = description[id];
          $(".info-desc").html(desc);
          $(".info-title").html($(this).attr("data-itemlabel"));
      },
      function () {
          $(".information-container").hide();
      }
    );

    $(".itembox").draggable({
        revert: "invalid",
        cursor: "move",
        appendTo: 'body',
        containment: '.container',
        scroll: false,
        helper: 'clone',
        zIndex: 99,
        start: function (event, ui) {
            if (disabledDrag || $(this).hasClass("empty")) {
                return false;
            }
            var currentWidth = $(this).width();
            var currentHeight = $(this).height();
            var newWidth = currentWidth * 0.75;
            var newHeight = currentHeight * 0.75;

            ui.helper.width(newWidth);
            ui.helper.height(newHeight);
        },
        stop: function (event, ui) {
            if (isDropped) {
                $(this).remove();
                isDropped = false;
            }
        }
    });
  }




  function checkReady() {
    $(`.player-trade-container .trade-itembox`).off('contextmenu');
    if (isReady === true && targetIsReady === true) {
      var table = []
      $(".player-trade-container .trade-itembox").each(function () {
        var itemid = $(this).data("itemid");
        var itemcount = $(this).data("itemcount");
        table[table.length] = { id: itemid, count: itemcount }
      });
      $.post(`https://${GetParentResourceName()}/tradeItemCarry`, JSON.stringify({
        target: targetId,
        items: table,
      }));

      $.post(`https://${GetParentResourceName()}/close`, JSON.stringify());
    }
  }

  function checkCarry() {
    if (isCanCarry === 2 && isCanCarryTarget === 2) {

      if (!tradesuccess) {
        tradesuccess = true
        var table = []
        $(".player-trade-container .trade-itembox").each(function () {
          var itemid = $(this).data("itemid");
          var itemcount = $(this).data("itemcount");
          table[table.length] = { id: itemid, count: itemcount }
        });
        $.post(`https://${GetParentResourceName()}/tradeItem`, JSON.stringify({
          target: targetId,
          items: table,
        }));
        $.post(`https://${GetParentResourceName()}/tradeMoney`, JSON.stringify({
          target: targetId,
          moneyData: moneyData,
        }));
      }
    } else if (isCanCarry === 1 || isCanCarryTarget === 1) {
      $.post(`https://${GetParentResourceName()}/notify`, JSON.stringify({
        text: "Neither of you has the inventory to make this exchange!"
      }));
    }
  }
  $("#tradeconfirm").on("click", function () {
    let isClicked = $(this).data("clicked") || false; 
  
    if (!isClicked) {
      $(".trade-ready").html(`<img src="nui://fx-trade/ui/assets/img/tick.png" alt="Tick">`);
      $(this).css({
          'background': "url('nui://fx-trade/ui/assets/img/boxwhite.png') center / 100% 100% no-repeat",
          'color': "black"
      });
      disabledDrag = true;
      isReady = true;
    } else {
      $(".trade-ready").html(""); 
      $(this).css({
          'background': "url('nui://fx-trade/ui/assets/img/boxblack.png') center / 100% 100% no-repeat",
          'color': "white"
      });
      disabledDrag = false;
      isReady = false;
    }
  
    // Sync her iki durumda da gönderilsin
    $.post(`https://${GetParentResourceName()}/syncButtons`, JSON.stringify({
      target: targetId,
      state: !isClicked
    }));
  
    $(this).data("clicked", !isClicked);
    checkReady();
  });
  


  $(document).keyup(function (e) {
    if (e.key === "Escape") {
      $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({
        target: targetId
      }));
    }
  });
  $(".goldcount, .cashcount").on("input", function () {
    let value = $(this).val();
    let cursorPosition = this.selectionStart;
    let cleanedValue = value.replace(/[^0-9.]/g, '');
    let parts = cleanedValue.split('.');
    if (parts.length > 2) {
      cleanedValue = parts[0] + '.' + parts.slice(1).join('');
    }
    if (parts[1]) {
      parts[1] = parts[1].substring(0, 2);
      cleanedValue = parts[0] + '.' + parts[1];
    }
    if (value !== cleanedValue) {
      let newCursorPosition = cursorPosition - (value.length - cleanedValue.length);
      $(this).val(cleanedValue);
      this.setSelectionRange(newCursorPosition, newCursorPosition);
    }
  });
  $(".goldcount").on("change", function () {
    if (isReady || targetIsReady) {
        $(this).val(moneyData.gold.toFixed(2));
    } else {
        var currentCount = parseFloat($(this).val());  
        if (currentCount > currentGold) {
            currentCount = currentGold;
            $(this).val(currentGold.toFixed(2));  
        } else if (currentCount < 1) {
            currentCount = 0;
            $(this).val(currentCount.toFixed(2)); 
        }
        moneyData.gold = currentCount;
        $.post(`https://${GetParentResourceName()}/syncv6`, JSON.stringify({
            type: 'gold',
            count: currentCount,
            target: targetId
        }));
    }
  });

  $(".cashcount").on("change", function () {
      if (isReady || targetIsReady) {
          $(this).val(moneyData.cash.toFixed(2));
      } else {
          var currentCount = parseFloat($(this).val());  
          if (currentCount > currentCash) {
              currentCount = currentCash;
              $(this).val(currentCash.toFixed(2));  
          } else if (currentCount < 1) {
              currentCount = 0;
              $(this).val(currentCount.toFixed(2)); 
          }
          moneyData.cash = currentCount;
          $.post(`https://${GetParentResourceName()}/syncv6`, JSON.stringify({
              type: 'cash',
              count: currentCount,
              target: targetId
          }));
      }
  });
  $(document).on("click", ".player", function () {
    $(".player").remove();  // Tüm oyuncu div'lerini kaldır
    $(".allplayers").hide().html(""); // Tüm içeriği temizle ve gizle
});

  window.addEventListener('message', function (event) {
    switch (event.data.action) {
      case 'openTrade':
        $(".player-trade-container").html("")
        $(".other-trade-container").html("")
        $("#tradeconfirm").css({
          'background': "url('nui://fx-trade/ui/assets/img/boxblack.png') center / 100% 100% no-repeat",
          'color': "white"
        });
        $("#otherconfirm").css({
          'background': "url('nui://fx-trade/ui/assets/img/boxblack.png') center / 100% 100% no-repeat",
          'color': "white"
        });
        $("#tradeconfirm").data("clicked", false); 
        $("#otherconfirm").data("clicked", false); 
        $("#otherconfirm").val("Waiting...");
        targetIsReady = false
        disabledDrag = false
        tradesuccess = false;
        moneyData.cash = 0
        moneyData.gold = 0
        $(".targetgold").val('0.0')
        $(".targetcash").val('0.0')
        let formattedCash = (moneyData.cash === 0) ? '0.0' : moneyData.cash.toFixed(2);
        let formattedGold = (moneyData.gold === 0) ? '0.0' : moneyData.gold.toFixed(2);
        $(".cashcount").val(formattedCash);
        $(".goldcount").val(formattedGold);
        isReady = false
        $(".other-ready").html("");
        $(".trade-ready").html("");
        targetId = event.data.targetid;
        currentInventoryData = event.data.items
        $.post(`https://${GetParentResourceName()}/getMoney`, JSON.stringify(), function (data) {
          $(".player-cash").html(`${data.cash}`)
          $(".player-gold").html(`${data.gold}`)
          currentCash = data.cash
          currentGold = data.gold
          setupInventory(event.data.items)
        });
        break;
      case 'syncv1':
        $(".other-trade-container").html(event.data.items)
        break;
      case 'syncv2':
          if (event.data.state === true) {
              $(".other-ready").html(`<img src="nui://fx-trade/ui/assets/img/tick.png" alt="Tick">`);
              $("#otherconfirm").css({
                'background': "url('nui://fx-trade/ui/assets/img/boxwhite.png') center / 100% 100% no-repeat",
                'color': "black"
              });
              $("#otherconfirm").val("Ready!");
              targetIsReady = true;
          } else {
              $(".other-ready").html("");
              $("#otherconfirm").css({
                'background': "url('nui://fx-trade/ui/assets/img/boxblack.png') center / 100% 100% no-repeat",
                'color': "white"
              });
              $("#otherconfirm").val("Waiting...");
              targetIsReady = false;
          }
          checkReady();
          break;
      case 'setCanCarry':
        isCanCarry = event.data.carry ? 2 : 1;
        checkCarry()
        break;
      case 'setCanCarryTarget':
        isCanCarryTarget = event.data.carry ? 2 : 1;
        checkCarry()
        break;
      case 'syncv5':
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify());
        break;
      case 'changeMoney':
        if (event.data.type === "cash") {

          $(".targetcash").val(event.data.count)
        } else if (event.data.type === "gold") {
          $(".targetgold").val(event.data.count)
        }
        break;
      case 'forceclose':
        // 

        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({
          target: targetId
        }));
        break;
        case 'updatePlayers':    
        var players = event.data.players;
        players.forEach(element => {
            var playerDiv = $(`.player[data-playerid='${element.label}']`);
    
            if (playerDiv.length) {
                playerDiv.css({
                    left: `${element.x * 100}%`,
                    top: `${element.y * 100}%`
                });
            } else {
                $(".allplayers").append(`
                    <div class="player" data-playerid="${element.label}" onclick="sendRequest(${element.label})"
                        style="left: ${element.x * 100}%; top: ${element.y * 100}%">
                        <iconify-icon icon="game-icons:trade"></iconify-icon>
                        <span id="playerid">ID:${element.label}</span>
                    </div>
                `);
            }
        });
        $(".allplayers").fadeIn(300); 
        break;
    
    case 'closePlayers':
        $(".player").remove(); 
        $(".allplayers").hide().html(""); 
        break;
    case 'setFramework':
      if (event.data.framework === "RSG") {
        ImgPath = "rsg-inventory/html/images/";
      } else if (event.data.framework === "RSG-OXINVENTORY") {
        ImgPath = "ox_inventory/web/images/";
      } else if (event.data.framework === "VORP") {
        ImgPath = "vorp_inventory/html/img/items/";
      }
      break;
    case 'close':
        // 
        $(".container").hide();
        setTimeout(() => {
          $(".container").hide();

        }, 1000);


        break;
    }
  });
});

