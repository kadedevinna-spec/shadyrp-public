
 (function(){
  try {
    var root = document.getElementById('sirevlc-confirm');
    if (!root) {
      var wrap = document.createElement('div');
      wrap.innerHTML = '<div id="sirevlc-confirm" class="sirevlc-hidden"><div class="sirevlc-backdrop"></div><div class="sirevlc-modal menu_header_1a"><div class="sirevlc-text" id="sirevlc-confirm-text">Are you sure want to discard all your changes ?</div><div class="sirevlc-actions"><button id="sirevlc-confirm-yes" class="sirevlc-btn sirevlc-yes">Yes</button><button id="sirevlc-confirm-no" class="sirevlc-btn sirevlc-no">No</button></div></div></div>';
      (document.body||document.documentElement).appendChild(wrap.firstChild);
      root = document.getElementById('sirevlc-confirm');
    }
    var txt = document.getElementById('sirevlc-confirm-text');
    var yesB = document.getElementById('sirevlc-confirm-yes');
    var noB  = document.getElementById('sirevlc-confirm-no');
    var _sirevlcConfirmLock = false;
    if (typeof window !== 'undefined') { window.__sirevlcConfirmLock = false; }
    function hide(){ if (root) root.classList.add('sirevlc-hidden'); _sirevlcConfirmLock = false; if (typeof window !== 'undefined') window.__sirevlcConfirmOpen = false; }
    function show(opts){
      _sirevlcConfirmLock = false; if (typeof window !== 'undefined') { window.__sirevlcConfirmOpen = true; window.__sirevlcConfirmLock = false; }
      if (!root) return;
      if (txt && opts && opts.text) txt.textContent = opts.text;
      if (yesB) yesB.textContent = (opts && opts.yes) ? opts.yes : 'Yes';
      if (noB)  noB.textContent  = (opts && opts.no)  ? opts.no  : 'No';
      window.__sirevlc_onYes = opts && opts.onYes;
      window.__sirevlc_onNo  = opts && opts.onNo;
      root.classList.remove('sirevlc-hidden');
    }
    if (yesB && !yesB.__sirevlcB){ yesB.__sirevlcB = true; yesB.addEventListener('click', function(){ if (!root || root.classList.contains('sirevlc-hidden')) return; if (_sirevlcConfirmLock) return; _sirevlcConfirmLock = true; hide(); try{ window.__sirevlc_onYes && window.__sirevlc_onYes(); }catch(e){} }); }
    if (noB  && !noB.__sirevlcB ){ noB.__sirevlcB  = true; noB.addEventListener('click', function(){ if (!root || root.classList.contains('sirevlc-hidden')) return; if (_sirevlcConfirmLock) return; _sirevlcConfirmLock = true; hide(); try{ window.__sirevlc_onNo  && window.__sirevlc_onNo();  }catch(e){} }); }
    window.addEventListener('keydown', function(e){
      if (!root || root.classList.contains('sirevlc-hidden')) return;
 
    }, true);
    window.ConfirmUI = { show: show, hide: hide };
    /* log disabled */('[NUI] ConfirmUI ready');
  } catch(e) { console.error('ConfirmUI init error', e); }
})();
 
function __sirevlcGetSliderDisplayLabel(element){
  try{
    var v = (typeof element.value !== 'undefined') ? element.value : element.min;
    var map = element.value_labels || element.valueLabels || element.value_labels_map;
    if (Array.isArray(map)){
      for (var i=0;i<map.length;i++){
        var ent = map[i] || {};
        var val = (typeof ent.VALUE !== 'undefined') ? ent.VALUE : ent.value;
        if (Number(val) === Number(v)) return (typeof ent.LABEL !== 'undefined') ? String(ent.LABEL) : String(ent.label);
      }
    } else if (map && typeof map === 'object'){
      var key = String(v);
      if (Object.prototype.hasOwnProperty.call(map, key)) return String(map[key]);
      if (Object.prototype.hasOwnProperty.call(map, Number(v))) return String(map[Number(v)]);
    }
    return String(v);
  }catch(e){ try{ console.warn('[slider labels] map error', e); }catch(_){ } return String(element && element.value); }
}

