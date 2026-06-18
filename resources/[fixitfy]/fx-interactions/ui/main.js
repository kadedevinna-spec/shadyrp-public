$(document).ready(function () {

    const SHOW_ICON_IN_SLOT = true;

    let menuVisible = false;

    const getSlot = (el) => String($(el).attr("data-id") || $(el).data("id") || "");

    const setSlotEmpty = ($box) => {
        const slot = getSlot($box);
        $box
            .removeClass("filled")
            .removeAttr("style")
            .data("fav", null)
            .html(`<span class="fav-num">${slot}</span>`);
    };

    const setSlotFilled = ($box, fav) => {
        const slot = getSlot($box);
        $box.addClass("filled").data("fav", fav || null);
        $box.css("color", "red");

        if (SHOW_ICON_IN_SLOT && fav?.icon) {
            $box.html(`
                <span class="fav-num">${slot}</span>
                <iconify-icon icon="${fav.icon}" class="fav-slot-icon"></iconify-icon>
            `);
        } else {
            $box.html(`<span class="fav-num">${slot}</span>`);
        }
    };


    const bindFavoritesHoverDescription = () => {
        $(document)
            .off("mouseenter.fav mouseleave.fav click.fav")
            .on("mouseenter.fav", ".favorites-selectbox", function () {
                if ($(".animation-box").filter((_, el) => $(el).data("dragging")).length > 0) return;

                const $box = $(this);
                const slot = getSlot($box);
                const fav = $box.data("fav");
                const label = fav?.label || `Slot ${slot}`;
                const icon = fav?.icon ? `<iconify-icon icon="${fav.icon}" class="desc-icon"></iconify-icon>` : "";

                $(".favorites-selectbox").each(function () {
                    const $other = $(this);
                    if ($other.data("prev-html")) {
                        $other.html($other.data("prev-html"));
                        $other.removeData("prev-html");
                    }
                });

                const off = $box.offset();
                $(".description-box")
                    .finish()
                    .html(`${icon} ${label}`)
                    .css({ top: off.top + "px", left: off.left + $box.outerWidth() + 10 + "px" })
                    .fadeIn(100);

                if ($box.hasClass("filled")) {
                    $box.data("prev-html", $box.html());
                    $box.html(`<img class="delete-favorite" src="/ui/assets/img/cancel-red.png" style="opacity:.85" alt="Delete">`);
                }
            })
            .on("mouseleave.fav", ".favorites-selectbox", function () {
                const $box = $(this);
                $(".description-box").finish().fadeOut(100);
                if ($box.hasClass("filled")) {
                    const prev = $box.data("prev-html");
                    if (prev) {
                        $box.html(prev);
                        $box.removeData("prev-html");
                    }
                }
            })
            .on("click.fav", ".favorites-selectbox.filled, .favorites-selectbox .delete-favorite", function (e) {
                e.stopPropagation();
                const $box = $(this).closest(".favorites-selectbox");
                const slot = getSlot($box);
                setSlotEmpty($box);
                $.post("https://fx-interactions/removeFavorite", JSON.stringify({ slot }));
                $(".description-box").finish().fadeOut(80);
                $box.removeData("prev-html");
            });
    };

    window.addEventListener("message", (event) => {
        const data = event.data;
        if (!data?.action) return;

        if (data.action === "openMenu") {
            menuVisible = true;
            window.currentProp = data.prop || 0;
            window.currentPropEntity = data.propEntity || 0; // ✅ NEW            
            window.menuIsBath = !!data.isBath;

            $(".animation-container").empty();
            (data.animations || []).forEach((anim, index) => {
                $(".animation-container").append(`
                    <div class="animation-box"
                        data-index="${index + 1}"       
                        data-name="${anim.name}"
                        data-label="${anim.label}"
                        data-icon="${anim.icon || ''}"
                        data-dict="${anim.dict || ''}"
                        data-effect="${anim.effect || ''}">  
                        <span>${anim.label}</span>
                        ${anim.icon ? `<iconify-icon icon="${anim.icon}" class="anim-icon"></iconify-icon>` : ""}
                    </div>
                `);
            });
            
        
            $(".menu").fadeIn(160, function () {
                $(".favorites-selectbox").each(function (index) {
                    $(this).attr("data-id", index + 1);
                });
        
                for (let i = 1; i <= 7; i++) {
                    const $box = $(`.favorites-selectbox[data-id='${i}']`);
                    if (!$box.length) continue;
        
                    const fav = (data.favorites || {})[i] || null;
                    if (fav) setSlotFilled($box, fav);
                    else setSlotEmpty($box);
                }
        
                initDraggable();
                initDroppable();
                bindFavoritesHoverDescription();
            });
        }
        
        
        if (data.action === "chairHighlight") {
            const $marker = $(".chair-select");
            if (!$marker.data("lastX")) $marker.data("lastX", 0);
            if (!$marker.data("lastY")) $marker.data("lastY", 0);

            const threshold = 0.01;
            if (data.show) {
                const x = Number(data.x || 0.5);
                const y = Number(data.y || 0.5);
                const lastX = $marker.data("lastX");
                const lastY = $marker.data("lastY");
                const diffX = Math.abs(x - lastX);
                const diffY = Math.abs(y - lastY);
                if (diffX > threshold || diffY > threshold) {
                    $marker.data("lastX", x);
                    $marker.data("lastY", y);
                    const screenX = x * window.innerWidth;
                    const screenY = y * window.innerHeight;
                    $marker.css({
                        display: "block",
                        position: "absolute",
                        top: `${screenY}px`,
                        left: `${screenX}px`,
                        pointerEvents: "none",
                        zIndex: 9999,
                    });
                }
            } else {
                $marker.removeData("lastX lastY");
                $marker.stop(true, true).fadeOut(150, function () {
                    $(this).hide();
                });
            }
        }
    });


    $(document).on("keydown", (e) => {
        if ((e.key === "Escape" || e.keyCode === 27) && menuVisible) {
            $.post("https://fx-interactions/closeMenu", JSON.stringify({}));
            menuVisible = false;
            $(".menu").fadeOut(160);
            $(".description-box").hide();
            return;
        }

        if (!menuVisible) return;

        const keyMap = {
            49: 1, 50: 2, 51: 3, 52: 4, 53: 5, 54: 6, 55: 7,
        };

        const slotNum = keyMap[e.keyCode];
        if (!slotNum) return;

        const $slot = $(`.favorites-selectbox[data-id='${slotNum}']`);
        const fav = $slot.data("fav");
        if (!fav) return;

        const anim = {
            name: fav.name,
            label: fav.label,
            prop: window.currentProp || 0,
            isBath: window.menuIsBath === true,
            propEntity: window.currentPropEntity || 0,
            
          };
          

        $.post("https://fx-interactions/selectAnimation", JSON.stringify(anim));
        menuVisible = false;
        $(".menu").fadeOut(160);
        $(".description-box").hide();
    });


    $(document).on("click", ".animation-box", function () {
        if ($(this).data("dragging")) return;
    
        const anim = {
            index: $(this).data("index"),
            name: $(this).data("name"),
            label: $(this).data("label"),
            prop: window.currentProp || 0,
            propEntity: window.currentPropEntity || 0,
            isBath: window.menuIsBath === true,
            dict: $(this).data("dict") || null,
            effect: $(this).data("effect") || null
        };
          
          
    
        $.post("https://fx-interactions/selectAnimation", JSON.stringify(anim));
        menuVisible = false;
        $(".menu").fadeOut(160);
        $(".description-box").hide();
    });
    


    function initDraggable() {
        try { $(".animation-box").draggable("destroy"); } catch {}
        $(".animation-box").draggable({
            helper: function () {
                const $clone = $(this).clone(true);
                const originalStyles = window.getComputedStyle(this);
                $clone.find("span").hide();
                $clone.find(".anim-icon").addClass("dragging");
                $clone
                    .addClass("animation-box")
                    .css({
                        position: "absolute",
                        width: "40px",
                        height: "20px",
                        color: "black",
                        background: "url(/ui/assets/img/button-black.png) center / 100% 100% no-repeat",
                        "background-size": originalStyles["background-size"],
                        "background-repeat": originalStyles["background-repeat"],
                        zIndex: 9999,
                        cursor: "grabbing",
                        filter: "drop-shadow(0px 0px 20px rgba(255,255,255,0.9))",
                    });
                return $clone;
            },
            appendTo: "body",
            revert: "invalid",
            scroll: false,
            zIndex: 9999,
            cursorAt: { top: 10, left: 25 },
            start: function () {
                $(this).data("dragging", true);
                $(this).css("opacity", "0.6");
                $(this).find(".anim-icon").addClass("dragging");
            },
            stop: function () {
                $(this).css("opacity", "1");
                $(this).find(".anim-icon").removeClass("dragging");
                setTimeout(() => $(this).data("dragging", false), 50);
            }
        });
    }

    function initDroppable() {
        try { $(".favorites-selectbox").droppable("destroy"); } catch {}
        $(".favorites-selectbox").each(function (index) {
            if (!$(this).attr("data-id")) {
                $(this).attr("data-id", index + 1);
            }
        });

        $(".favorites-selectbox").droppable({
            accept: ".animation-box",
            hoverClass: "drop-hover",
            tolerance: "pointer",

            over: function () {
                $(this).css({
                    transform: "scale(0.95)",
                    color: "black",
                    background: "url(/ui/assets/img/button-white.png) center / 100% 100% no-repeat"
                });
            },
            out: function () {
                $(this).css({ transform: "", color: "", background: "" });
            },
            drop: function (evt, ui) {
                const $box = $(this);
                const slot = $box.data("id");
            
                const fav = {
                    name: ui.draggable.data("name") || ui.draggable.find("span").text(),
                    label: ui.draggable.data("label") || ui.draggable.find("span").text(),
                    icon: ui.draggable.data("icon") || ui.draggable.find("iconify-icon").attr("icon")
                };
            
                $box.data("fav", fav);
            
                setSlotFilled($box, fav);
            
                $(".description-box").stop(true, true).fadeOut(80);
                $box.trigger("mouseleave");
                $(".favorites-selectbox").css({ transform: "", color: "", background: "" });
            
                $.post("https://fx-interactions/saveFavorite", JSON.stringify({ slot, scenario: fav }));
            
                ui.draggable.css({
                    opacity: "1", transform: "scale(1)",
                    position: "", top: "", left: "", zIndex: ""
                });
            }
            
        });
    }

}); 