function __sirevlcSubmitWithConfirmNext(focused, elem){
  try{
    var menu = (MenuData.opened && MenuData.opened[focused.namespace] && MenuData.opened[focused.namespace][focused.name]) ? MenuData.opened[focused.namespace][focused.name] : null;
    if (!menu) { MenuData.submit(focused.namespace, focused.name, elem); return; }
    var elemWantsConfirm = false;
    var eText = null, eYes = 'Yes', eNo = 'No';
    if (elem) {
      if (elem.greyed) { return; }
      if (elem.confirmNext === true) {
        elemWantsConfirm = true;
        if (elem.confirmNextText && (""+elem.confirmNextText).trim().length) {
          eText = elem.confirmNextText;
        }
      } else if (elem.confirmNext !== false) {
        if (elem.confirmNextText && (""+elem.confirmNextText).trim().length) {
          elemWantsConfirm = true;
          eText = elem.confirmNextText;
        }
      }
      if (elem.confirmNextText_Yes) eYes = elem.confirmNextText_Yes;
      if (elem.confirmNextText_No)  eNo  = elem.confirmNextText_No;
    }
    if (elemWantsConfirm) {
      ConfirmUI.show({ text: eText || 'Are you sure want to proceed ?', yes: eYes, no: eNo,
        onYes: function(){ MenuData.submit(focused.namespace, focused.name, elem); },
        onNo: function(){ /* stay */ } });
      return;
    }
    if (menu.confirmNextText && (""+menu.confirmNextText).trim().length){
      var mYes = menu.confirmNextText_Yes || 'Yes';
      var mNo  = menu.confirmNextText_No  || 'No';
      ConfirmUI.show({ text: menu.confirmNextText, yes: mYes, no: mNo,
        onYes: function(){ MenuData.submit(focused.namespace, focused.name, elem); },
        onNo: function(){ /* stay */ } });
      return;
    }
    MenuData.submit(focused.namespace, focused.name, elem);
  }catch(e){ try{ console.error('[confirmNext] submit error', e); }catch(_){ } MenuData.submit(focused.namespace, focused.name, elem); }
}
(function () {
 
if (!window.__stepSlider) {
  window.__stepSlider = function(ns, nm, idx, dir){
    try {
      var menuRef = (window.MenuData && MenuData.opened && MenuData.opened[ns] && MenuData.opened[ns][nm]) ? MenuData.opened[ns][nm] : null;
      if (!menuRef || !menuRef.elements || !menuRef.elements[idx]) return;
      var element = menuRef.elements[idx];
      if (!element || element.type !== 'slider') return;
      if (typeof element.value === 'undefined') element.value = element.min;
      else {
  var _step = (typeof element.hop !== 'undefined') ? Number(element.hop) : (typeof element.step !== 'undefined' ? Number(element.step) : 1);
  var _prec = (String(_step).split('.')[1]||'').length;
  var _next = Number(element.value) + (dir < 0 ? -_step : _step);
  element.value = Number(_prec>0 ? _next.toFixed(_prec) : Math.round(_next));
}
      if (element.value < element.min) element.value = element.min;
      if (element.value > element.max) element.value = element.max;
      try {
        var menuEl = document.getElementById('menu_' + ns + '_' + nm);
        if (menuEl) {
          var items = menuEl.querySelectorAll('.menu-item');
          if (items && items[idx]) {
            var lbl = items[idx].querySelector('#slider-label'); if (lbl) lbl.textContent = __sirevlcGetSliderDisplayLabel(element);
          }
        }
      } catch (_){}
      try {
        var f = MenuData.getFocused && MenuData.getFocused();
        if (f) { MenuData.pos[ns][nm] = idx; f.currentElement = idx; }
      } catch (_){}
      if (MenuData.change) {
        MenuData.change(ns, nm, element);
      } else if (window.fetch) {
        try {
          var url = 'https://' + (MenuData && MenuData.ResourceName ? MenuData.ResourceName : 'sire_menu') + '/menu_change';
          var payload = JSON.stringify({ _namespace: ns, _name: nm, current: element, elements: menuRef.elements });
          fetch(url, { method: 'POST', headers: { 'Content-Type':'application/json; charset=UTF-8' }, body: payload });
        } catch (_){}
      }
      if (element && element.type === 'slider') {
        try {
          var rn = (window.MenuData && MenuData.ResourceName) ? MenuData.ResourceName : 'sire_menu';
          $.post('https://' + rn + '/playsound', JSON.stringify({ which: 'slider_step' }));
        } catch(_e){}
      }
    } catch (_){}
  };
}

 
(function(){
  function hasClass(el, cls){ return !!(el && el.classList && el.classList.contains(cls)); }
  function closestByClass(node, cls){ var n=node; while(n&&n!==document){ if(hasClass(n,cls)) return n; n=n.parentNode; } return null; }
  function getFocused(){ try{ var f=MenuData.getFocused && MenuData.getFocused(); if(!f) return null; return {ns:(f._namespace||f.namespace), nm:(f._name||f.name), f:f}; }catch(_){ return null; } }
  function findItemIndex(menuRoot, itemEl){ if(!menuRoot||!itemEl) return -1; var items=menuRoot.querySelectorAll('.menu-item'); for(var i=0;i<items.length;i++){ if(items[i]===itemEl) return i; } return -1; }
  function handle(ev){
    var t = ev.target || ev.srcElement;
    var btn = t && t.closest ? t.closest('.slider-step-btn') : null;
    var arrows = (!btn && t && t.closest) ? t.closest('.arrows') : null;
    if (!btn && !arrows) return; // ignore
    var itemEl = closestByClass(t, 'menu-item');
    var menuRoot = closestByClass(t, 'menu');
    var foc = getFocused(); if (!foc) return;
    var ns = foc.ns, nm = foc.nm;
    var idx = findItemIndex(menuRoot, itemEl); if (idx < 0) return;
    var dir = 0;
    if (btn) {
      var d = parseInt(btn.getAttribute('data-dir'),10); if (!isNaN(d)) dir = d;
    } else {
      // arrows container click → decide by half-click
      var rect = itemEl ? itemEl.getBoundingClientRect() : null;
      if (rect && ev.clientX) dir = (ev.clientX < rect.left + rect.width/2) ? -1 : 1;
    }
    try { ev.preventDefault(); ev.stopPropagation(); if (ev.stopImmediatePropagation) ev.stopImmediatePropagation(); } catch(_){}
    var menuRef = MenuData.opened && MenuData.opened[ns] && MenuData.opened[ns][nm];
    var el = menuRef && menuRef.elements ? menuRef.elements[idx] : null;
    if (!el || el.type !== 'slider' || dir === 0) return;
    try { MenuData.pos[ns][nm] = idx; foc.f.currentElement = idx; } catch(_){}
    window.__stepSlider(ns, nm, idx, dir);
  }
  document.addEventListener('pointerdown', handle, true);
  document.addEventListener('mousedown', handle, true);
  document.addEventListener('touchstart', handle, true);
})();
 
    var MenuTpl =
        '<div id="menu_{{_namespace}}_{{_name}}" style="height: 90%;" class="menu{{#menu_type}} menu-type-{{menu_type}}{{/menu_type}}{{#align}} align-{{align}}{{/align}}">' +
        '<div class="head"><span>{{{title}}}</span></div>' +
        '<div class="desciption">{{{subtext}}}</div>' +
        '<div class="topline"></div>' +
        '<div class="menu-items" style="height: 60%;max-height: unset;">' +
        '{{#elements}}' +
        '<div class="menu-item {{#selected}}selected{{/selected}} {{#isSlider}}slider{{/isSlider}} {{#isImgSlider}}imgslider{{/isImgSlider}} {{#isText}}text{{/isText}} {{^image}}no-image{{/image}} {{#greyed}}greyed{{/greyed}}">' +
        '{{#has_progress}}<div class="menu-progress-overlay menu-progress-overlay-base"></div><div class="menu-progress-overlay menu-progress-overlay-fill" style="width: {{_progressPercent}}%;"></div>{{/has_progress}}' +
        '{{#image}}<img class="item-image" src="{{{image}}}">{{/image}}' +
        '{{^isText}}' +
 
        '{{#is_crafting_menu}}' +
        '<div class="item-text-stack">' +
        '  <div id="item-label">{{{label}}}</div>' +
        '  {{#has_labelboosts}}<div class="labelboosts">{{#labelboosts_images}}<img class="labelboost-img" src="{{{src}}}">{{/labelboosts_images}}</div>{{/has_labelboosts}}' +
        '</div>' +
        '{{/is_crafting_menu}}' +
        '{{^is_crafting_menu}}' +
        '{{#has_sub_label}}<div class="item-text-block"><div id="item-label">{{{label}}}</div><div class="item-sublabel" style="{{{sub_label_style}}}">{{{sub_label}}}</div></div>{{/has_sub_label}}' +
        '{{^has_sub_label}}<div id="item-label">{{{label}}}</div>{{/has_sub_label}}' +
        '{{/is_crafting_menu}}' +
        '{{/isText}}' +
        '' +
        '{{#isText}}<div class="inputtext" style="width: 100%;height: 100%;">' +
        '<input id="{{{list_id}}}" type="text" oninput="rendertext(this)" style="width: 100%;height: 100%;background: transparent;border: none;color: white; font-family: crock;font-size: 15px;" placeholder="{{{label}}}">' +
        '</div>{{/isText}}' +
        '{{#isSlider}}<div class="arrows">' +
        
        '<div class="slider-value-group" data-name="{{name}}"><button class="slider-step-btn" data-dir="-1" aria-label="Diminuer">&lt;</button><div id="slider-label">{{{sliderLabel}}}</div><button class="slider-step-btn" data-dir="1" aria-label="Augmenter">&gt;</button></div>' +
        
        '</div>{{/isSlider}}' +
'{{#isImgSlider}}' +
'<div class="imgslider" data-index="{{_i}}">' +
'  <div class="imgslider-track {{^gradient}}imgslider-track-arrow{{/gradient}}" style="{{#gradient}}background: {{gradient}};{{/gradient}}">' +
'    <div class="imgslider-knob" style="left: {{_percent}}%;"></div>' +
'  </div>' +
'  <div class="imgslider-value-group" data-name="{{name}}"><div class="imgslider-label">{{{sliderLabel}}}</div></div>' +
'</div>' +
'{{/isImgSlider}}' +
'</div>' +
        '{{/elements}}' +
        '</div>' +
        '<div class="scrollbottom"></div>' +
        '{{#elements}}' +
        '{{#selected}}' +
        '<div class="options-amount">{{{list_id}}}/{{{list_max}}}</div>' +
        '<div style="display: flex;align-items: center;justify-content: space-evenly;flex-direction: column;align-content: center;margin:10px">' +
        '<div class="images" style="display: flex;flex-wrap: wrap;justify-content: center;flex-direction: row;width: 100%;">' +
        '{{#descriptionimages}}' +
        '<div style="display: flex;flex-wrap: wrap;flex-direction: column;align-items: flex-end;margin: 5px">' +
        '<span style="position: absolute;">{{{count}}}</span>' +
        '<img style="width: 100px ;height: 75px;background-image: url(nui://sire_menu/html/slot-bk.png);background-blend-mode: screen;background-repeat: round;align-content: center;padding: 10px;" src={{{src}}}>' +
        '<span style="width: 100%;text-align: center;">{{{text}}}</span>' +
        '</div>' +
        '{{/descriptionimages}}' +
        '</div>' +
        '<div class="desc-footer">  {{#desc_center}}<div class="desc-center">{{#desc_center_image}}<img class="desc-center-image" src="{{{desc_center_image}}}">{{/desc_center_image}}<span class="desc-center-text">{{{desc_center}}}</span></div>{{/desc_center}}  {{#has_desc_crafting}}<div class="crafting-recipe">  <div class="crafting-grid">    {{#desc_crafting}}<div class="crafting-ingredient">  <div class="crafting-imgwrap">    <img class="crafting-img" src="{{{image_resolved}}}">    <span class="crafting-count">{{{count}}}</span>  </div>  <div class="crafting-label">{{{label}}} x{{{count}}}</div></div>{{/desc_crafting}}  </div></div>{{/has_desc_crafting}}  {{#has_desc_rows}}    <div class="desc-rows">      {{#desc_rows}}<div class="desc-row {{#desc_centered}}desc-row-centered{{/desc_centered}}">  {{#desc_centered}}<div class="desc-row-centered"><span class="desc-centered-text{{#desc_centered_underline}} desc-centered-underline{{/desc_centered_underline}}" style="{{{_desc_centered_style}}}">{{{desc_centered}}}</span></div>{{/desc_centered}}{{^desc_centered}}<div class="desc-row-left">    {{#desc_left}}<span class="desc-left-text">{{{desc_left}}}</span>{{/desc_left}}  </div>  <div class="desc-row-right">    {{#desc_right_progress}}      <div class="progress-boxes">{{#_progress_boxes}}<span class="box {{#filled}}filled{{/filled}}"></span>{{/_progress_boxes}}</div>    {{/desc_right_progress}}    {{^desc_right_progress}}      {{#desc_right}}<span class="desc-right-text">{{{desc_right}}}</span>{{/desc_right}}      {{#desc_image}}<img class="desc-right-image" src="{{{desc_image}}}">{{/desc_image}}    {{/desc_right_progress}}  </div>{{/desc_centered}}</div>{{/desc_rows}}    </div>  {{/has_desc_rows}}  {{^has_desc_rows}}    <div class="desc-line">      {{#desc}}<span class="desc-text">{{{desc}}}</span>{{/desc}}      {{#desc_right}}<span class="desc-right-text">{{{desc_right}}}</span>{{/desc_right}}      {{^desc_right}}{{#desc_image}}<img class="sirevlc-img-rightonly" src="{{{desc_image}}}">{{/desc_image}}{{/desc_right}}    </div>  {{/has_desc_rows}}  {{#desc_price}}<div class="desc-price">  <div class="price-sep top"></div>  <div class="price-left">    <img class="price-gold-icon" src="nui://sire_menu/html/css/stamp_gold_1.png">    <span class="price-gold">      {{#desc_price_gold_text}}{{{desc_price_gold_text}}}{{/desc_price_gold_text}}      {{^desc_price_gold_text}}{{{desc_price.GOLD}}}{{/desc_price_gold_text}}    </span>  </div>  <div class="price-right">    <span class="price-dollar-sign">$</span>    <span class="price-dollars">      {{#desc_price_dollars}}{{{desc_price_dollars}}}{{/desc_price_dollars}}      {{^desc_price_dollars}}{{{desc_price.DOLLARS}}}{{/desc_price_dollars}}    </span>    <span class="price-cents underline">      {{#desc_price_cents}}{{{desc_price_cents}}}{{/desc_price_cents}}      {{^desc_price_cents}}00{{/desc_price_cents}}    </span>  </div>  <div class="price-sep bottom"></div></div>{{/desc_price}}{{#desc_sub}}<div class="desc-divider"></div><div class="desc-sub"><span class="desc-sub-text">{{{desc_sub}}}</span>{{#desc_sub_images}}<img class="desc-sub-image" src="{{{src}}}">{{/desc_sub_images}}</div>{{/desc_sub}}</div>{{#has_desc_tip}}<div class="desc-footer desc-tip">  {{#desc_center_tip}}<div class="desc-center desc-tip-block">{{#desc_center_tip_image}}<img class="desc-center-tip-image" src="{{{desc_center_tip_image}}}">{{/desc_center_tip_image}}<span class="desc-center-text">{{{desc_center_tip}}}</span></div>{{/desc_center_tip}}  {{#has_desc_rows_tip}}    <div class="desc-rows desc-tip-block">      {{#desc_rows_tip}}{{#desc_sub_center_tip}}<div class="desc-row desc-row-subcenter">  <div class="desc-subcenter">{{#desc_sub_center_tip_image}}<img class="desc-sub-center-tip-image" src="{{{desc_sub_center_tip_image}}}">{{/desc_sub_center_tip_image}}    <span class="desc-subcenter-text">{{{desc_sub_center_tip}}}</span>  </div></div>{{/desc_sub_center_tip}}{{^desc_sub_center_tip}}<div class="desc-row">  <div class="desc-row-left">    {{#desc_left_tip}}<span class="desc-left-text">{{{desc_left_tip}}}</span>{{/desc_left_tip}}  </div>  <div class="desc-row-right">    {{#desc_right_tip}}<span class="desc-right-text">{{{desc_right_tip}}}</span>{{/desc_right_tip}}    <div class="progress-boxes">{{#_progress_boxes_tip}}<span class="box {{#filled}}filled{{/filled}}"></span>{{/_progress_boxes_tip}}</div>  </div></div>{{/desc_sub_center_tip}}{{/desc_rows_tip}}    </div>  {{/has_desc_rows_tip}}  {{#desc_price_tip}}  <div class="desc-price desc-tip-block">  <div class="price-sep top"></div>  <div class="price-left">    <img class="price-gold-icon" src="nui://sire_menu/html/css/stamp_gold_1a.png">    <span class="price-gold">{{{desc_price_tip_gold_text}}}</span>  </div>  <div class="price-right">    <span class="price-dollar-sign">$</span>    <span class="price-dollars">{{#desc_price_tip_dollars}}{{{desc_price_tip_dollars}}}{{/desc_price_tip_dollars}}</span>    <span class="price-cents underline">      {{#desc_price_tip_cents}}{{{desc_price_tip_cents}}}{{/desc_price_tip_cents}}      {{^desc_price_tip_cents}}00{{/desc_price_tip_cents}}    </span>  </div>  <div class="price-sep bottom"></div></div>  {{/desc_price_tip}}  {{#desc_sub_tip}}<div class="desc-divider desc-tip-block"></div><div class="desc-sub desc-tip-block"><span class="desc-sub-text">{{{desc_sub_tip}}}</span></div>{{/desc_sub_tip}}</div>{{/has_desc_tip}}{{/selected}}' +
        '{{/elements}}' +
        '<br>' +
        '</div>' +
        '</div>';
 
function setupImgSliders(menuEl, namespace, name){
  try {
    var $menu = $(menuEl);
    $menu.find('.menu-item.imgslider .imgslider-track').each(function(idx, trackEl){
      var $track = $(trackEl);
      var $item = $track.closest('.menu-item');
      var itemIndex = (function(){ var $c=$track.closest('.imgslider'); return Number($c.attr('data-index')) || Number($c.data('index')) || Number($item.attr('data-index')) || Number($item.data('index')) || idx; })();

      function pickValue(evt){
        var rect = trackEl.getBoundingClientRect();
        var x = (evt.clientX - rect.left);
        var pct = Math.max(0, Math.min(1, x / rect.width));
        var menu = MenuData.opened[namespace][name];
        if (!menu) return;
        var e = menu.elements[itemIndex];
        if (!e) return;
        var min = (typeof e.min === 'undefined') ? 0 : Number(e.min);
        var max = (typeof e.max === 'undefined') ? 100 : Number(e.max);
        var step = (typeof e.hop !== 'undefined') ? Number(e.hop) : (typeof e.step !== 'undefined' ? Number(e.step) : 1);
        var raw = min + pct * (max - min);
        var snapped = Math.round(raw / step) * step;
        if (snapped < min) snapped = min;
        if (snapped > max) snapped = max;
        e.value = (Number.isInteger(step)) ? Math.round(snapped) : Number(snapped.toFixed(2));
        var knob = trackEl.querySelector('.imgslider-knob');
        if (knob){
          var knobPct = (max === min) ? 0 : ((e.value - min) / (max - min)) * 100;
          knob.style.left = knobPct + '%';
        }
        $item.find('.imgslider-label').text(e.value);
        MenuData.change(namespace, name, e);
      }

      $track.off('.sirevlcimg').on('mousedown.sirevlcimg', function(evt){
        evt.preventDefault();
        evt.stopPropagation();
        pickValue(evt);
        $(window).on('mousemove.sirevlcimg', pickValue);
        $(window).one('mouseup.sirevlcimg', function(){
          $(window).off('mousemove.sirevlcimg', pickValue);
          try {
            var rn = (window.MenuData && MenuData.ResourceName) ? MenuData.ResourceName : 'sire_menu';
            $.post('https://' + rn + '/playsound', JSON.stringify({ which: 'slider_step' }));
          } catch(_e){}
        });
      }).on('click.sirevlcimg', function(evt){
        evt.preventDefault();
        evt.stopPropagation();
        pickValue(evt);
      });
    });
  } catch(e){ console.error('[imgslider] bind error', e); }
}
 
    window.MenuData = window.MenuData || {};
    MenuData.ResourceName = 'sire_menu'; // will be overridden by Lua on open
    MenuData.opened = {};
    MenuData.focus = [];
    MenuData.pos = {};
    MenuData.scrollState = {}; // per-menu gating state
    var lastmenu;
 
    window.renderToElement = function (html) {
        if (typeof html !== 'string') html = String(html || '');
        html = html.trim();
        if (!html) return null;
        var tpl = document.createElement('template');
        tpl.innerHTML = html;
        return tpl.content.firstElementChild || null;
    };

    // === Scroll gating helpers ===
    function menuKey(namespace, name) { return namespace + '::' + name; }
    function getScrollState(namespace, name) {
        var key = menuKey(namespace, name);
        var st = MenuData.scrollState[key];
        if (!st) {
            st = { minDelayMs: 0, requireReady: false, ready: true, lastTs: 0 };
            MenuData.scrollState[key] = st;
        }
        return st;
    }
    function canNavigateNow(namespace, name) {
        var st = getScrollState(namespace, name);
        var now = Date.now();
        if (st.minDelayMs && (now - st.lastTs) < st.minDelayMs) return false;
        if (st.requireReady && !st.ready) return false;
        return true;
    }
    function noteNav(namespace, name) {
        var st = getScrollState(namespace, name);
        st.lastTs = Date.now();
        if (st.requireReady) st.ready = false; // block until SetScrollReady(true)
    }
 
    if (typeof window !== 'undefined' && typeof window.__sirevlcMenuTransitionLockUntil !== 'number') {
        window.__sirevlcMenuTransitionLockUntil = 0;
    }
    function __sirevlcLockMenuTransition(ms) {
        try {
            var dur = Number(ms || 0);
            if (!dur || dur < 0) dur = 0;
            if (typeof window !== 'undefined') {
                window.__sirevlcMenuTransitionLockUntil = Date.now() + dur;
            }
        } catch (e) {}
    }
    function __sirevlcIsMenuTransitionLocked() {
        try {
            if (typeof window === 'undefined') return false;
        } catch(_) {}
        try {
            return (typeof window !== 'undefined' && typeof window.__sirevlcMenuTransitionLockUntil === 'number' && Date.now() < window.__sirevlcMenuTransitionLockUntil);
        } catch (e) {
            return false;
        }
    }
 
    MenuData.open = function (namespace, name, data) {
        lastmenu = data.lastmenu;

        if (typeof MenuData.opened[namespace] === "undefined") {
            MenuData.opened[namespace] = {};
        }
        if (typeof MenuData.opened[namespace][name] !== "undefined") {
            MenuData.close(namespace, name);
        }
        if (typeof MenuData.pos[namespace] === "undefined") {
            MenuData.pos[namespace] = {};
        }

        for (var i = 0; i < data.elements.length; i++) {
            if (typeof data.elements[i].type === "undefined") {
                data.elements[i].type = "default";
            }
        }

        data._index = MenuData.focus.length;
        data._namespace = namespace;
        data._name = name;

        for (var j = 0; j < data.elements.length; j++) {
            data.elements[j]._namespace = namespace;
            data.elements[j]._name = name;
        }

        MenuData.opened[namespace][name] = data;
        MenuData.pos[namespace][name] = 0;

        for (var k = 0; k < data.elements.length; k++) {
            if (data.elements[k].selected) {
                MenuData.pos[namespace][name] = k;
            } else {
                data.elements[k].selected = false;
            }
        }

        MenuData.focus.push({ namespace: namespace, name: name });

        // Init scroll & submit gating state from data.scroll
        var cfg = (data && data.scroll) ? data.scroll : {};
        MenuData.scrollState[menuKey(namespace, name)] = {
            // navigation delay (UP/DOWN, etc.)
            minDelayMs: (typeof cfg.minDelayMs === 'number') ? cfg.minDelayMs : 0,
            // submit delay (ENTER / click)
            submitMinDelayMs: (typeof cfg.submitMinDelayMs === 'number') ? cfg.submitMinDelayMs : 0,
            // optional "ready" gating for scroll, preserved for backward compatibility
            requireReady: (cfg && cfg.requireReady === true),
            ready: (cfg && cfg.requireReady === true) ? false : true,
            // last timestamps
            lastTs: 0,
            lastSubmitTs: 0
        };

                // Dynamic menu sizing from Lua data
        try {
            if (data && typeof data.menu_items_height === 'number') {
                document.documentElement.style.setProperty('--menu-items-height', data.menu_items_height + '%');
            } else {
                document.documentElement.style.removeProperty('--menu-items-height');
            }
            if (data && typeof data.desc_footer_max_height === 'number') {
                document.documentElement.style.setProperty('--desc-footer-max-height', data.desc_footer_max_height + 'em');
            } else {
                document.documentElement.style.removeProperty('--desc-footer-max-height');
            }
        } catch(_e) {}

        // Dynamic desc font/margins from Lua data (opt-in)
        try {
            function __sirevlcCssUnit(v) {
                if (v === null || typeof v === 'undefined') return null;
                if (typeof v === 'number' && !isNaN(v)) return v + 'vh';
                var s = String(v).trim();
                if (!s.length) return null;
                // bare number as string -> vh
                if (!isNaN(s)) return Number(s) + 'vh';
                return s; // assume caller provided a valid CSS unit (e.g. 3vh, 18px)
            }

            var f = __sirevlcCssUnit(data && data.desc_center_font);
            if (f) document.documentElement.style.setProperty('--desc-center-font', f);
            else document.documentElement.style.removeProperty('--desc-center-font');

            var m = __sirevlcCssUnit(data && data.desc_sub_up_margin);
            if (m) document.documentElement.style.setProperty('--desc-sub-up-margin', m);
            else document.documentElement.style.removeProperty('--desc-sub-up-margin');
        } catch(_e2) {}

        __sirevlcLockMenuTransition( (data && data.scroll && typeof data.scroll.submitMinDelayMs === 'number' && data.scroll.submitMinDelayMs > 0) ? data.scroll.submitMinDelayMs : 180 );

MenuData.render();
        var sel = document.querySelector("#menu_" + namespace + "_" + name + " .menu-item.selected");
        if (sel) sel.scrollIntoView({ block: 'nearest' }); 
    };

    MenuData.close = function (namespace, name) {
        if (MenuData.opened[namespace]) {
            delete MenuData.opened[namespace][name];
        }

        for (var i = 0; i < MenuData.focus.length; i++) {
            if (MenuData.focus[i].namespace === namespace && MenuData.focus[i].name === name) {
                MenuData.focus.splice(i, 1);
                break;
            }
        }
        MenuData.render(); 
    };

    MenuData.render = function () {
        var menuContainer = document.getElementById('menus');
        var focused = MenuData.getFocused();
        menuContainer.innerHTML = '';
        $(menuContainer).hide();

        for (var namespace in MenuData.opened) {
            for (var name in MenuData.opened[namespace]) {
                var menuData = MenuData.opened[namespace][name];
                var view = JSON.parse(JSON.stringify(menuData));

                // Expose menu type (Lua: data.type) to templates as a CSS class hook.
                try {
                    if (view && typeof view.type !== 'undefined' && view.type !== null) {
                        view.menu_type = String(view.type);
                    } else {
                        view.menu_type = null;
                    }
                } catch(_e) { view.menu_type = null; }

                // Small helper to resolve image paths (supports full URLs, .png, and bare names)
                function __sirevlcResolveImg(p){
                    try {
                        if (!p) return null;
                        p = String(p);
                        if (p.indexOf('https://') === 0 || p.indexOf('http://') === 0 || p.indexOf('nui://') === 0) return p;
                        if (p.indexOf('.png') !== -1) return 'nui://sire_menu/html/' + p;
                        return 'nui://sire_menu/html/' + p + '.png';
                    } catch(_){ return null; }
                }

                for (var i = 0; i < menuData.elements.length; i++) {
                    var element = view.elements[i];
 
                    element.is_crafting_menu = (view && view.menu_type === 'crafting');
 
                    try {
                        element.has_progress = (typeof element.progress !== 'undefined' && element.progress !== null);
                        if (element.has_progress) {
                            var p = Number(element.progress);
                            if (!isNaN(p)) {
                                // accept 0..1 (ratio) or 0..100 (percent)
                                if (p <= 1) p = p * 100;
                                p = Math.max(0, Math.min(100, p));
                            } else {
                                p = 0;
                            }
                            element._progressPercent = p;
                        } else {
                            element._progressPercent = 0;
                        }

                        element.has_sub_label = (typeof element.sub_label !== 'undefined' && element.sub_label !== null && String(element.sub_label).length > 0);
                        if (element.has_sub_label) {
                            var c = (typeof element.sub_label_color !== 'undefined' && element.sub_label_color !== null) ? String(element.sub_label_color) : '';
                            element.sub_label_style = c && c.length ? ('color: ' + c + ';') : '';
                        } else {
                            element.sub_label_style = '';
                        }
                    } catch(_e) {
                        element.has_progress = false;
                        element._progressPercent = 0;
                        element.has_sub_label = false;
                        element.sub_label_style = '';
                    }

                    // === Normalize desc structures ===
                    if (Array.isArray(element.desc_rows)) {
                        element.has_desc_rows = element.desc_rows.length > 0;
                    } else if (element.desc && Array.isArray(element.desc)) {
                        element.desc_rows = element.desc.slice(0);
                        element.has_desc_rows = element.desc_rows.length > 0;
                        element.desc = null;
                    } else {
                        element.has_desc_rows = false;
                    }
 
                    if (element && typeof element.desc === 'string') {
                        var _d = element.desc.trim();
                        if (_d.length > 0 &&
                            !element.desc_center &&
                            !element.desc_left &&
                            !element.desc_right &&
                            !element.desc_sub &&
                            !element.desc_tip) {
                            element.desc_center = _d;
                            element.desc = null;
                        }
                    }
 
                    if (element && Array.isArray(element.desc_rows)) {
                        element.desc_rows = element.desc_rows.map(function(row){
                            if (row && row.desc_right_progress && typeof row.desc_right_progress.value !== 'undefined' && typeof row.desc_right_progress.max !== 'undefined') {
                                var val = Math.max(0, parseInt(row.desc_right_progress.value, 10) || 0);
                                var max = Math.max(1, parseInt(row.desc_right_progress.max, 10) || 1);
                                var arr = [];
                                for (var k = 0; k < max; k++) { arr.push({ filled: k < val }); }
                                row._progress_boxes = arr;
                            }

                            if (row && row.desc_centered) {
                                var fs = row.desc_centered_size;
                                var fw = row.desc_centered_weight;
                                var style = '';
                                if (typeof fs !== 'undefined' && fs !== null && fs !== '') {
                                    if (typeof fs === 'number' || (typeof fs === 'string' && /^[0-9]+(\.[0-9]+)?$/.test(fs.trim()))) {
                                        fs = String(fs).trim() + 'px';
                                    }
                                    style += 'font-size:' + fs + ';';
                                }
                                if (typeof fw !== 'undefined' && fw !== null && fw !== '') {
                                    style += 'font-weight:' + fw + ';';
                                }
                                row._desc_centered_style = style;
                            }
                            return row;
                        });
                    }
 
                    if (element && element.desc_price) {
                        var gp = parseFloat(element.desc_price.GOLD);
                        if (!isNaN(gp)) {
 
                            element.desc_price_gold_text = (Math.round(gp*10)/10).toFixed(1);
                        }
                        var dp = parseFloat(element.desc_price.DOLLARS);
                        if (!isNaN(dp)) {
                            var parts = (Math.round(dp*100)/100).toFixed(2).split('.');
                            element.desc_price_dollars = parts[0];
                            element.desc_price_cents = parts[1];
                        }
                    }
 
                    if (Array.isArray(element.desc_rows_tip)) {
                        element.has_desc_rows_tip = element.desc_rows_tip.length > 0;
                    } else {
                        element.has_desc_rows_tip = false;
                    }
                    if (element && Array.isArray(element.desc_rows_tip)) {
                        element.desc_rows_tip = element.desc_rows_tip.map(function(row){
                            if (row && row.desc_right_progress_tip &&
                                typeof row.desc_right_progress_tip.value !== 'undefined' &&
                                typeof row.desc_right_progress_tip.max !== 'undefined') {
                                var val = Math.max(0, parseInt(row.desc_right_progress_tip.value, 10) || 0);
                                var max = Math.max(1, parseInt(row.desc_right_progress_tip.max, 10) || 1);
                                var arr = [];
                                for (var k = 0; k < max; k++) { arr.push({ filled: k < val }); }
                                row._progress_boxes_tip = arr;
                            }
                            return row;
                        });
                    }
 
                    if (element && element.desc_price_tip) {
                        var gp2 = parseFloat(element.desc_price_tip.GOLD);
                        if (!isNaN(gp2)) {
                            element.desc_price_tip_gold_text = (Math.round(gp2*10)/10).toFixed(1);
                        }
                        var dp2 = parseFloat(element.desc_price_tip.DOLLARS);
                        if (!isNaN(dp2)) {
                            var parts2 = (Math.round(dp2*100)/100).toFixed(2).split('.');
                            element.desc_price_tip_dollars = parts2[0];
                            element.desc_price_tip_cents = parts2[1];
                        }
                    }
                    element.has_desc_tip = !!(element.desc_center_tip || element.has_desc_rows_tip || element.desc_price_tip || element.desc_sub_tip);

                    if (element && element.desc_center_img && !element.desc_center_image) {
                        element.desc_center_image = element.desc_center_img;
                    }

                    if (element && element.desc_sub_img) {
                        if (Array.isArray(element.desc_sub_img)) {
                            element.desc_sub_images = element.desc_sub_img.map(function(src){ return { src: src }; });
                        } else if (typeof element.desc_sub_img === 'string') {
                            element.desc_sub_images = [{ src: element.desc_sub_img }];
                        }
                    }


if (element.image) {
                        if (element.image.indexOf("https://") === 0 || element.image.indexOf("http://") === 0) {
                            // as-is
                        } else if (element.image.indexOf(".png") !== -1) {
                            element.image = "nui://sire_menu/html/" + element.image;
                        } else {
                            element.image = "nui://sire_menu/html/" + element.image + ".png";
                        }
                    }
 
                    element.labelboosts_images = null;
                    element.has_labelboosts = false;
                    try {
                        if (element && element.labelboosts && typeof element.labelboosts === 'object') {
                            var _lbs = [];
                            var _keys = ['first_image','second_image','third_image'];
                            for (var _k=0; _k<_keys.length; _k++) {
                                var _p = element.labelboosts[_keys[_k]];
                                if (_p) {
                                    var _r = __sirevlcResolveImg(_p);
                                    if (_r) _lbs.push({ src: _r });
                                }
                            }
                            if (_lbs.length > 0) {
                                element.labelboosts_images = _lbs;
                                element.has_labelboosts = true;
                            }
                        }
                    } catch(_e) { element.labelboosts_images = null; element.has_labelboosts = false; }
 
                    element.has_desc_crafting = false;
                    try {
                        if (element && Array.isArray(element.desc_crafting) && element.desc_crafting.length > 0) {
                            element.desc_crafting = element.desc_crafting.map(function(it){
                                var o = it || {};
                                o.count = (typeof o.count !== 'undefined') ? o.count : 0;
                                o.image_resolved = __sirevlcResolveImg(o.image);
                                return o;
                            });
                            element.has_desc_crafting = true;
                        }
                    } catch(_e2) {
                        element.has_desc_crafting = false;
                    }
                    switch (element.type) {
                        case 'default':
                            element.list_id = i + 1;
                            element.list_max = menuData.elements.length;
                            break;
                        case 'slider':
                            element.isSlider = true;
                            element.list_id = i + 1;
                            element.list_max = menuData.elements.length;
                            element.sliderLabel = __sirevlcGetSliderDisplayLabel(element);
                            break;
                        
        case 'imgslider':
            element.isImgSlider = true;
            element.list_id = i + 1;
            element.list_max = menuData.elements.length;
            if (typeof element.step !== 'undefined' && typeof element.hop === 'undefined') {
                element.hop = element.step;
            }
            var mi = (typeof element.min === 'undefined') ? 0 : Number(element.min);
            var ma = (typeof element.max === 'undefined') ? 100 : Number(element.max);
            var va = (typeof element.value === 'undefined') ? mi : Number(element.value);
            if (ma === mi) { element._percent = 0; } else {
              element._percent = Math.max(0, Math.min(100, ( (va - mi) / (ma - mi) ) * 100));
            }
            element.sliderLabel = (typeof element.sliderLabel !== 'undefined') ? element.sliderLabel : __sirevlcGetSliderDisplayLabel(element);
            element._i = i;
            break;
    case 'text':
                            element.isText = true;
                            element.list_id = i + 1;
                            element.list_max = menuData.elements.length;
                            element.textPlaceHolder = (typeof element.options === 'undefined') ? element.value : element.options[element.value];
                            break;
                        default:
                            element.list_id = i + 1;
                            element.list_max = menuData.elements.length;
                            break;
                    }
                    if (i === MenuData.pos[namespace][name]) {
                        element.selected = true;
                    }
                }
 
                var html = Mustache.render(MenuTpl, view);
                var menuEl = window.renderToElement(html);
                if (!menuEl) {
                    console.error('[sire_menu] Mustache render failed for menu view:', view);
                    continue;
                }
                menuEl.style.display = 'none';
                menuContainer.appendChild(menuEl);
 
                bindMouseControls(menuEl, namespace, name);
                if (typeof setupImgSliders === 'function') { setupImgSliders(menuEl, namespace, name); }
            }
        }

        if (typeof focused !== 'undefined' && focused) {
            var showEl = document.getElementById('menu_' + focused.namespace + '_' + focused.name);
            if (showEl) showEl.style.display = '';
        }

        $(menuContainer).show();
    };
 
    MenuData.submit = function (namespace, name, data) {

        
        if (data && data.greyed) { return; }
 
        try {
            if (__sirevlcIsMenuTransitionLocked && __sirevlcIsMenuTransitionLocked()) {
                try { console.log('[submitDelay] blocked submit during menu transition', namespace, name); } catch (e2) {}
                return;
            }
        } catch (e) {}
 
        try {
            if (typeof getScrollState === 'function') {
                var st = getScrollState(namespace, name);
                if (st && st.submitMinDelayMs && st.submitMinDelayMs > 0) {
                    var now = Date.now();
                    var minDelay = st.submitMinDelayMs;
                    var last = 0;
                    if (typeof window !== 'undefined') {
                        if (typeof window.__sirevlcGlobalLastSubmitTs === 'number') {
                            last = window.__sirevlcGlobalLastSubmitTs;
                        } else {
                            window.__sirevlcGlobalLastSubmitTs = 0;
                        }
                    }
                    if ((now - last) < minDelay) {
                        try {
                            console.log('[submitDelay] blocked spam submit', namespace, name, 'delta=', (now - last), 'ms (minDelay=' + minDelay + 'ms)');
                        } catch (e2) {}
                        return;
                    }
                    if (typeof window !== 'undefined') {
                        window.__sirevlcGlobalLastSubmitTs = now;
                    }
                }
            }
        } catch (e) {
            try { console.error('[submitDelay] error while checking submit delay', e); } catch (_) {}
        }

        var rn = MenuData.ResourceName;
        /* log disabled */('[NUI] SUBMIT →', namespace, name, data && data.label, 'ResourceName=', rn);
        if (data === "backup") {
            $.post("https://" + rn + "/menu_submit", JSON.stringify({
                _namespace: namespace,
                _name: name,
                current: data,
                trigger: lastmenu,
                elements: MenuData.opened[namespace][name].elements
            })).done(function(){ /* log disabled */('[NUI] SUBMIT backup ok'); }).fail(function(e){ console.error('[NUI] SUBMIT fail', e); });
        } else {
            $.post("https://" + rn + "/menu_submit", JSON.stringify({
                _namespace: namespace,
                _name: name,
                current: data,
                elements: MenuData.opened[namespace][name].elements
            })).done(function(){ /* log disabled */('[NUI] SUBMIT ok'); }).fail(function(e){ console.error('[NUI] SUBMIT fail', e); });
        }
    };;

    // cancelReason: 'BACKSPACE' | 'ESCAPE' | 'UNKNOWN'
    MenuData.cancel = function (namespace, name, cancelReason) {
        var rn = MenuData.ResourceName;
        /* log disabled */('[NUI] CANCEL →', namespace, name, 'ResourceName=', rn);
        $.post("https://" + rn + "/menu_cancel", JSON.stringify({
            _namespace: namespace,
            _name: name,
            trigger: cancelReason || 'BACKSPACE'
        })).done(function(){ /* log disabled */('[NUI] CANCEL done'); }).fail(function(e){ console.error('[NUI] CANCEL fail', e); });
    };

    MenuData.change = function (namespace, name, data) {
        var rn = MenuData.ResourceName;
        /* log disabled */('[NUI] CHANGE →', namespace, name, data && data.label, 'ResourceName=', rn);
        $.post("https://" + rn + "/menu_change", JSON.stringify({
            _namespace: namespace,
            _name: name,
            current: data,
            elements: MenuData.opened[namespace][name].elements
        })).done(function(){ /* log disabled */('[NUI] CHANGE done'); }).fail(function(e){ console.error('[NUI] CHANGE fail', e); });
    };

    MenuData.getFocused = function () {
        return MenuData.focus[MenuData.focus.length - 1];
    };

    // ===== Mouse bindings =====
    function getItemsEl(namespace, name) {
        return document.querySelector('#menu_' + namespace + '_' + name + ' .menu-items');
    }
    function preserveScroll(namespace, name, doRender) {
        var el = getItemsEl(namespace, name);
        var prev = el ? el.scrollTop : null;
        doRender();
        var el2 = getItemsEl(namespace, name);
        if (el2 != null && prev != null) el2.scrollTop = prev;
    }

    function bindMouseControls(menuEl, namespace, name) {
        var $menu = $(menuEl);
 
        $menu.find('.menu-item').each(function (index, el) {
            $(el).off('mouseenter.sirevlc mouseover.sirevlc').on('mouseenter.sirevlc mouseover.sirevlc', function () {
                setSelection(namespace, name, index, false);
            });
        });
 
        $menu.find('.menu-item').each(function (index, el) {
            $(el).off('click.sirevlc').on('click.sirevlc', function (e) {
                e.preventDefault();
                var menu = 
 
function setupImgSliders(menuEl, namespace, name){
  var $menu = $(menuEl);
  $menu.find('.menu-item.imgslider .imgslider-track').each(function(idx, trackEl){
    var $track = $(trackEl);
    var $item = $track.closest('.menu-item.imgslider');
    var itemIndex = Number($item.data('index'));
    var dragging = false;

    function pickValue(evt){
      var rect = trackEl.getBoundingClientRect();
      var x = (evt.clientX - rect.left);
      var pct = x / rect.width;
      pct = Math.max(0, Math.min(1, pct));
      var menu = MenuData.opened[namespace][name];
      if (!menu) return;
      var e = menu.elements[itemIndex];
      if (!e) return;
      var min = (typeof e.min === 'undefined') ? 0 : Number(e.min);
      var max = (typeof e.max === 'undefined') ? 100 : Number(e.max);
      var step = (typeof e.hop !== 'undefined') ? Number(e.hop) : (typeof e.step !== 'undefined' ? Number(e.step) : 1);
      var raw = min + pct * (max - min);
      var snapped = Math.round(raw / step) * step;
      if (snapped < min) snapped = min;
      if (snapped > max) snapped = max;
      e.value = (Number.isInteger(step)) ? Math.round(snapped) : Number(snapped.toFixed(2));
      // update UI knob
      var knob = trackEl.querySelector('.imgslider-knob');
      if (knob){
        var knobPct = (max === min) ? 0 : ((e.value - min) / (max - min)) * 100;
        knob.style.left = knobPct + '%';
      }
      $item.find('.imgslider-label').text(e.value);
      MenuData.change(namespace, name, e);
    }

    $track.on('mousedown.sirevlc', function(evt){
      evt.preventDefault();
      evt.stopPropagation();
      dragging = true;
      pickValue(evt);
      $(window).on('mousemove.sirevlc', pickValue);
      $(window).one('mouseup.sirevlc', function(){
        $(window).off('mousemove.sirevlc', pickValue);
        dragging = false;
      });
    });
    // Click without drag
    $track.on('click.sirevlc', function(evt){
      evt.preventDefault();
      evt.stopPropagation();
      pickValue(evt);
    });
  });
}
var menu = MenuData.opened[namespace][name];
                if (!menu) return;
                var elem = menu.elements[index];
                /* log disabled */('[NUI] CLICK item', index, '→', elem && elem.label, 'type=', elem && elem.type);
                if (elem && elem.type === 'imgslider') {
                    // No submit on left click for imgslider
                    setSelection(namespace, name, index, false);
                    return;
                }
                if (elem && elem.type === 'slider') {
                    // Debounce to prevent double-hop and consume the click fully
                    if (!el.__sirevlcSliderClickLock) {
                        el.__sirevlcSliderClickLock = true;
                        var rect = el.getBoundingClientRect();
                        var midX = rect.left + rect.width / 2;
                        if (e.clientX < midX) simulateControl('LEFT'); else simulateControl('RIGHT');
                        setTimeout(function(){ el.__sirevlcSliderClickLock = false; }, 120);
                    }
                    e.preventDefault(); e.stopPropagation(); if (e.stopImmediatePropagation) e.stopImmediatePropagation();
                    return;
                }
                // Avoid CHANGE+SUBMIT firing on the same click when the mouse is over an item
                // that isn't the current selection (e.g. fast wheel scroll + requireReady/minDelay gating).
                // First click selects (CHANGE). Second click (or ENTER) submits.
                var curPos = (MenuData.pos && MenuData.pos[namespace]) ? MenuData.pos[namespace][name] : null;
                if (curPos !== null && typeof curPos === 'number' && index !== curPos) {
                    // Respect the same navigation gating used for UP/DOWN and hover selection.
                    if (!canNavigateNow(namespace, name)) {
                        e.preventDefault();
                        e.stopPropagation();
                        if (e.stopImmediatePropagation) e.stopImmediatePropagation();
                        return;
                    }
                    setSelection(namespace, name, index, false);
                    return;
                }
                setSelection(namespace, name, index, true);
            });
        });
    }

    function pruneRightVisuals(namespace, name) {
    try {
        var root = document.getElementById('menu_' + namespace + '_' + name);
        if (!root) { console.warn('[ConfirmUI] root not found'); return; }
        var right = root.querySelector('.desc-footer .desc-right');
        if (!right) return;
        var hasRightText = !!right.querySelector('.desc-right-text');
        if (hasRightText) {
            var imgs = right.querySelectorAll('.sirevlc-img-rightonly, img.desc-thumb');
            imgs.forEach(function(n){ n.parentNode && n.parentNode.removeChild(n); });
            var left = root.querySelector('.desc-footer .desc-left');
            if (left) {
                var limgs = left.querySelectorAll('img, .desc-thumb');
                limgs.forEach(function(n){ n.parentNode && n.parentNode.removeChild(n); });
            }
        }
    } catch(e) {}
}
function setSelection(namespace, name, index, submitAfter) {
        var menu = MenuData.opened[namespace][name];
        if (!menu) return;
        var current = MenuData.pos[namespace][name];
        var hoverOnly = (submitAfter === false);

        if (hoverOnly && !canNavigateNow(namespace, name)) return;
        if (index === current) {
            if (submitAfter) __sirevlcSubmitWithConfirmNext({ namespace: namespace, name: name }, menu.elements[index]);
            return;
        }

        MenuData.pos[namespace][name] = index;
        for (var i = 0; i < menu.elements.length; i++) {
            menu.elements[i].selected = (i === index);
        }

        var elem = menu.elements[index];
        noteNav(namespace, name);
        MenuData.change(namespace, name, elem);

        if (hoverOnly) {
            preserveScroll(namespace, name, function () { MenuData.render();   });
        } else {
            MenuData.render(); 
            var sel = document.querySelector('#menu_' + namespace + '_' + name + ' .menu-item.selected');
            if (sel) sel.scrollIntoView({ block: 'nearest' });
        }

        $.post('https://' + MenuData.ResourceName + '/playsound').done(function(){
            /* log disabled */('[NUI] playsound ok');
        }).fail(function(e){
            console.warn('[NUI] playsound failed', e);
        });

        if (submitAfter) {
            __sirevlcSubmitWithConfirmNext({ namespace: namespace, name: name }, elem);
        }
    }

    function simulateControl(key) {
        onData({ sire_menu_action: 'controlPressed', sire_menu_control: key });
    }
 
    var TameSlider = (function(){
        var root = null, track = null, ball = null, tolMin = null, tolMax = null, tolArea = null;
        var minTol = -20, maxTol = 20;
        var lastValue = 0;
        function q(){
            if (root) return;
            root = document.getElementById('sirevlc-tame-slider');
            if (!root) return;
            track = root.querySelector('.sirevlc-tame-track');
            ball  = root.querySelector('.sirevlc-tame-ball');
            tolMin = root.querySelector('.sirevlc-tame-tol-min');
            tolMax = root.querySelector('.sirevlc-tame-tol-max');
            tolArea = root.querySelector('.sirevlc-tame-tol-area');
        }
        function clamp(v, a, b){ return Math.max(a, Math.min(b, v)); }
        function valToPct(v){
            var vv = clamp(v, -100, 100);
            return (vv + 100) / 200 * 100;
        }
        function applyState(){
            if (!root) return;
            var inTol = (lastValue >= minTol && lastValue <= maxTol);
            if (inTol) root.classList.remove('sirevlc-tame-out');
            else root.classList.add('sirevlc-tame-out');
        }
        function applyTol(){
            if (!root) return;

            var pA = valToPct(minTol);
            var pB = valToPct(maxTol);
            var pMin = Math.min(pA, pB);
            var pMax = Math.max(pA, pB);

            if (tolMin) tolMin.style.left = pA + '%';
            if (tolMax) tolMax.style.left = pB + '%';

            if (tolArea){
                tolArea.style.left = pMin + '%';
                tolArea.style.width = Math.max(0, (pMax - pMin)) + '%';
            }

            applyState();
        }
        return {
            show: function(mi, ma){
                q();
                if (!root) return;
                minTol = (typeof mi === 'number') ? mi : minTol;
                maxTol = (typeof ma === 'number') ? ma : maxTol;
                applyTol();
                root.classList.remove('sirevlc-tame-hidden');
                root.setAttribute('aria-hidden','false');
            },
            hide: function(){
                q();
                if (!root) return;
                root.classList.add('sirevlc-tame-hidden');
                root.setAttribute('aria-hidden','true');
            },
            set: function(v){
                q();
                if (!root || !ball) return;
                lastValue = Number(v) || 0;
                var pct = valToPct(lastValue);
                ball.style.left = pct + '%';
                applyState();
            }
        };
    })();
 
    var RopeSlider = (function(){
        var root = null, track = null, ball = null, horse = null, tolArea = null, tolStart = null;
        var last = {
            ballPct: 0,
            horsePct: 0,
            tolStartPct: 0,
            tolWidthPct: 14,
            out: false,
            flip: false,
            wrongDir: false
        };
        function q(){
            if (root) return;
            root = document.getElementById('sirevlc-rope-slider');
            if (!root) return;
            track = root.querySelector('.sirevlc-rope-track');
            ball = root.querySelector('.sirevlc-rope-ball');
            horse = root.querySelector('.sirevlc-rope-horse');
            tolArea = root.querySelector('.sirevlc-rope-tol-area');
            tolStart = root.querySelector('.sirevlc-rope-tol-start');
        }
        function clamp(v,a,b){ return Math.max(a, Math.min(b, v)); }
        function apply(){
            if (!root) return;
            var b = clamp(last.ballPct, 0, 100);
            var h = clamp(last.horsePct, 0, 110); // allow a bit past 100 for visuals
            var w = clamp(last.tolWidthPct, 1, 60);
            var s = clamp(last.tolStartPct, -50, 100);

            if (ball) ball.style.left = b + '%';
            if (horse) horse.style.left = h + '%';
            if (tolStart) tolStart.style.left = s + '%';
            if (tolArea){
                tolArea.style.left = s + '%';
                tolArea.style.width = w + '%';
            }

            if (last.out) root.classList.add('sirevlc-rope-out');
            else root.classList.remove('sirevlc-rope-out');

            if (last.flip) root.classList.add('sirevlc-rope-flip');
            else root.classList.remove('sirevlc-rope-flip');

            if (horse){
                if (last.wrongDir) horse.classList.add('sirevlc-rope-wrongdir');
                else horse.classList.remove('sirevlc-rope-wrongdir');
            }
        }
        return {
            show: function(opts){
                q();
                if (!root) return;
                opts = opts || {};
                if (opts.ballPct !== undefined) last.ballPct = Number(opts.ballPct) || 0;
                if (opts.horsePct !== undefined) last.horsePct = Number(opts.horsePct) || 0;
                if (opts.tolStartPct !== undefined) last.tolStartPct = Number(opts.tolStartPct) || 0;
                if (opts.tolWidthPct !== undefined) last.tolWidthPct = Number(opts.tolWidthPct) || last.tolWidthPct;
                last.out = !!opts.out;
                if (opts.wrongDir !== undefined) last.wrongDir = !!opts.wrongDir;
                apply();
                root.classList.remove('sirevlc-rope-hidden');
                root.setAttribute('aria-hidden','false');
            },
            hide: function(){
                q();
                if (!root) return;
                last.flip = false;
                root.classList.remove('sirevlc-rope-flip');
                root.classList.add('sirevlc-rope-hidden');
                root.setAttribute('aria-hidden','true');
            },
            update: function(opts){
                q();
                if (!root) return;
                opts = opts || {};
                if (opts.ballPct !== undefined) last.ballPct = Number(opts.ballPct) || 0;
                if (opts.horsePct !== undefined) last.horsePct = Number(opts.horsePct) || 0;
                if (opts.tolStartPct !== undefined) last.tolStartPct = Number(opts.tolStartPct) || 0;
                if (opts.tolWidthPct !== undefined) last.tolWidthPct = Number(opts.tolWidthPct) || last.tolWidthPct;
                if (opts.out !== undefined) last.out = !!opts.out;
                if (opts.wrongDir !== undefined) last.wrongDir = !!opts.wrongDir;
                apply();
            },
            setFlip: function(flip){
                q();
                if (!root) return;
                last.flip = !!flip;
                apply();
            }
        };
    })();
 
    var HudInfo = (function(){
        var root, titleEl, rowsEl;

        function q(){
            if (root) return;
            root = document.getElementById('sire-hud-info');
            titleEl = document.getElementById('sire-hud-info-title');
            rowsEl = document.getElementById('sire-hud-info-rows');
        }

        function hide(){
            q();
            if (!root) return;
            root.classList.add('sire-hud-info-hidden');
            root.setAttribute('aria-hidden', 'true');
            if (titleEl) titleEl.textContent = '';
            if (rowsEl) rowsEl.innerHTML = '';
        }

        function show(payload){
            q();
            if (!root) return;
            payload = payload || {};

            if (titleEl) titleEl.textContent = payload.info_title || '';

            if (rowsEl) {
                var rows = Array.isArray(payload.info_rows) ? payload.info_rows : [];
                var html = '';
                for (var i=0;i<rows.length;i++) {
                    var r = rows[i] || {};
                    var left = (r.info_left != null) ? String(r.info_left) : '';
                    var rightHtml = '';
                    if (r.info_right_progress) {
                        var val = Math.max(0, parseInt(r.info_right_progress.value, 10) || 0);
                        var max = Math.max(1, parseInt(r.info_right_progress.max, 10) || 1);
                        if (val > max) val = max;
                        var boxes = '';
                        for (var j = 0; j < max; j++) boxes += '<span class="box' + (j < val ? ' filled' : '') + '"></span>';
                        rightHtml = '<div class="progress-boxes">' + boxes + '</div>';
                    } else {
                        var right = (r.info_right != null) ? String(r.info_right) : '';
                        rightHtml = escapeHtml(right);
                    }
                    html += '<div class="sire-hud-info-row">'
                         +   '<div class="sire-hud-info-left">' + escapeHtml(left) + '</div>'
                         +   '<div class="sire-hud-info-right">' + rightHtml + '</div>'
                         + '</div>';
                }
                rowsEl.innerHTML = html;
            }

            root.classList.remove('sire-hud-info-hidden');
            root.setAttribute('aria-hidden', 'false');
        }
 
        function escapeHtml(str){
            return String(str)
                .replace(/&/g,'&amp;')
                .replace(/</g,'&lt;')
                .replace(/>/g,'&gt;')
                .replace(/"/g,'&quot;')
                .replace(/'/g,'&#039;');
        }

        return { show: show, hide: hide };
    })();
 
    window.onData = function (payload) {
        var data = payload || {};
        switch (data.sire_menu_action) {

            case "tameSliderShow": {
                TameSlider.show(Number(data.minTol), Number(data.maxTol));
                if (data.value !== undefined) TameSlider.set(Number(data.value));
                break;
            }
            case "tameSliderHide": {
                TameSlider.hide();
                break;
            }
            case "tameSliderUpdate": {
                TameSlider.set(Number(data.value));
                break;
            }

            case "ropeSliderShow": {
                RopeSlider.show({
                    ballPct: Number(data.ballPct),
                    horsePct: Number(data.horsePct),
                    tolStartPct: Number(data.tolStartPct),
                    tolWidthPct: Number(data.tolWidthPct),
                    out: !!data.out,
                    wrongDir: !!data.wrongDir
                });
                break;
            }
            case "ropeSliderHide": {
                RopeSlider.hide();
                break;
            }
            case "ropeSliderUpdate": {
                RopeSlider.update({
                    ballPct: Number(data.ballPct),
                    horsePct: Number(data.horsePct),
                    tolStartPct: Number(data.tolStartPct),
                    tolWidthPct: Number(data.tolWidthPct),
                    out: !!data.out,
                    wrongDir: !!data.wrongDir
                });
                break;
            }

            case "ropeSliderFlip": {
                RopeSlider.setFlip(!!data.flip);
                break;
            }

            case "hudInfoShow": {
                HudInfo.show(data.payload || data.data || data.elements);
                break;
            }

            case "hudInfoHide": {
                HudInfo.hide();
                break;
            }

            case "showConfirmBack": {
                try {
                    var focused = MenuData.getFocused && MenuData.getFocused();
                    var text = data.text || (function(){
                        var cur = focused ? MenuData.opened[focused.namespace][focused.name] : null;
                        return cur && cur.confirmBackText || 'Are you sure want to discard all your changes ?';
                    })();
                    var yesL = data.yes || 'Yes';
                    var noL  = data.no  || 'No';
                    ConfirmUI.show({
                        text: text, yes: yesL, no: noL,
                        onYes: function(){
                            if (focused) {
                                MenuData.cancel(focused.namespace, focused.name, 'BACKSPACE');
                                $.post("https://" + MenuData.ResourceName + "/closeui", JSON.stringify({}));
                            }
                        },
                        onNo: function(){}
                    });
                } catch (e) { console.error('showConfirmBack failed', e); }
                break;
            }

            case "openMenu": {
 
                if (data.sire_menu_resourcename) {
                    MenuData.ResourceName = data.sire_menu_resourcename;
                }
                /* log disabled */('[NUI] openMenu for', data.sire_menu_namespace, data.sire_menu_name, 'ResourceName=', MenuData.ResourceName);
                MenuData.open(data.sire_menu_namespace, data.sire_menu_name, data.sire_menu_data);
                break;
            }
            case "closeMenu": {
                /* log disabled */('[NUI] closeMenu for', data.sire_menu_namespace, data.sire_menu_name);
                MenuData.close(data.sire_menu_namespace, data.sire_menu_name);
                break;
            }
            case "setScrollReady": {
                var st = getScrollState(data.sire_menu_namespace, data.sire_menu_name);
                st.ready = !!data.ready;
                /* log disabled */('[NUI] setScrollReady', data.sire_menu_namespace, data.sire_menu_name, 'ready=', st.ready);
                break;
            }
            case "pause_desc": {
                try {
                    var ms = Number(data.sire_menu_ms || data.ms || 0);
                    if (!ms || ms < 0) ms = 6000;
                    // Cancel any pending "hide later" timer
                    if (window.__sirevlcDescTipsHideTimer) {
                        clearTimeout(window.__sirevlcDescTipsHideTimer);
                        window.__sirevlcDescTipsHideTimer = null;
                    }
                    if (window.__sirevlcDescTipsPauseTimer) {
                        clearTimeout(window.__sirevlcDescTipsPauseTimer);
                    }
                    document.documentElement.classList.add('sirevlc-desc-tips-paused');
                    window.__sirevlcDescTipsPauseTimer = setTimeout(function(){
                        document.documentElement.classList.remove('sirevlc-desc-tips-paused');
                        window.__sirevlcDescTipsPauseTimer = null;
                    }, ms);
                } catch(e) {
                    try { console.error('pause_desc error', e); } catch(_) {}
                }
                break;
            }

            // Show desc tips now, then hide them after X ms
            // (inverse of pause_desc)
            case "hide_desc": {
                try {
                    var ms = Number(data.sire_menu_ms || data.ms || 0);
                    if (ms < 0) ms = 0;

                    // Cancel any pending pause timer (which would show again later)
                    if (window.__sirevlcDescTipsPauseTimer) {
                        clearTimeout(window.__sirevlcDescTipsPauseTimer);
                        window.__sirevlcDescTipsPauseTimer = null;
                    }
                    if (window.__sirevlcDescTipsHideTimer) {
                        clearTimeout(window.__sirevlcDescTipsHideTimer);
                    }

                    // Ensure visible now
                    document.documentElement.classList.remove('sirevlc-desc-tips-paused');

                    // Then hide later
                    if (ms === 0) {
                        document.documentElement.classList.add('sirevlc-desc-tips-paused');
                        window.__sirevlcDescTipsHideTimer = null;
                    } else {
                        window.__sirevlcDescTipsHideTimer = setTimeout(function(){
                            document.documentElement.classList.add('sirevlc-desc-tips-paused');
                            window.__sirevlcDescTipsHideTimer = null;
                        }, ms);
                    }
                } catch(e) {
                    try { console.error('hide_desc error', e); } catch(_) {}
                }
                break;
            }
            case "controlPressed": {
                /* log disabled */('[NUI] controlPressed', data.sire_menu_control);
                try {
                    var cRoot = document.getElementById('sirevlc-confirm');
                    if (cRoot && !cRoot.classList.contains('sirevlc-hidden')) {
                        if (data.sire_menu_control === 'ENTER') {
                            var y = document.getElementById('sirevlc-confirm-yes');
                            if (y) y.click();
                            break;
                        }
                        if (data.sire_menu_control === 'BACKSPACE') {
                            var n = document.getElementById('sirevlc-confirm-no');
                            if (n) n.click();
                            break;
                        }
                    }
                } catch (e) { try{ console.error('confirm window routing error', e); }catch(_e){} }
                var focused = MenuData.getFocused();
                if (!focused) break;
                switch (data.sire_menu_control) {
                    case "ENTER": {
    var menu = MenuData.opened[focused.namespace][focused.name];
    if (!menu) break;
    var pos  = MenuData.pos[focused.namespace][focused.name];
    var elem = menu.elements[pos];
    if (menu.elements.length > 0) {
 
        var elemWantsConfirm = false;
        var eText = null, eYes = 'Yes', eNo = 'No';

        if (elem) {
            if (elem.confirmNext === true) {
                elemWantsConfirm = true;
                if (elem.confirmNextText && (""+elem.confirmNextText).trim().length) {
                    eText = elem.confirmNextText;
                }
            } else if (elem.confirmNext !== false) {
                if (elem.confirmNextText && (""+elem.confirmNextText).trim().length) {
                    elemWantsConfirm = true;
                    eText = elem.confirmNextText;
                }
            }
            if (elem.confirmNextText_Yes) eYes = elem.confirmNextText_Yes;
            if (elem.confirmNextText_No)  eNo  = elem.confirmNextText_No;
        }

        if (elemWantsConfirm) {
            ConfirmUI.show({
                text: eText || 'Are you sure want to proceed ?',
                yes: eYes, no: eNo,
                onYes: function(){ MenuData.submit(focused.namespace, focused.name, elem); },
                onNo: function(){ /* stay in menu */ }
            });
        } else if (menu.confirmNextText && (""+menu.confirmNextText).trim().length) {
            var mYes = menu.confirmNextText_Yes || 'Yes';
            var mNo  = menu.confirmNextText_No  || 'No';
            ConfirmUI.show({
                text: menu.confirmNextText, yes: mYes, no: mNo,
                onYes: function(){ MenuData.submit(focused.namespace, focused.name, elem); },
                onNo: function(){ /* stay in menu */ }
            });
        } else {
            MenuData.submit(focused.namespace, focused.name, elem);
        }
    }
    break;
}
                    case "BACKSPACE": {
 
                        try {
                            var focused = MenuData.getFocused && MenuData.getFocused();
                            if (focused) {
                                var cur = (MenuData.opened && MenuData.opened[focused.namespace]) ? MenuData.opened[focused.namespace][focused.name] : null;
                                var confirmText = cur && (cur.confirmBackText || (cur._confirm && cur._confirm.text));
                                if (!confirmText && focused && focused.name === 'CUSTOMIZE_MAIN') { confirmText = 'Are you sure want to discard all your changes ?'; }
                                var yesLabel   = cur && (cur.confirmBackText_Yes || (cur._confirm && cur._confirm.yes) || 'Yes');
                                var noLabel    = cur && (cur.confirmBackText_No  || (cur._confirm && cur._confirm.no)  || 'No');
                                if (typeof confirmText === 'string' && confirmText.trim().length > 0) {
                                    ConfirmUI.show({
                                        text: confirmText, yes: yesLabel, no: noLabel,
                                        onYes: function(){
                                            MenuData.cancel(focused.namespace, focused.name, 'BACKSPACE');
                                            $.post("https://" + MenuData.ResourceName + "/closeui", JSON.stringify({}));
                                        },
                                        onNo: function(){ /* stay in menu */ }
                                    });
                                    break;
                                }
                            }
                        } catch (e) { console.error('BACKSPACE confirm guard error', e); }
 
                        try {
                            var menuConfirm = MenuData.opened[focused.namespace][focused.name];
                            var confirmText = menuConfirm && menuConfirm.confirmBackText;
                            if (confirmText) {
                                var confirmYes  = (menuConfirm.confirmBackText_Yes || 'Yes');
                                var confirmNo   = (menuConfirm.confirmBackText_No  || 'No');
                                ConfirmUI.show({
                                    text: confirmText,
                                    yes:  confirmYes,
                                    no:   confirmNo,
                                    onYes: function(){
                                        MenuData.cancel(focused.namespace, focused.name, 'BACKSPACE');
                                        $.post("https://" + MenuData.ResourceName + "/closeui", JSON.stringify({}));
                                    },
                                    onNo: function(){ /* stay in the menu */ }
                                });
                                break;
                            }
                        } catch (e) { console.error("confirmBack guard error", e); }
 
                        try {
                            var menuConfirm = MenuData.opened[focused.namespace][focused.name];
                            var confirmText = menuConfirm && menuConfirm.confirmBackText;
                            var confirmYes  = menuConfirm && (menuConfirm.confirmBackText_Yes || 'Yes');
                            var confirmNo   = menuConfirm && (menuConfirm.confirmBackText_No  || 'No');
                            if (confirmText) {
                                ConfirmUI.show({
                                    text: confirmText,
                                    yes: confirmYes,
                                    no:  confirmNo,
                                    onYes: function(){
                                        MenuData.cancel(focused.namespace, focused.name, 'BACKSPACE');
                                        $.post("https://" + MenuData.ResourceName + "/closeui", JSON.stringify({}));
                                    },
                                    onNo: function(){ /* no-op, just close modal */ }
                                });
                                break;
                            }
                        } catch (e) { console.error("confirmBackText check failed", e); }

                        if (lastmenu == null) lastmenu = "";
                        if (lastmenu !== "undefined" && lastmenu !== "") {
                            var menu2 = (MenuData.opened[focused.namespace] && MenuData.opened[focused.namespace][focused.name]) ? MenuData.opened[focused.namespace][focused.name] : null;
                            if (menu2) {
                                var pos2 = MenuData.pos[focused.namespace][focused.name];
                                var elem2 = menu2.elements[pos2];
                                MenuData.submit(focused.namespace, focused.name, "backup");
                            }
                        } else {
                            MenuData.cancel(focused.namespace, focused.name, 'BACKSPACE');
                            $.post("https://" + MenuData.ResourceName + "/closeui", JSON.stringify({}));
                        }
                        break;
                    }

                    // ESC is routed separately so Lua can know why cancel fired.
                    case "ESCAPE": {
                        try {
                            // If a confirm-back text exists, reuse the same confirm flow.
                            var curMenu = MenuData.opened[focused.namespace] && MenuData.opened[focused.namespace][focused.name];
                            var cText = curMenu && curMenu.confirmBackText;
                            if (cText && (""+cText).trim().length) {
                                ConfirmUI.show({
                                    text: cText,
                                    yes: (curMenu.confirmBackText_Yes || 'Yes'),
                                    no:  (curMenu.confirmBackText_No  || 'No'),
                                    onYes: function(){
                                        MenuData.cancel(focused.namespace, focused.name, 'ESCAPE');
                                        $.post("https://" + MenuData.ResourceName + "/closeui", JSON.stringify({}));
                                    },
                                    onNo: function(){}
                                });
                                break;
                            }
                        } catch(_e) {}

                        MenuData.cancel(focused.namespace, focused.name, 'ESCAPE');
                        $.post("https://" + MenuData.ResourceName + "/closeui", JSON.stringify({}));
                        break;
                    }
                    case "TOP": {
                        if (!canNavigateNow(focused.namespace, focused.name)) break;
                        var menuT = MenuData.opened[focused.namespace][focused.name];
                        if (!menuT) break;
                        var posT = MenuData.pos[focused.namespace][focused.name];
                        if (posT > 0) MenuData.pos[focused.namespace][focused.name]--; else MenuData.pos[focused.namespace][focused.name] = menuT.elements.length - 1;
                        var elemT = menuT.elements[MenuData.pos[focused.namespace][focused.name]];
                        for (var iT = 0; iT < menuT.elements.length; iT++) {
                            menuT.elements[iT].selected = (iT === MenuData.pos[focused.namespace][focused.name]);
                        }
                        MenuData.change(focused.namespace, focused.name, elemT);
                        noteNav(focused.namespace, focused.name);
                        MenuData.render(); 
                        $.post("https://" + MenuData.ResourceName + "/playsound");
                        var selT = document.querySelector('#menu_' + focused.namespace + '_' + focused.name + ' .menu-item.selected');
                        if (selT) selT.scrollIntoView({ block: 'nearest' });
                        break;
                    }
                    case "DOWN": {
                        if (!canNavigateNow(focused.namespace, focused.name)) break;
                        var menuD = MenuData.opened[focused.namespace][focused.name];
                        if (!menuD) break;
                        var posD = MenuData.pos[focused.namespace][focused.name];
                        var length = menuD.elements.length;
                        if (posD < length - 1) MenuData.pos[focused.namespace][focused.name]++; else MenuData.pos[focused.namespace][focused.name] = 0;
                        var elemD = menuD.elements[MenuData.pos[focused.namespace][focused.name]];
                        for (var iD = 0; iD < menuD.elements.length; iD++) {
                            menuD.elements[iD].selected = (iD === MenuData.pos[focused.namespace][focused.name]);
                        }
                        MenuData.change(focused.namespace, focused.name, elemD);
                        noteNav(focused.namespace, focused.name);
                        MenuData.render(); 
                        $.post("https://" + MenuData.ResourceName + "/playsound");
                        var selD = document.querySelector('#menu_' + focused.namespace + '_' + focused.name + ' .menu-item.selected');
                        if (selD) selD.scrollIntoView({ block: 'nearest' });
                        break;
                    }
                    case "LEFT": {
                        var mL = MenuData.opened[focused.namespace][focused.name];
                        if (!mL) break;
                        var pL = MenuData.pos[focused.namespace][focused.name];
                        var eL = mL.elements[pL];
                        if (eL.type === 'slider' || eL.type === 'imgslider') {
                            var min = (typeof eL.min === 'undefined') ? 0 : eL.min;
                            if (eL.value > min) {
                                if (typeof eL.hop !== "undefined") {
                                    if (Number.isInteger(eL.hop)) {
                                        eL.value = eL.value - eL.hop;
                                    } else {
                                        eL.value = (function(){var h=Number(eL.hop);var p=(String(h).split('.')[1]||'').length;var nv=Number(eL.value)-h;return nv.toFixed(Math.max(0,p));})();
                                    }
                                    eL.value = Number(eL.value);
                                    if (eL.value < min) eL.value = min;
                                } else {
                                    eL.value--;
                                }
                                MenuData.change(focused.namespace, focused.name, eL);
                                if (eL.type === 'slider' || eL.type === 'imgslider') {
                                    try {
                                        $.post("https://" + MenuData.ResourceName + "/playsound", JSON.stringify({ which: "slider_step" }));
                                    } catch(_e) {}
                                }
                            }
                            MenuData.render(); 
                            var selL = document.querySelector('#menu_' + focused.namespace + '_' + focused.name + ' .menu-item.selected');
                            if (selL) selL.scrollIntoView({ block: 'nearest' });
                        }
                        break;
                    }
                    case "RIGHT": {
                        var mR = MenuData.opened[focused.namespace][focused.name];
                        if (!mR) break;
                        var pR = MenuData.pos[focused.namespace][focused.name];
                        var eR = mR.elements[pR];
                        if (eR.type === 'slider' || eR.type === 'imgslider') {
                            if (typeof eR.options !== "undefined" && eR.value < eR.options.length - 1) {
                                eR.value++;
                                MenuData.change(focused.namespace, focused.name, eR);
                            }
                            if (typeof eR.max !== "undefined" && eR.value < eR.max) {
                                if (typeof eR.hop !== "undefined") {
                                    var mn = (typeof eR.min === "undefined") ? 0 : eR.min;
                                    if (mn > 0 && mn === eR.value) eR.value = eR.min;
                                    if (Number.isInteger(eR.hop)) {
                                        eR.value = eR.value + eR.hop;
                                    } else {
                                        eR.value = (function(){var h=Number(eR.hop);var p=(String(h).split('.')[1]||'').length;var nv=Number(eR.value)+h;return nv.toFixed(Math.max(0,p));})();
                                    }
                                    eR.value = Number(eR.value);
                                    if (eR.value > eR.max) eR.value = eR.max;
                                } else {
                                    eR.value++;
                                }
                                MenuData.change(focused.namespace, focused.name, eR);
                                if (eR.type === 'slider' || eR.type === 'imgslider') {
                                    try {
                                        $.post("https://" + MenuData.ResourceName + "/playsound", JSON.stringify({ which: "slider_step" }));
                                    } catch(_e) {}
                                }
                            }
                            MenuData.render(); 
                            var selR = document.querySelector('#menu_' + focused.namespace + '_' + focused.name + ' .menu-item.selected');
                            if (selR) selR.scrollIntoView({ block: 'nearest' });
                        }
                        break;
                    }
                }
                break;
            }
        }
    };
 
    window.onload = function () {
 
var ConfirmUI = (function(){
  var root = null, txt = null, yesBtn = null, noBtn = null;
  var _onYes = null, _onNo = null;
  function ensure(){
    if (root) return;
    root = document.getElementById('sirevlc-confirm');
    if (!root) return;
    txt = document.getElementById('sirevlc-confirm-text');
    yesBtn = document.getElementById('sirevlc-confirm-yes');
    noBtn  = document.getElementById('sirevlc-confirm-no');
    yesBtn.addEventListener('click', function(){
      hide();
      if (_onYes) try{ _onYes(); }catch(e){ console.error(e); }
    });
    noBtn.addEventListener('click', function(){
      hide();
      if (_onNo) try{ _onNo(); }catch(e){ console.error(e); }
    });
  }
  function show(opts){
    ensure();
    if (!root) return;
    _onYes = opts && opts.onYes || null;
    _onNo  = opts && opts.onNo  || null;
    if (txt && opts && opts.text) txt.textContent = opts.text;
    if (yesBtn) yesBtn.textContent = (opts && opts.yes) ? opts.yes : 'Yes';
    if (noBtn)  noBtn.textContent  = (opts && opts.no)  ? opts.no  : 'No';
    root.classList.remove('sirevlc-hidden');
  }
  function hide(){
    if (!root) return;
    root.classList.add('sirevlc-hidden');
  }
  function isOpen(){ return root && !root.classList.contains('sirevlc-hidden'); }
  // keyboard shortcuts when modal open
  window.addEventListener('keydown', function(e){
    if (!isOpen()) return;
    if (e.key === 'Enter'){ e.preventDefault(); try{ yesBtn.click(); }catch(_){ } }
    if (e.key === 'Backspace' || e.key === 'Escape'){ e.preventDefault(); try{ noBtn.click(); }catch(_){ } }
  }, true);
  return { show: show, hide: hide, isOpen: isOpen };
})();
 
(function(){
  try {
    if (typeof ConfirmUI === 'undefined' || !ConfirmUI || !ConfirmUI.show) return;
    if (!window.ConfirmUI) window.ConfirmUI = ConfirmUI;

    var _sirevlcOldConfirmShow = ConfirmUI.show;
    ConfirmUI.show = function(opts){
      try {
        var rn = (window.MenuData && MenuData.ResourceName) ? MenuData.ResourceName : 'sire_menu';
        $.post('https://' + rn + '/playsound', JSON.stringify({ which: 'confirm_open' }));
      } catch(_e){}
      return _sirevlcOldConfirmShow(opts);
    };

    window.addEventListener('load', function(){
      try{
        var rn = (window.MenuData && MenuData.ResourceName) ? MenuData.ResourceName : 'sire_menu';
        var yesBtn = document.getElementById('sirevlc-confirm-yes');
        var noBtn  = document.getElementById('sirevlc-confirm-no');
        if (yesBtn) yesBtn.addEventListener('click', function(){
          try { $.post('https://' + rn + '/playsound', JSON.stringify({ which: 'confirm_close' })); } catch(_e){}
        }, true);
        if (noBtn) noBtn.addEventListener('click', function(){
          try { $.post('https://' + rn + '/playsound', JSON.stringify({ which: 'confirm_close' })); } catch(_e){}
        }, true);
      } catch(_e){}
    });
  } catch(_e){ console.error('[ConfirmUI hook] error', _e); }
})();


(function(){
  try {
    if (typeof ConfirmUI === 'undefined' || !ConfirmUI || !ConfirmUI.show) return;
 
    if (!window.ConfirmUI) window.ConfirmUI = ConfirmUI;
 
    var _sirevlcOldConfirmShow = ConfirmUI.show;
    ConfirmUI.show = function(opts){
      try {
        var rn = (window.MenuData && MenuData.ResourceName) ? MenuData.ResourceName : 'sire_menu';
        $.post('https://' + rn + '/playsound', JSON.stringify({ which: 'confirm_open' }));
      } catch(_e){}
      return _sirevlcOldConfirmShow(opts);
    };
 
    window.addEventListener('load', function(){
      try{
        var rn = (window.MenuData && MenuData.ResourceName) ? MenuData.ResourceName : 'sire_menu';
        var yesBtn = document.getElementById('sirevlc-confirm-yes');
        var noBtn  = document.getElementById('sirevlc-confirm-no');
        if (yesBtn) yesBtn.addEventListener('click', function(){
          try { $.post('https://' + rn + '/playsound', JSON.stringify({ which: 'confirm_close' })); } catch(_e){}
        }, true);
        if (noBtn) noBtn.addEventListener('click', function(){
          try { $.post('https://' + rn + '/playsound', JSON.stringify({ which: 'confirm_close' })); } catch(_e){}
        }, true);
      } catch(_e){}
    });
  } catch(_e){ console.error('[ConfirmUI hook] error', _e); }
})();

window.addEventListener("message", function (event) {
            onData(event.data);
        });
 
};
})();
 
(function(){
  try {
    function updateFooterState() {
      var footer = document.querySelector('.selected .desc-footer');
      if (!footer) return;
      var rightTextEl = footer.querySelector('.desc-right .desc-right-text');
      var hasRightText = !!(rightTextEl && (rightTextEl.textContent||'').trim().length);
      footer.classList.toggle('has-right-text', hasRightText);
      if (hasRightText) {
        var imgs = footer.querySelectorAll('img, .sirevlc-img-rightonly, .desc-thumb');
        var removed = 0;
        imgs.forEach(function(n){ if (n.parentNode) { n.parentNode.removeChild(n); removed++; } });
        if (removed) /* log disabled */('[NUI][pruneSafe] removed', removed, 'image node(s)');
      }
    }
    var mo = new MutationObserver(function(){ try { updateFooterState(); } catch(e) {} });
    mo.observe(document.documentElement, { childList: true, subtree: true });
    var tries = 30, iv = setInterval(function(){
      updateFooterState();
      if (--tries <= 0) clearInterval(iv);
    }, 100);
    window.__updateFooterState = updateFooterState;
    /* log disabled */('[NUI][pruneSafe] observer active');
  } catch(e) {
    console.warn('[NUI][pruneSafe] init error', e);
  }
})();
 
(function(){
  try {
    if (window.__FooterDebugInterval) { clearInterval(window.__FooterDebugInterval); }
    window.__FooterDebugInterval = setInterval(function(){
      var footer = document.querySelector('.selected .desc-footer');
      if (!footer) return;
      var hasCenter = !!footer.querySelector('.desc-center .desc-center-text, .desc_center .desc_center_text');
      var hasLeft   = !!footer.querySelector('.desc-left .desc-left-text');
      var hasRight  = !!footer.querySelector('.desc-right .desc-right-text');
      var hasSub    = !!footer.querySelector('.desc-sub .desc-sub-text, .desc_sub .desc_sub_text');
      /* log disabled */('[NUI][footer] center=%s left=%s right=%s sub=%s', hasCenter, hasLeft, hasRight, hasSub);
    }, 1500);
  } catch(e) { console.warn('[NUI][footer] debug init error', e); }
})();
 
(function(){
  function ensureFooterViewportAndSlider(footer){
    try {
 
      var viewport = footer.querySelector('.desc-footer-viewport');
      if (!viewport) {
        viewport = document.createElement('div');
        viewport.className = 'desc-footer-viewport';
 
        var children = Array.from(footer.childNodes);
        children.forEach(function(n){
          if (!(n.nodeType === 1 && n.classList && n.classList.contains('desc-footer-slider'))) {
            viewport.appendChild(n);
          }
        });
        footer.appendChild(viewport);
      }
 
      var sliderWrap = footer.querySelector('.desc-footer-slider');
      if (!sliderWrap) {
        sliderWrap = document.createElement('div');
        sliderWrap.className = 'desc-footer-slider';
        var input = document.createElement('input');
        input.type = 'range'; input.min = '0'; input.value = '0'; input.step = '1';
        sliderWrap.appendChild(input);
        footer.appendChild(sliderWrap);
      }
      var range = sliderWrap.querySelector('input[type="range"]');
 
      var _ = viewport.offsetHeight;
      var overflow = viewport.scrollHeight - viewport.clientHeight;

      if (overflow > 1) {
        sliderWrap.style.display = '';
        range.max = String(overflow);
 
        range.oninput = function(){
          var v = parseInt(range.value||'0', 10);
          viewport.scrollTop = v;
        };
 
        viewport.onwheel = function(e){
          e.preventDefault();
          var step = Math.max(1, Math.floor(viewport.clientHeight * 0.25));
          var v = Math.min(overflow, Math.max(0, (parseInt(range.value||'0',10) + Math.sign(e.deltaY)*step)));
          range.value = String(v);
          viewport.scrollTop = v;
        };
      } else {
 
        viewport.scrollTop = 0;
        sliderWrap.style.display = 'none';
      }
    } catch(e){
      console.warn('[NUI][footer-scroll] error', e);
    }
  }

  function updateAllFootersScroll(){
    var footers = document.querySelectorAll('.desc-footer');
    if (!footers || !footers.length) return;
    footers.forEach(ensureFooterViewportAndSlider);
  }
 
  try {
    var __oldUpdateFooterState = window.__updateFooterState;
    window.__updateFooterState = function(){
      try { if (typeof __oldUpdateFooterState === 'function') __oldUpdateFooterState(); } catch(e){}
      updateAllFootersScroll();
    };
  } catch(e){}
 
  try {
    var mo = new MutationObserver(function(){ updateAllFootersScroll(); });
    mo.observe(document.body, { childList: true, subtree: true });
  } catch(e){}

  // Kick a few times after load + periodic fallback
  setTimeout(updateAllFootersScroll, 100);
  setTimeout(updateAllFootersScroll, 400);
  setTimeout(updateAllFootersScroll, 1200);
  setInterval(updateAllFootersScroll, 1500);
})();
 
(function() {
  function clamp(v, min, max) { return Math.max(min, Math.min(max, v)); }
  function postChange(name, value) {
    try {
      fetch('https://' + (window.sire_menu_resourcename || 'sire_menu') + '/menu_change', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify({ name: name, value: value })
      });
    } catch (e) { console.error(e); }
  }
  function getState(node) {
    const itemNode = node.closest('.menu-item');
    let min=Number(itemNode?.getAttribute('data-min') ?? 0);
    let max=Number(itemNode?.getAttribute('data-max') ?? 100);
    let step=Number(itemNode?.getAttribute('data-step') ?? itemNode?.getAttribute('data-hop') ?? 1);
    let value=itemNode?.getAttribute('data-value');
    return { itemNode, min, max, step, value: value!=null?Number(value):min };
  }
  function step(itemNode, v, dir, min, max, step) {
    const next = clamp(v + dir * step, min, max);
    if (itemNode) itemNode.setAttribute('data-value', String(next));
    return next;
  }
  

function handleBtn(btn, ev) {
    const dir = Number(btn.getAttribute('data-dir')) || 0;
    const group = btn.closest('.imgslider-value-group, .slider-value-group');
    if (!group) return;

    const s = getState(group);
    const next = step(s.itemNode, s.value, dir, s.min, s.max, s.step);
    const label = group.querySelector('.imgslider-label, #slider-label');
    if (label) label.textContent = String(next);

    try {
 
      const focused = (MenuData && MenuData.getFocused) ? MenuData.getFocused() : null;
      const ns = focused && (focused._namespace || focused.namespace);
      const nm = focused && (focused._name || focused.name);
      const idx = focused && typeof focused.currentElement !== 'undefined' ? Number(focused.currentElement) : -1;

      if (ns && nm && idx >= 0 && MenuData.opened && MenuData.opened[ns] && MenuData.opened[ns][nm] && MenuData.opened[ns][nm].elements && MenuData.opened[ns][nm].elements[idx]) {
        const e = MenuData.opened[ns][nm].elements[idx];
        e.value = next; // update value in model
 
        if (MenuData.change) MenuData.change(ns, nm, e);
        if (e && e.type === 'slider') {
          try {
            var rn = (window.MenuData && MenuData.ResourceName) ? MenuData.ResourceName : 'sire_menu';
            $.post('https://' + rn + '/playsound', JSON.stringify({ which: 'slider_step' }));
          } catch(_e){}
        }
      }
    } catch (err) {
      console.error('persist/change error', err);
    }

    if (ev) { ev.preventDefault(); ev.stopPropagation(); if (ev.stopImmediatePropagation) ev.stopImmediatePropagation(); }
    return false;
  }
 
document.addEventListener('pointerdown', function(ev){
  const btn = ev.target.closest('.slider-step-btn');
  if (!btn) return;
  handleBtn(btn, ev);
}, true);
document.addEventListener('pointerdown', function(ev){
  const btn = ev.target.closest('.slider-step-btn');
  if (!btn) return;
  handleBtn(btn, ev);
}, false);
// Cancel click on these buttons to avoid double-hop
document.addEventListener('click', function(ev){
  if (!ev.target.closest('.slider-step-btn')) return;
  ev.preventDefault(); ev.stopPropagation(); if (ev.stopImmediatePropagation) ev.stopImmediatePropagation();
}, true);
})();
 
(function(){

  function setGradOnItem(ns, name, idx, gradient){
    try{
      var menu  = document.getElementById('menu_' + ns + '_' + name);
      var nodes = menu ? menu.querySelectorAll('.menu-item') : null;
      var item  = nodes && nodes[idx];

      if (item){
        var track =
          item.querySelector('.imgslider .track, .imgslider .imgslider-track, .imgslider-track, .imgslider .bar, .imgslider .bg') ||
          item.querySelector('.imgslider');

        if (track){
          try { track.style.backgroundImage = gradient; } catch(e) {}
          try { track.style.background      = gradient; } catch(e) {}
        }
      }
 
      var mref = window.MenuData && MenuData.opened && MenuData.opened[ns] && MenuData.opened[ns][name];
      if (mref && mref.elements && mref.elements[idx]){
        mref.elements[idx].gradient = gradient;
      }
    }catch(e){}
  }

  function applyGradientsFromMessage(data){
    try{
      if (!data || !data.items || !Array.isArray(data.items)) return;

      var ns   = data._namespace || data.namespace;
      var name = data._name      || data.name;
 
      var menuId = (ns && name) ? ('menu_' + ns + '_' + name) : null;
      var menu   = menuId ? document.getElementById(menuId) : null;
 
      if ((!menu || !ns || !name) && window.MenuData && typeof MenuData.getFocused === 'function') {
        try{
          var foc = MenuData.getFocused();
          if (foc) {
            ns   = foc._namespace || foc.namespace;
            name = foc._name      || foc.name;
            menuId = 'menu_' + ns + '_' + name;
            menu   = document.getElementById(menuId);
          }
        }catch(_e){}
      }

      if (!ns || !name || !menu) return;

      data.items.forEach(function(it){
        if (!it) return;
        var raw = (typeof it.index === 'number') ? it.index : parseInt(it.index, 10);
        var g   = it.gradient;

        if (isNaN(raw) || !g) return;
 
        var idx = (raw >= 1) ? (raw - 1) : 0;

        setGradOnItem(ns, name, idx, g);
      });
    }catch(e){}
  }
 
  window.addEventListener('message', function(event){
    var data = event.data;
    if (!data || data.action !== 'menu_set_gradients') return;
    applyGradientsFromMessage(data);
  });

})();
 
(function(){
  function onSliderPointer(ev){
    var item = ev.target && ev.target.closest && ev.target.closest('.menu-item.slider');
    if (!item) return;
    ev.preventDefault(); ev.stopPropagation(); if (ev.stopImmediatePropagation) ev.stopImmediatePropagation();
    try {
      var rect = item.getBoundingClientRect();
      var midX = rect.left + rect.width / 2;
      if (ev.clientX < midX) simulateControl('LEFT'); else simulateControl('RIGHT');
    } catch(_){ }
  }
  document.addEventListener('mousedown', onSliderPointer, true);
  document.addEventListener('click', onSliderPointer, true);
})();
 
(function(){
  var lastWheelNotify = 0;
  function notifyWheel(ms){
    var now = Date.now();
    if (now - lastWheelNotify < 50) return; // tiny throttle
    lastWheelNotify = now;

    var res = (window.MenuData && MenuData.ResourceName) ? MenuData.ResourceName : 'sire_menu';
    var payload = JSON.stringify({ ms: ms || 200 });

    if (window.fetch) {
      try {
        fetch('https://' + res + '/menu_wheel', { method: 'POST', headers: { 'Content-Type': 'application/json; charset=UTF-8' }, body: payload });
        return;
      } catch (e) {}
    }
    try { $.post('http://' + res + '/menu_wheel', payload); } catch (e2) {}
  }

  document.addEventListener('wheel', function(e){
    var list = e.target && (e.target.closest ? e.target.closest('.menu-items') : null);
    if (!list) return;

    var max = list.scrollHeight - list.clientHeight;
    if (max <= 0) return;

    var dy = e.deltaY || 0;
    if ((dy < 0 && list.scrollTop > 0) || (dy > 0 && list.scrollTop < max)) {
      notifyWheel(220);
    }
  }, { passive: true });
})();
