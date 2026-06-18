

///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                   //
//                                       MURPHY'S BARBER                                             //
//                                                                                                   //
//                        2025 - Murphy / Webba Creative Technologies                                //
//                                                                                                   //
//                         This Script is working with all UI folder                                 //
//                   to show and hide datas for Barber creation / modification                       //
//                                                                                                   //
//                                   All Right Reserved - ©                                          //
//                                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////


/**
 * Table of Contents
 *
 * I. JSON EXAMPLES
 *     A. Project Overview
 *     B. Objectives
 *     C. Technologies Used
 *
 * II. GLOBAL ELEMENTS
 *     A. Global Variables
 *     B. Outfit Menu (Modification / Creation)
 *     C. Outfit List Menu (All My Outfits)
 *     D. My Outfit Menu (Actual Outfit Variation / Get Naked)
 *     E. Contextual Menu (For Outfit Modification / Creation - Tint, Variations...)
 *
 * III. ALL FUNCTIONS
 *     A. Load Categories
 *     B. Load Items
 *     C. Load Contextual Datas
 *     D. Load Camera Menu
 *     E. Load Outfit List
 *     F. Load My Outfit Items
 *
 * IV. DOM
 *     A. Event Listeners for interactions
 *     B. Event Listeners for Camera Menu
 *     C. Event Listeners for Outfit Menu
 *     D. Event Listeners for Outfit List Menu
 *     E. Event Listeners for My Outfit Menu
 *     F. Event Listeners for Contextual Menu
 *     G. Event Listeners for My Outfit Items
 *
 * V. Messages
 *     A. Event Price Outfit
 *     B. Event Listener for the NUI Messages
 *     C. Escape Key
 */




///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                       JSON EXAMPLES                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////


// //JSON Example for categories
// const categories = [

//     {
//         "id": 1,
//         "name": "Shirts",
//         "image": "./img/categories/barber.png"
//     },
//     {
//         "id": 2,
//         "name": "Pants",
//         "image": "./img/categories/lifestyle.png"
//     },
//     {
//         "id": 3,
//         "name": "Shoes",
//         "image": "./img/categories/makeup.png"
//     }
// ]

// JSON Example for items

// const items = [
//     {
//         "id": 1,
//         "name": "Shirt Style",
//         "category": 1,
//         "totalAmount": 255,
//         "selectorType": "slider",

//         "value": 50
//     },
//     {
//         "id": 2,
//         "name": "Pants Style",
//         "category": 1,
//         "totalAmount": 50,
//         "selectorType": "slider",

//         "value": 10
//     },
//     {
//         "id": 3,
//         "name": "Shirt Style",
//         "category": 1,
//         "totalAmount": 255,
//         "selectorType": "slider",

//         "value": 50
//     },
//     {
//         "id": 4,
//         "name": "Pants Style",
//         "category": 1,
//         "totalAmount": 50,
//         "selectorType": "slider",

//         "value": 10
//     },
//     {
//         "id": 5,
//         "name": "Pants Style",
//         "category": 1,
//         "totalAmount": 50,
//         "selectorType": "slider",

//         "value": 10
//     },
//     {
//         "id": 6,
//         "name": "Pants Style of the sky",
//         "category": 1,
//         "totalAmount": 50,
//         "selectorType": "slider",

//         "value": 10
//     },
//     {
//         "id": 7,
//         "name": "Pants Style",
//         "category": 1,
//         "totalAmount": 50,
//         "selectorType": "slider",

//         "value": 10
//     },
//     {
//         "id": 8,
//         "name": "Pants Style",
//         "category": 2,
//         "totalAmount": 50,
//         "selectorType": "slider",

//         "value": 10
//     },
//     {
//         "id": 9,
//         "name": "Pants Style",
//         "category": 2,
//         "totalAmount": 50,
//         "selectorType": "slider",

//         "value": 10
//     }
// ]

//JSON Example for contextualDatas
// const contextualDatasExampleVariation = [
//     {
//         "id": 1,
//         "contextual": "variation",
//         "variationAmount": 50,

//         "variationValue": 1,

//         "tints": [
//             {
//                 "tintId": 1,
//                 "value": 25
//             },
//             {
//                 "tintId": 2,
//                 "value": 50
//             },
//             {
//                 "tintId": 3,
//                 "value": 75
//             }
//         ],

//         "advanced": true,
//         "advancedValues": [
//             {
//                 "valueName": "Opacity",
//                 "valueId": 1,
//                 "valueValue": 25,
//                 "maxValue": 100,
//                 "minValue": 0
//             }, {
//                 "valueName": "Palette",
//                 "valueId": 2,
//                 "valueValue": 20,
//                 "maxValue": 25,
//                 "minValue": 1
//             }]

//     }
// ]

// const contextualDatasExampleTint = [
//     {
//         "id": 2,
//         "contextual": "colour",
//         "tintAmount": 6,
//         "colours": [
//             {
//                 "id": "1",
//                 "image": "./img/colours/1.png"
//             },
//             {
//                 "id": "2",
//                 "image": "./img/colours/2.png"
//             },
//             {
//                 "id": "3",
//                 "image": "./img/colours/3.png"
//             },
//             {
//                 "id": "4",
//                 "image": "./img/colours/4.png"
//             },
//             {
//                 "id": "5",
//                 "image": "./img/colours/5.png"
//             },
//             {
//                 "id": "6",
//                 "image": "./img/colours/6.png"
//             }
//         ],

//         "tintValue": 1
//     }
// ]


//JSON Outfit List Menu
// const MyOutfits = [
//     {
//         "id": 1,
//         "name": "Sherif",
//         "Value": "3.00",
//     },
//     {
//         "id": 2,
//         "name": "Sexe",
//         "Value": "2.00",
//     }
// ]



///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                      GLOBAL ELEMENTS                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

//Global Table values
let MyOutfits = []
let categories = [];
let items = [];
let myItems = [];

//Global Variables
let menuType = 'default';
let outfitElemId = '';
let myOutfitcategoryId = '';
let userNaked = '';

//Translation System
let translations = {};

// Apply translations to static HTML elements
function applyStaticTranslations() {
    // Outfit list menu
    document.querySelector('#OutfitListMenu #title h1').textContent = T('headers.barber');
    document.getElementById('CreateNewOutfit').textContent = T('labels.createNewFacialStyle');
    document.getElementById('CloseMyOutfit').textContent = T('buttons.back');

    // My outfit variations menu
    document.querySelector('#OutfitVariations #title h1').textContent = T('headers.myFacialStyles');
    document.getElementById('ClothesCategorie').textContent = T('labels.clothes');
    document.getElementById('SkinCategorie').textContent = T('labels.skin');
    document.getElementById('SaveActualOutfit').textContent = T('buttons.save');
    document.getElementById('ResetActualOutfit').textContent = T('buttons.reset');
    document.getElementById('CloseActualOutfit').textContent = T('buttons.cancel');

    // Outfit creation/modification menu
    document.querySelector('#OutfitMenu #title h1').textContent = T('headers.barber');
    document.getElementById('CreateOutfit').innerHTML = T('price.savePrice') + '0';
    document.getElementById('ResetOutfit').textContent = T('buttons.reset');
    document.getElementById('CancelOutfit').textContent = T('buttons.cancel');

    // Contextual menus
    document.querySelector('#VariationSettings h2').textContent = T('headers.variationSettings');
    document.querySelector('#TintSettings h2').textContent = T('headers.colourSettings');
    document.querySelector('#CameraSettings h2').textContent = T('headers.cameraPosition');
}

// Load translation file
function loadTranslations() {
    fetch('language_config.json')
        .then(response => response.json())
        .then(data => {
            translations = data;
            applyStaticTranslations();
            console.log('Translations loaded successfully');
        })
        .catch(error => {
            console.error('Error loading translations:', error);
            // Fallback to English if translation file fails to load
            translations = {
                "buttons": {
                    "cancel": "Cancel",
                    "accept": "Accept",
                    "save": "Save",
                    "back": "Back",
                    "reset": "Reset",
                    "delete": "Delete",
                    "create": "Create"
                },
                "headers": {
                    "barber": "BARBER",
                    "myFacialStyles": "MY FACIAL STYLES",
                    "variationSettings": "Variation settings",
                    "colourSettings": "Colour settings",
                    "cameraPosition": "Camera position",
                    "warning": "Warning!",
                    "outfitName": "Outfit Name",
                    "newOutfit": "New Outfit!"
                },
                "labels": {
                    "createNewFacialStyle": "Create new facial style",
                    "createNewFacialStyleMannequin": "Create new facial style using mannequin",
                    "naked": "Naked",
                    "clothes": "Clothes",
                    "skin": "Skin",
                    "style": "Style",
                    "variation": "Variation",
                    "colour": "Colour",
                    "var": "Var",
                    "true": "True",
                    "false": "False",
                    "male": "Male",
                    "female": "Female",
                    "enterOutfitName": "Enter the name of the outfit"
                },
                "messages": {
                    "deleteOutfitConfirm": "Are you sure you want to delete",
                    "outfit": "outfit?",
                    "resetOutfitConfirm": "Are you sure you want to reset the outfit you are creating?",
                    "selectGender": "Select the gender"
                },
                "price": {
                    "savePrice": "Save - $"
                }
            };
            applyStaticTranslations();
        });
}

// Wait for DOM before loading translations
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', loadTranslations);
} else {
    loadTranslations();
}

// Helper function to get translation
function T(path) {
    const keys = path.split('.');
    let value = translations;
    for (const key of keys) {
        if (value && typeof value === 'object' && key in value) {
            value = value[key];
        } else {
            console.warn(`Translation not found for: ${path}`);
            return path;
        }
    }
    return value;
}

////////////////////////// OUTFIT MENU (MODIFICATION / CREATION) //////////////////////////

// Show and Hide Job Menu
function showOutfitMenu() {
    const outfitMenu = document.getElementById('OutfitMenu');
    const cameraMenu = document.getElementById('CameraSettings');
    outfitMenu.classList.remove('hidden');
    cameraMenu.classList.remove('hidden');
    loadCameraMenu();
    loadCategories();
}

// Hide Outfit Menu
function hideOutfitMenu() {
    const outfitMenu = document.getElementById('OutfitMenu');
    outfitMenu.classList.add('hidden');

    const categoriesContainer = document.getElementById('Categories');
    categoriesContainer.innerHTML = '';

    const itemsContainer = document.getElementById('StyleProperties');
    itemsContainer.innerHTML = '';

    hideContextualMenu();
    document.getElementById('CreateOutfit').innerHTML = T('price.savePrice') + '0.00';
}

////////////////////////// OUTFIT LIST MENU (ALL MY OUTFITS) //////////////////////////

// Show and Hide Job Menu
function showOutfitListMenu() {
    const outfitListMenu = document.getElementById('OutfitListMenu');
    const cameraMenu = document.getElementById('CameraSettings');
    cameraMenu.classList.remove('hidden');
    outfitListMenu.classList.remove('hidden');

    LoadOutfitList(MyOutfits);
    loadCameraMenu();
}

// Hide Outfit List Menu
function hideOutfitListMenu() {
    const outfitListMenu = document.getElementById('OutfitListMenu');
    const cameraMenu = document.getElementById('CameraSettings');
    const deletionConfirmation = document.getElementById('DeletionConfirmation');

    outfitListMenu.classList.add('hidden');
    cameraMenu.classList.add('hidden');

    // Hide deletion confirmation if it is open
    if (deletionConfirmation && !deletionConfirmation.classList.contains('hidden')) {
        deletionConfirmation.classList.add('hidden');
    }
}

////////////////////////// MY OUTFIT MENU (ACTUAL OUTFIT VARIATION / GET NAKED) //////////////////////////

// Show My Outfit Items
function ShowMyOutfitItems() {

    document.getElementById('OutfitVariations').classList.remove('hidden');
    LoadNakedStatus();
}

// Hide My Outfit Items
function HideMyOutfitItems() {

    document.getElementById('OutfitVariations').classList.add('hidden');
}



////////////////////////// CONTEXTUAL MENU (FOR OUTFIT MODIFICATION / CREATION - TINT, VARIATIONS...) //////////////////////////

// Show Contextual Menu
function showContextualMenu(contextualType) {
    const variationMenu = document.getElementById("VariationSettings");
    const tintMenu = document.getElementById("TintSettings");

    if (contextualType === "variation") {
        // Only show variation menu if it's currently hidden
        if (variationMenu.classList.contains('hidden')) {
            variationMenu.classList.remove('hidden');
            tintMenu.classList.add('hidden');
        }
    } else if (contextualType === "colour") {
        // Only show tint menu if it's currently hidden
        if (tintMenu.classList.contains('hidden')) {
            tintMenu.classList.remove('hidden');
            variationMenu.classList.add('hidden');
        }
    }
}

// Hide Contextual Menu
function hideContextualMenu() {
    const variationSettings = document.getElementById('VariationSettings');
    const tintSettings = document.getElementById('TintSettings');

    if (!variationSettings.classList.contains('hidden')) {
        variationSettings.classList.add('hidden');
    }

    if (!tintSettings.classList.contains('hidden')) {
        tintSettings.classList.add('hidden');
    }
}

//Actual Selected Values
currentSelectedCategorie = 0;
currentSelectedItem = 0;





///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                     LOAD CATEGORIES                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////


// Load Categories
function loadCategories() {
    const categoriesContainer = document.getElementById('Categories');
    categoriesContainer.innerHTML = '';

    categories.forEach(category => {
        const categoryElem = document.createElement('a');
        categoryElem.classList.add('categoryElem');

        categoryElem.innerHTML = `
                <img src="${category.image}" alt="${category.name}">
        `;

        loadItems();

        categoryElem.addEventListener('click', () => {
            changeCategory(category.id);
            currentSelectedCategorie = category.id;

            //Hide Contextual Datas
            document.getElementById('VariationSettings').classList.add('hidden');
            document.getElementById('TintSettings').classList.add('hidden');

            const cate = document.querySelectorAll('.categoryElem');
            cate.forEach(catego => {
                catego.classList.remove('selected');
            });

            if (currentSelectedCategorie === category.id) {
                categoryElem.classList.add('selected');
            }

        });
        categoriesContainer.appendChild(categoryElem);
    });
}





///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                       LOAD ITEMS                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

function changeCategory(categoryId) {

    items.forEach(item => {

        const itemElem = document.getElementById('item_' + item.id);

        if (item.category === categoryId) {
            itemElem.classList.remove('hidden');
        }
        else {
            itemElem.classList.add('hidden');
        }

    });

};


// Load Items
function loadItems() {
    const itemsContainer = document.getElementById('StyleProperties');
    itemsContainer.innerHTML = '';

    items.forEach(item => {

        if (item.selectorType === "slider") {

            const itemElem = document.createElement('div');
            itemElem.innerHTML = `
                    <div class="styleElem unselectable hidden" id="item_${item.id}">
                        <p class="elemTitle">${item.name}</p>
                        <div class="sliderDiv">
                            <p class="sliderValue unselectable" id="sliderValue_${item.id}">${T('labels.style')} ${item.value}</p>
                            <div class="sliderElem">
                                <a id="left_arrow_${item.id}" class="arrow"><img src="./img/arrow.png" alt="Arrow left"></a>
                                <input type="range" min="0" max="${item.totalAmount}" value="${item.value}" class="slider" id="rangeGlobal_${item.id}">
                                <a id="right_arrow_${item.id}" class="arrow"><img src="./img/arrow.png" alt="Arrow right" style="transform: rotate(180deg);"></a>
                            </div>
                        </div>
                    </div>
                `;

            itemsContainer.appendChild(itemElem);

            //Update Range Background
            updateRangeBackground('rangeGlobal_' + item.id);

            itemElem.addEventListener('click', () => {

                if (currentSelectedItem !== item.id) {

                    //Remove red stroke around all items
                    currentSelectedItem = item.id;
                    const items = document.querySelectorAll('.styleElem');
                    items.forEach(item => {
                        item.classList.remove('selected');

                    });

                    //Show red stoke around selected item
                    const actualItem = document.getElementById('item_' + item.id);
                    actualItem.classList.add('selected');

                    $.post(`https://${GetParentResourceName()}/itemValue`, JSON.stringify({
                        category: item.id, menu: item.category,
                    }));

                }

            });

            document.getElementById('right_arrow_' + item.id).addEventListener('click', () => {
                const slider = document.getElementById('rangeGlobal_' + item.id);
                if (slider.value !== slider.max) {
                    slider.value = parseInt(slider.value) + 1;
                    document.getElementById('sliderValue_' + item.id).innerText = `${T('labels.style')} ${slider.value}`;

                    updateRangeBackground('rangeGlobal_' + item.id);
                }

                $.post(`https://${GetParentResourceName()}/itemValue`, JSON.stringify({
                    category: item.id, menu: item.category,
                    item: slider.value
                }));


            });

            document.getElementById('left_arrow_' + item.id).addEventListener('click', () => {
                const slider = document.getElementById('rangeGlobal_' + item.id);
                if (slider.value !== slider.min) {
                    slider.value = parseInt(slider.value) - 1;
                    document.getElementById('sliderValue_' + item.id).innerText = `${T('labels.style')} ${slider.value}`;

                    updateRangeBackground('rangeGlobal_' + item.id);

                }

                $.post(`https://${GetParentResourceName()}/itemValue`, JSON.stringify({
                    category: item.id, menu: item.category,
                    item: slider.value
                }));


            });

            // document.getElementById('rangeGlobal_' + item.id).addEventListener('input', () => {
            //     const slider = document.getElementById('rangeGlobal_' + item.id);
            //     document.getElementById('sliderValue_' + item.id).innerText = `Style ${slider.value}`;

            //     $.post(`https://${GetParentResourceName()}/itemValue`, JSON.stringify({
            //         category: item.id, menu: item.category,,
            //         item: slider.value
            //     }));
            // });

            document.getElementById('rangeGlobal_' + item.id).addEventListener('input', () => {
                const slider = document.getElementById('rangeGlobal_' + item.id);
                document.getElementById('sliderValue_' + item.id).innerText = `${T('labels.style')} ${slider.value}`;

                updateRangeBackground('rangeGlobal_' + item.id);


            });

            document.getElementById('rangeGlobal_' + item.id).addEventListener('change', () => {
                const slider = document.getElementById('rangeGlobal_' + item.id);
                $.post(`https://${GetParentResourceName()}/itemValue`, JSON.stringify({
                    category: item.id, menu: item.category,
                    item: slider.value
                }));


            });

        }
        else if (item.selectorType === "selector") {

            const itemElem = document.createElement('div');
            itemElem.innerHTML = `
                    <div class="styleElem typeTwo unselectable" id="item_${item.id}">
                        <p class="elemTitle">${item.name}</p>
                        <div class="sliderDiv">
                            <div class="sliderElemTypeTwo">
                                <a id="left_arrow_${item.id}" class="arrow"><img src="./img/arrow.png" alt="Arrow left"></a>
                                <p class="sliderValueTypeTwo unselectable" id="sliderValue_${item.id}">${T('labels.style')} ${item.value}</p>
                                <input type="range" min="0" max="${item.totalAmount}" value="${item.value}" class="hidden" id="rangeGlobal_${item.id}">
                                <a id="right_arrow_${item.id}" class="arrow"><img src="./img/arrow.png" alt="Arrow right" style="transform: rotate(180deg);"></a>
                            </div>
                        </div>

                    </div>
                `;

            itemElem.addEventListener('click', () => {

                if (currentSelectedItem !== item.id) {
                    currentSelectedItem = item.id;
                    const items = document.querySelectorAll('.styleElem');
                    items.forEach(item => {
                        item.classList.remove('selected');
                    });


                    if (item.contextual === "variation") {
                        document.getElementById("VariationSettings").classList.remove('hidden');
                        document.getElementById("TintSettings").classList.add('hidden');
                    } else if (item.contextual === "tint") {
                        document.getElementById("TintSettings").classList.remove('hidden');
                        document.getElementById("VariationSettings").classList.add('hidden');
                    }

                    const actualItem = document.getElementById('item_' + item.id);
                    actualItem.classList.add('selected');

                    $.post(`https://${GetParentResourceName()}/itemValue`, JSON.stringify({
                        item: item.id
                    }));
                }

            });
            itemsContainer.appendChild(itemElem);

            document.getElementById(`right_arrow_${item.id}`).addEventListener('click', () => {
                const slider = document.getElementById(`rangeGlobal_${item.id}`);
                if (slider.value < slider.max) {
                    slider.value = parseInt(slider.value) + 1;
                    document.getElementById('sliderValue_' + item.id).innerText = `${T('labels.style')} ${slider.value}`;
                }

                $.post(`https://${GetParentResourceName()}/itemValue`, JSON.stringify({
                    category: item.id, menu: item.category,
                    item: slider.value
                }));

            });

            document.getElementById(`left_arrow_${item.id}`).addEventListener('click', () => {
                const slider = document.getElementById(`rangeGlobal_${item.id}`);
                if (slider.value > slider.min) {
                    slider.value = parseInt(slider.value) - 1;
                    document.getElementById('sliderValue_' + item.id).innerText = `${T('labels.style')} ${slider.value}`;
                }

                $.post(`https://${GetParentResourceName()}/itemValue`, JSON.stringify({
                    category: item.id, menu: item.category,
                    item: slider.value
                }));
            });


        }
    });
}






///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                     LOAD CONTEXTUAL                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

// Load Contextual Datas
function loadContextualDatas(contextualDatas) {
    // Check if contextualDatas is an array
    if (!Array.isArray(contextualDatas)) {
        console.error('contextualDatas must be an array');
        return;
    }

    contextualDatas.forEach(contextualData => {
        if (contextualData.contextual === "variation") {
            // Check if there is only one variation
            if (contextualData.variationAmount === 1) {

                //Don't show the variation menu
                document.getElementById('ContextSettings').classList.add('hidden');
                document.getElementById('separator_var').classList.add('hidden');

            } else {
                document.getElementById('ContextSettings').classList.remove('hidden');
                document.getElementById('separator_var').classList.remove('hidden');
                //Show the variation menu
                document.getElementById('varSlider').innerHTML = `
                
                <p class="unselectable">Var - <span id="actualVar">${contextualData.variationValue}</span></p>

                <div class="unselectable">

                    <a id="left_arrow_variation" class="arrow"><img src="./img/arrow.png" alt="Arrow left"></a>
                    <input type="range" name="Variation" id="rangeVariation" min="1" max="${contextualData.variationAmount}" value="${contextualData.variationValue}">
                    <a id="right_arrow_variation" class="arrow"><img src="./img/arrow.png" alt="Arrow right" style="transform: rotate(180deg);"></a>

                </div>
                `;

                document.getElementById('right_arrow_variation').addEventListener('click', () => {
                    const slider = document.getElementById('rangeVariation');
                    if (slider.value !== slider.max) {
                        slider.value = parseInt(slider.value) + 1;
                        document.getElementById('actualVar').innerText = `${slider.value}`;
                    }

                    $.post(`https://${GetParentResourceName()}/varValue`, JSON.stringify({
                        item: slider.value,
                        category: contextualData.category
                    }));
                });

                document.getElementById('left_arrow_variation').addEventListener('click', () => {
                    const slider = document.getElementById('rangeVariation');
                    if (slider.value !== slider.min) {
                        slider.value = parseInt(slider.value) - 1;
                        document.getElementById('actualVar').innerText = `${slider.value}`;
                    }

                    $.post(`https://${GetParentResourceName()}/varValue`, JSON.stringify({
                        item: slider.value,
                        category: contextualData.category
                    }));
                });

                document.getElementById('rangeVariation').addEventListener('input', () => {
                    const slider = document.getElementById('rangeVariation');
                    document.getElementById('actualVar').innerText = `${slider.value}`;

                    $.post(`https://${GetParentResourceName()}/varValue`, JSON.stringify({
                        item: slider.value,
                        category: contextualData.category
                    }));
                });
            };

            advancedContainer = document.getElementById('ContextSettingsAdvanced');
            advancedContainer.innerHTML = '';

            if (contextualData.advanced === true) {

                document.getElementById('ContextSettingsAdvanced').classList.remove('hidden');
                document.getElementById('separator_colour').classList.remove('hidden');

                contextualData.advancedValues.forEach(advanced => {


                    const tintElem = document.createElement('div');
                    tintElem.classList.add('ContextElem');

                    tintElem.innerHTML = `

                    <p class="unselectable">${advanced.valueName} - <span id="actuelAdvandedVar_${advanced.valueId}">${advanced.valueValue}</span></p>
                    <div class="unselectable">

                    <a id="left_arrow_advanced_${advanced.valueId}" class="arrow"><img src="./img/arrow.png" alt="Arrow left"></a>
                    <input type="range" name="Advanced_${advanced.valueId}" class="contRange" id="rangeadvanced_${advanced.valueId}" min="${advanced.minValue}" max="${advanced.maxValue}" value="${advanced.valueValue}">
                    <a id="right_arrow_advanced_${advanced.valueId}" class="arrow"><img src="./img/arrow.png" alt="Arrow right" style="transform: rotate(180deg);"></a>

                    </div>`;

                    advancedContainer.appendChild(tintElem);

                    document.getElementById('right_arrow_advanced_' + advanced.valueId).addEventListener('click', () => {
                        const slider = document.getElementById('rangeadvanced_' + advanced.valueId);
                        if (slider.value !== slider.max) {
                            slider.value = parseInt(slider.value) + 1;
                            document.getElementById('actuelAdvandedVar_' + advanced.valueId).innerText = `${slider.value}`;
                        }

                        $.post(`https://${GetParentResourceName()}/varValue`, JSON.stringify({
                            advancedValue: advanced.valueName,
                            itemValue: slider.value,
                            category: contextualData.category
                        }));
                    });

                    document.getElementById('left_arrow_advanced_' + advanced.valueId).addEventListener('click', () => {
                        const slider = document.getElementById('rangeadvanced_' + advanced.valueId);
                        if (slider.value !== slider.min) {
                            slider.value = parseInt(slider.value) - 1;
                            document.getElementById('actuelAdvandedVar_' + advanced.valueId).innerText = `${slider.value}`;
                        }

                        $.post(`https://${GetParentResourceName()}/varValue`, JSON.stringify({
                            advancedValue: advanced.valueName,
                            itemValue: slider.value,
                            category: contextualData.category
                        }));
                    });

                    document.getElementById('rangeadvanced_' + advanced.valueId).addEventListener('input', () => {
                        const slider = document.getElementById('rangeadvanced_' + advanced.valueId);
                        document.getElementById('actuelAdvandedVar_' + advanced.valueId).innerText = `${slider.value}`;
                    });

                    document.getElementById('rangeadvanced_' + advanced.valueId).addEventListener('change', () => {
                        const slider = document.getElementById('rangeadvanced_' + advanced.valueId);

                        $.post(`https://${GetParentResourceName()}/varValue`, JSON.stringify({
                            advancedValue: advanced.valueName,
                            itemValue: slider.value,
                            category: contextualData.category
                        }));
                    });

                });

            } else {
                document.getElementById('ContextSettingsAdvanced').classList.add('hidden');
                document.getElementById('separator_colour').classList.add('hidden');
            };

            tintContainer = document.querySelector('.TintList');
            tintContainer.innerHTML = '';

            contextualData.tints.forEach(tint => {


                const tintElem = document.createElement('div');
                tintElem.classList.add('ContextElem');

                tintElem.innerHTML = `

                <p class="unselectable">T${tint.tintId} - <span id="actualTint${tint.tintId}">${tint.value}</span></p>
                <div class="unselectable">

                <a id="left_arrow_tint${tint.tintId}" class="arrow"><img src="./img/arrow.png" alt="Arrow left"></a>
                <input type="range" name="Tint${tint.tintId}" class="contRange" id="rangeTint${tint.tintId}" min="1" max="255" value="${tint.value}">
                <a id="right_arrow_tint${tint.tintId}" class="arrow"><img src="./img/arrow.png" alt="Arrow right" style="transform: rotate(180deg);"></a>

                </div>


                `;

                tintContainer.appendChild(tintElem);

                document.getElementById('right_arrow_tint' + tint.tintId).addEventListener('click', () => {
                    const slider = document.getElementById('rangeTint' + tint.tintId);
                    if (slider.value !== slider.max) {
                        slider.value = parseInt(slider.value) + 1;
                        document.getElementById('actualTint' + tint.tintId).innerText = `${slider.value}`;
                    }

                    $.post(`https://${GetParentResourceName()}/tintValue`, JSON.stringify({
                        tintId: tint.tintId,
                        value: slider.value,
                        category: contextualData.category
                    }));
                });

                document.getElementById('left_arrow_tint' + tint.tintId).addEventListener('click', () => {
                    const slider = document.getElementById('rangeTint' + tint.tintId);
                    if (slider.value !== slider.min) {
                        slider.value = parseInt(slider.value) - 1;
                        document.getElementById('actualTint' + tint.tintId).innerText = `${slider.value}`;
                    }

                    $.post(`https://${GetParentResourceName()}/tintValue`, JSON.stringify({
                        tintId: tint.tintId,
                        value: slider.value,
                        category: contextualData.category
                    }));
                });

                document.getElementById('rangeTint' + tint.tintId).addEventListener('input', () => {
                    const slider = document.getElementById('rangeTint' + tint.tintId);
                    document.getElementById('actualTint' + tint.tintId).innerText = `${slider.value}`;

                    $.post(`https://${GetParentResourceName()}/tintValue`, JSON.stringify({
                        tintId: tint.tintId,
                        value: slider.value,
                        category: contextualData.category
                    }));
                });

            });


        } else if (contextualData.contextual === "colour") {


            document.getElementById('TintElement').innerHTML = `
                
                <div class="ElemSliderTint unselectable">

                    <div class="sliderElemTypeTwo">
                        <a id="Colour_left_arrow" class="arrow"><img src="./img/arrow.png"
                                alt="Arrow left"></a>
                        <p class="sliderValueTypeTwo unselectable" id="ColourTintValue">${T('labels.colour')} ${contextualData.tintValue}</p>
                        <input type="range" name="Colour" class="contRange hidden" id="ColourRange" min="1" max="${contextualData.tintAmount}" value="${contextualData.tintValue}">
                        <a id="Colour_right_arrow" class="arrow"><img src="./img/arrow.png"
                                alt="Arrow right" style="transform: rotate(180deg);"></a>
                    </div>
                </div>`;

            document.getElementById('Colour_right_arrow').addEventListener('click', () => {
                const slider = document.getElementById('ColourRange');
                if (slider.value !== slider.max) {
                    slider.value = parseInt(slider.value) + 1;
                    document.getElementById('ColourTintValue').innerText = `${T('labels.colour')} ${slider.value}`;

                    contextualData.colours.forEach(colour => {

                        document.getElementById('Colour_' + colour.id).classList.remove('selected');

                        if (colour.id === slider.value) {
                            document.getElementById('Colour_' + colour.id).classList.add('selected');
                        };

                    });

                }

                $.post(`https://${GetParentResourceName()}/varValue`, JSON.stringify({
                    item: slider.value,
                }));
            });

            document.getElementById('Colour_left_arrow').addEventListener('click', () => {
                const slider = document.getElementById('ColourRange');
                if (slider.value !== slider.min) {
                    slider.value = parseInt(slider.value) - 1;
                    document.getElementById('ColourTintValue').innerText = `${T('labels.colour')} ${slider.value}`;

                    contextualData.colours.forEach(colour => {

                        document.getElementById('Colour_' + colour.id).classList.remove('selected');

                        if (colour.id === slider.value) {
                            document.getElementById('Colour_' + colour.id).classList.add('selected');
                        };

                    });
                }

                $.post(`https://${GetParentResourceName()}/varValue`, JSON.stringify({
                    item: slider.value,
                }));
            });

            //Empty Colour List
            colourList = document.getElementById('ColourList');
            colourList.innerHTML = '';

            //Create new Colour List
            contextualData.colours.forEach(colour => {

                const colourElem = document.createElement('a');

                colourElem.innerHTML = `<img src="${colour.image}" alt="colour ${colour.id}" id="Colour_${colour.id}" class="Colour">`;
                colourList.appendChild(colourElem);

                document.getElementById('Colour_' + colour.id).addEventListener('click', () => {
                    const slider = document.getElementById('ColourRange');
                    slider.value = parseInt(colour.id);

                    document.getElementById('ColourTintValue').innerText = `${T('labels.colour')} ${slider.value}`;

                    contextualData.colours.forEach(colour => {

                        document.getElementById('Colour_' + colour.id).classList.remove('selected');

                        if (colour.id === slider.value) {
                            document.getElementById('Colour_' + colour.id).classList.add('selected');
                        };

                    });


                    $.post(`https://${GetParentResourceName()}/varValue`, JSON.stringify({
                        item: slider.value,
                    }));
                });

                if (colour.id === (contextualData.tintValue).toString()) {
                    document.getElementById('Colour_' + colour.id).classList.add('selected');
                };

            });


        }
    });
}





///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                        LOAD CAMERA                                                //
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

function loadCameraMenu() {

    //NE PAS SUPPRIMER OU REMPLACER JSON LOCAL
    const cameraDatas = [
        {
            "cameraName": 'H',
            "value": 180
        },
        {
            "cameraName": 'Z',
            "value": 217
        },
        {
            "cameraName": 'R',
            "value": 180
        }
    ]


    camContainer = document.querySelector('.CameraList');
    camContainer.innerHTML = '';

    cameraDatas.forEach(cam => {


        const camElem = document.createElement('div');
        camElem.classList.add('CamElem');

        camElem.innerHTML = `

                <p class="unselectable">${cam.cameraName}</p>
                <div class="unselectable">

                    <a id="left_arrow_cam_${cam.cameraName}" class="arrow"><img src="./img/arrow.png" alt="Arrow left"></a>
                    <input type="range" value="${cam.value}" min="1" max="360" name="Variation" class="contRange" id="camRange_${cam.cameraName}">
                    <a id="right_arrow_cam_${cam.cameraName}" class="arrow"><img src="./img/arrow.png" alt="Arrow right" style="transform: rotate(180deg);"></a>

                </div>`;

        camContainer.appendChild(camElem);

        document.getElementById('right_arrow_cam_' + cam.cameraName).addEventListener('click', () => {
            const slider = document.getElementById('camRange_' + cam.cameraName);
            if (slider.value !== slider.max) {
                slider.value = parseInt(slider.value) + 1;
            }

            $.post(`https://${GetParentResourceName()}/cameraChange`, JSON.stringify({
                cameraName: cam.cameraName,
                value: slider.value
            }));
        });

        document.getElementById('left_arrow_cam_' + cam.cameraName).addEventListener('click', () => {
            const slider = document.getElementById('camRange_' + cam.cameraName);
            if (slider.value !== slider.min) {
                slider.value = parseInt(slider.value) - 1;
            }

            $.post(`https://${GetParentResourceName()}/cameraChange`, JSON.stringify({
                cameraName: cam.cameraName,
                value: slider.value
            }));
        });

        document.getElementById('camRange_' + cam.cameraName).addEventListener('input', () => {
            const slider = document.getElementById('camRange_' + cam.cameraName);

            $.post(`https://${GetParentResourceName()}/cameraChange`, JSON.stringify({
                cameraName: cam.cameraName,
                value: slider.value
            }));
        });

    });

}





///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                    LOAD OUTFITS LIST                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

function LoadOutfitList(outfits) {

    const outfitListContainer = document.getElementById('OutfitList');
    outfitListContainer.innerHTML = '';

    outfits.forEach(outfit => {
        const outfitElem = document.createElement('div');
        outfitElem.classList.add('OutfitElement');

        outfitElem.innerHTML = `

         <div class="OutfitElemTitle">

                  <div style="display: flex; align-items: center;width: 100%;">
                      <p class="OutfitName unselectable" style="max-width: 110px;">${outfit.name}</p>
                      <p class="OutfitPrice unselectable">- ${outfit.Value}</p>
                  </div>
           </div>      

            <div class="InteractionDiv">

              <a class="buttonOutfitLeft unselectable" id="buttonViewOutfit_${outfit.id}"><img src="./img/icons/eye.png"></a>
              <a class="buttonOutfit unselectable" id="modifyOutfit_${outfit.id}"><img src="./img/icons/pen.png"></a>
              <a class="buttonOutfit unselectable" id="recoverOutfit_${outfit.id}"><img src="./img/icons/cash.png"></a>
              <a class="buttonOutfit unselectable" id="deleteOutfit_${outfit.id}"><img src="./img/icons/close.png"></a>

           </div>
        `;

        outfitListContainer.appendChild(outfitElem);

        document.getElementById('buttonViewOutfit_' + outfit.id).addEventListener('click', () => {
            $.post(`https://${GetParentResourceName()}/showOutfit`, JSON.stringify({
                outfit: outfit.id
            }));
        });

        //Mofify Outfit
        document.getElementById('modifyOutfit_' + outfit.id).addEventListener('click', () => {
            $.post(`https://${GetParentResourceName()}/modifyOutfit`, JSON.stringify({
                outfit: outfit.id,
                price: outfit.Value
            }));
        });

        //Recover Outfit
        document.getElementById('recoverOutfit_' + outfit.id).addEventListener('click', () => {
            $.post(`https://${GetParentResourceName()}/recoverOutfit`, JSON.stringify({
                outfit: outfit.id,
                name: outfit.name,
                price: outfit.Value
            }));
        });

        //Delete Outfit
        document.getElementById('deleteOutfit_' + outfit.id).addEventListener('click', () => {

            document.getElementById('DeletionConfirmation').classList.remove('hidden');

            document.getElementById('DeletionConfirmation').innerHTML = `

                <div id = "DeletionConfirmationElem" >

                <div id = "DeletionConfirmationContent" >

                <div id="DeletionConfirmationTitle">

                    <h1>${T('headers.warning')}</h1>
                    <p>${T('messages.deleteOutfitConfirm')} <span style="color:#ff8585;"> ${outfit.name} </span> ${T('messages.outfit')}</p>

                </div>

                <div id="DeletionConfirmationInteraction">

                    <a id="canceDeletationOutfit_${outfit.id}" class="button_del">${T('buttons.cancel')}</a>
                    <a id="confirmDeletationOutfit_${outfit.id}" class="button_del">${T('buttons.delete')}</a>

                </div>

                </div>

                </div>
        `;

            //Accept Deletion Outfit
            document.getElementById('confirmDeletationOutfit_' + outfit.id).addEventListener('click', () => {
                $.post(`https://${GetParentResourceName()}/deleteOutfit`, JSON.stringify({
                    outfit: outfit.id
                }));
                document.getElementById('DeletionConfirmation').classList.add('hidden');
            });

            //Cancel Deletion Outfit
            document.getElementById('canceDeletationOutfit_' + outfit.id).addEventListener('click', () => {
                $.post(`https://${GetParentResourceName()}/canceldelete`, JSON.stringify({
                }));
                document.getElementById('DeletionConfirmation').classList.add('hidden');
            });

        });


    });

    //Create New Outfit
    document.getElementById('CreateNewOutfitGlob').addEventListener('click', () => {
        $.post(`https://${GetParentResourceName()}/createNewOutfit`);
        hideOutfitListMenu();

    });

    //Close Outfit Menu
    document.getElementById('CloseMyOutfit').addEventListener('click', () => {
        $.post(`https://${GetParentResourceName()}/closeoutfitmenu`);
    });

}


///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                     LOAD NAKED STATUS                                             //
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

function LoadNakedStatus() {

    const NakedVariation = document.getElementById('NakedVariation');

    if (userNaked === "true") {

        NakedVariation.innerHTML = `

            <div class="styleElem typeTwo unselectable" id="item">
               <p class="elemTitle">${T('labels.naked')}</p>
               <div class="sliderDiv">
                   <div class="sliderElemTypeTwo">
                        <a id="naked_left_arrow" class="arrow"><img src="./img/arrow.png" alt="Arrow left"></a>
                        <p class="sliderValueTypeTwo unselectable" id="nakedValue">${T('labels.true')}</p>
                        <input type="range" min="0" max="2" value="True" class="hidden" id="rangeGlobal">
                        <a id="naked_right_arrow" class="arrow"><img src="./img/arrow.png" alt="Arrow right" style="transform: rotate(180deg);"></a>
                   </div>
                </div>

           </div>
        `;

        document.getElementById('naked_right_arrow').addEventListener('click', () => {
            userNaked = "false";
            LoadNakedStatus();

            $.post(`https://${GetParentResourceName()}/isNaked`, JSON.stringify({
                naked: 'false'
            }));
        });

        document.getElementById('naked_left_arrow').addEventListener('click', () => {
            userNaked = "false";
            LoadNakedStatus();

            $.post(`https://${GetParentResourceName()}/isNaked`, JSON.stringify({
                naked: 'false'
            }));
        });

    } else {
        NakedVariation.innerHTML = `

            <div class="styleElem typeTwo unselectable" id="item">
               <p class="elemTitle">${T('labels.naked')}</p>
               <div class="sliderDiv">
                   <div class="sliderElemTypeTwo">
                        <a id="naked_left_arrow" class="arrow"><img src="./img/arrow.png" alt="Arrow left"></a>
                        <p class="sliderValueTypeTwo unselectable" id="nakedValue">${T('labels.false')}</p>
                        <input type="range" min="0" max="2" value="True" class="hidden" id="rangeGlobal">
                        <a id="naked_right_arrow" class="arrow"><img src="./img/arrow.png" alt="Arrow right" style="transform: rotate(180deg);"></a>
                   </div>
                </div>

           </div>
        `;

        document.getElementById('naked_right_arrow').addEventListener('click', () => {
            userNaked = "true";
            LoadNakedStatus();

            $.post(`https://${GetParentResourceName()}/isNaked`, JSON.stringify({
                naked: 'true'
            }));
        });

        document.getElementById('naked_left_arrow').addEventListener('click', () => {
            userNaked = "true";
            LoadNakedStatus();

            $.post(`https://${GetParentResourceName()}/isNaked`, JSON.stringify({
                naked: 'true'
            }));
        });
    }

}


///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                   LOAD MY OUTFIT ITEMS                                            //
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

function LoadMyOutfitItems(myItems) {

    const myOutfitContainer = document.getElementById('MyOutfitProperties');
    myOutfitContainer.innerHTML = '';

    myItems.forEach(item => {
        if (item.category === myOutfitcategoryId) {

            const myOutFitElem = document.createElement('div');
            myOutFitElem.innerHTML = `
                    <div class="styleElem unselectable" id="myoutfit_${item.id}">
                        <p class="elemTitle">${item.name}</p>
                        <div class="sliderDiv">
                            <p class="sliderValue unselectable" id="myoutfit_sliderValue_${item.id}">${T('labels.variation')} ${item.value}</p>
                            <div class="sliderElem">
                                <a id="myoutfit_left_arrow_${item.id}" class="arrow"><img src="./img/arrow.png" alt="Arrow left"></a>
                                <input type="range" min="0" max="${item.totalAmount}" value="${item.value}" class="slider" id="myoutfitRange_${item.id}">
                                <a id="myoutfit_right_arrow_${item.id}" class="arrow"><img src="./img/arrow.png" alt="Arrow right" style="transform: rotate(180deg);"></a>
                            </div>
                        </div>
                    </div>
                `;

            myOutfitContainer.appendChild(myOutFitElem);

            document.getElementById('myoutfit_right_arrow_' + item.id).addEventListener('click', () => {
                const slider = document.getElementById('myoutfitRange_' + item.id);
                if (slider.value !== slider.max) {
                    slider.value = parseInt(slider.value) + 1;
                    document.getElementById('myoutfit_sliderValue_' + item.id).innerText = `${T('labels.variation')} ${slider.value}`;

                    updateRangeBackground('myoutfitRange_' + item.id);
                }

                $.post(`https://${GetParentResourceName()}/changeMyOutfitVar`, JSON.stringify({
                    category: item.id, menu: item.category,
                    item: slider.value
                }));
            });

            document.getElementById('myoutfit_left_arrow_' + item.id).addEventListener('click', () => {
                const slider = document.getElementById('myoutfitRange_' + item.id);
                if (slider.value !== slider.min) {
                    slider.value = parseInt(slider.value) - 1;
                    document.getElementById('myoutfit_sliderValue_' + item.id).innerText = `${T('labels.variation')} ${slider.value}`;

                    updateRangeBackground('myoutfitRange_' + item.id);
                }

                $.post(`https://${GetParentResourceName()}/changeMyOutfitVar`, JSON.stringify({
                    category: item.id, menu: item.category,
                    item: slider.value
                }));
            });

            document.getElementById('myoutfitRange_' + item.id).addEventListener('input', () => {
                const slider = document.getElementById('myoutfitRange_' + item.id);
                document.getElementById('myoutfit_sliderValue_' + item.id).innerText = `${T('labels.variation')} ${slider.value}`;

                updateRangeBackground('myoutfitRange_' + item.id);

                $.post(`https://${GetParentResourceName()}/changeMyOutfitVar`, JSON.stringify({
                    category: item.id, menu: item.category,
                    item: slider.value
                }));
            });



        }
    });

}






///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                         DOM                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////



// Event Listeners for interactions
document.addEventListener('DOMContentLoaded', function () {

    /////////////////////////// OUTFIT SAVE ///////////////////////////

    //Actual Outfit Save
    document.getElementById('SaveActualOutfit').addEventListener('click', () => {

        $.post(`https://${GetParentResourceName()}/saveMyOutfit`, JSON.stringify({
            outfitId: outfitElemId
        }));
    });

    //Actual Outfit Save
    document.getElementById('CloseActualOutfit').addEventListener('click', () => {

        $.post(`https://${GetParentResourceName()}/closeMyOutfitMenu`, JSON.stringify({
        }));
    });

    //Actual Outfit Reset
    document.getElementById('ResetActualOutfit').addEventListener('click', () => {

        $.post(`https://${GetParentResourceName()}/resetMyOutfit`, JSON.stringify({
            outfitId: outfitElemId
        }));
    });

    /////////////////////////// MY OUTFIT CATEGORIES ///////////////////////////

    //My Outfit select Clothes Categorie
    document.getElementById('ClothesCategorie').addEventListener('click', () => {
        myOutfitcategoryId = 1;
        document.getElementById('ClothesCategorie').classList.add('selected');
        document.getElementById('SkinCategorie').classList.remove('selected');
        LoadMyOutfitItems(myItems);
    });

    //My Outfit select Skin Categorie
    document.getElementById('SkinCategorie').addEventListener('click', () => {
        myOutfitcategoryId = 2;
        document.getElementById('ClothesCategorie').classList.remove('selected');
        document.getElementById('SkinCategorie').classList.add('selected');
        LoadMyOutfitItems(myItems);
    });


    /////////////////////////// CREATE OUTFIT ///////////////////////////

    //Event Create Outfit
    document.getElementById('CreateOutfit').addEventListener('click', () => {

        //Check if the outfit is already created
        if (menuType === "default") {

            document.getElementById('SelectOutfitName').classList.remove('hidden');

            document.getElementById('SelectOutfitName').innerHTML = `

                        <div id = "CreationConfirmationElem" >

                        <div id = "CreationConfirmationContent">

                        <div id="DeletionConfirmationTitle">

                            <h1>${T('headers.outfitName')}</h1>
                            <input type="text" class="outfitInput" id="outfitName" placeholder="${T('labels.enterOutfitName')}">

                        </div>

                        <div id="DeletionConfirmationInteraction">

                            <a id="cancelCreationOutfit" class="button_del">${T('buttons.cancel')}</a>
                            <a id="confirmCreationOutfit" class="button_del">${T('buttons.create')}</a>

                        </div>

                        </div>

                        </div>
                `;

            //Accept Creation Outfit
            document.getElementById('confirmCreationOutfit').addEventListener('click', () => {

                outfitName = document.getElementById('outfitName').value;

                $.post(`https://${GetParentResourceName()}/createOutfit`, JSON.stringify({
                    outfitName: outfitName
                }));
                document.getElementById('SelectOutfitName').classList.add('hidden');
            });

            //Cancel Creation Outfit
            document.getElementById('cancelCreationOutfit').addEventListener('click', () => {
                document.getElementById('SelectOutfitName').classList.add('hidden');
            });


        } else {
            $.post(`https://${GetParentResourceName()}/saveOutfit`, JSON.stringify({
                outfitid: outfitElemId
            }));
        }

    });


    document.getElementById('CancelOutfit').addEventListener('click', () => {
        $.post(`https://${GetParentResourceName()}/backToOutfitList`);
    });


    /////////////////////////// RESET OUTFIT ///////////////////////////

    //Event Reset Outfit
    document.getElementById('ResetOutfit').addEventListener('click', () => {

        document.getElementById('SelectOutfitName').classList.remove('hidden');
        document.getElementById('SelectOutfitName').innerHTML = `

            <div id = "DeletionConfirmationElem" >

                <div id = "DeletionConfirmationContent" >

                <div id="DeletionConfirmationTitle">

                    <h1>${T('headers.warning')}</h1>
                    <p>${T('messages.resetOutfitConfirm')}</p>

                </div>

                <div id="DeletionConfirmationInteraction">

                    <a id="cancelResetOutfit" class="button_del">${T('buttons.cancel')}</a>
                    <a id="confirmResetOutfit" class="button_del">${T('buttons.reset')}</a>

                </div>

                </div>

                </div>
    `;

        //Accept Creation Outfit
        document.getElementById('confirmResetOutfit').addEventListener('click', () => {

            $.post(`https://${GetParentResourceName()}/resetOutfit`, JSON.stringify({
            }));

            document.getElementById('SelectOutfitName').classList.add('hidden');

        });

        //Cancel Creation Outfit
        document.getElementById('cancelResetOutfit').addEventListener('click', () => {
            document.getElementById('SelectOutfitName').classList.add('hidden');
        });

    });


    //Event Create Outfit mannequin
    const mannequinBtn = document.getElementById('CreateNewOutfitMannequin');
    if (mannequinBtn) mannequinBtn.addEventListener('click', () => {

        document.getElementById('SelectOutfitGender').classList.remove('hidden');
        document.getElementById('SelectOutfitGender').innerHTML = `

            <div id = "DeletionConfirmationElem" >

                <div id = "DeletionConfirmationContent" >

                <div id="DeletionConfirmationTitle">

                    <h1>${T('headers.newOutfit')}</h1>
                    <p>${T('messages.selectGender')}</p>

                </div>

                <div id="DeletionConfirmationInteraction">

                    <a id="maleOutfit" class="button_del">${T('labels.male')}</a>
                    <a id="femaleOutfit" class="button_del">${T('labels.female')}</a>

                </div>

                </div>

                </div>
    `;

        //Male Outfit
        document.getElementById('maleOutfit').addEventListener('click', () => {

            $.post(`https://${GetParentResourceName()}/createMaleOutfit`, JSON.stringify({
            }));

            document.getElementById('SelectOutfitGender').classList.add('hidden');

        });

        //Female Outfit
        document.getElementById('femaleOutfit').addEventListener('click', () => {
            $.post(`https://${GetParentResourceName()}/createFemaleOutfit`, JSON.stringify({
            }));

            document.getElementById('SelectOutfitGender').classList.add('hidden');
        });

    });


});





///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                        MESSAGES                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

//Event Price Outfit
window.addEventListener('message', (event) => {
    if (event.data.type === 'setOutfitPricet') {
        document.getElementById('CreateOutfit').innerHTML = T('price.savePrice') + event.data.price;
    }
});

// Event Listener for the NUI Messages
window.addEventListener('message', function (event) {

    // Open Outfit Menu
    if (event.data.type === "openOutfitMenu") {
        console.log("Activer le menu outfit")
        if (event.data.categories) {
            categories = event.data.categories;
        }

        if (event.data.menu == "wearable") {
            this.document.getElementById('CreateOutfit').classList.add('cache');
        }
        else {
            this.document.getElementById('CreateOutfit').classList.remove('cache');
        }

        outfitElemId = event.data.outfitId;

        if (event.data.menu == "modify") {
            menuType = "modify";
        }
        else {
            menuType = "default";
        }

        if (event.data.items) {
            items = event.data.items;
        }
        showOutfitMenu();

    }

    // Open Actual Outfit Settings Menu
    if (event.data.type === "openMyOutfitMenu") {
        console.log("Activer le menu de mes outfit")
        if (event.data.myItems) {
            myItems = event.data.myItems;
            outfitElemId = event.data.outfitId;
        }
        ShowMyOutfitItems();
    }

    // Open Actual Outfit Settings Menu
    if (event.data.type === "closeMyOutfitMenu") {
        console.log("Fermer le menu de mes outfit")
        HideMyOutfitItems();
    }


    // Open Outfit List Menu
    if (event.data.type === "openOutfitListMenu") {
        console.log("Activer le menu de list de mes outfit")
        if (event.data.outfits) {
            MyOutfits = event.data.outfits;
        }
        showOutfitListMenu();
    }

    // Close Outfit Menu
    if (event.data.type === "closeOutfitMenu") {
        console.log("Fermer le menu outfit")
        hideOutfitMenu();
        hideOutfitListMenu();
    }

    // Open Outfit List Menu
    if (event.data.type === "closeOutfitListMenu") {
        console.log("Activer le menu de list de mes outfit")
        hideOutfitListMenu();
    }


    // Load contextualDatas
    if (event.data.type === "contextualDatas") {

        // Convert to array if it's an object
        const contextualData = Array.isArray(event.data.data) ? event.data.data : [event.data.data];
        const contextualType = contextualData[0]?.contextual
        showContextualMenu(contextualType);
        loadContextualDatas(contextualData);
        console.log("Charger les données de l'item", contextualData);
    }

    // Hide contextualDatas
    if (event.data.type === "hidecontextualDatas") {
        console.log("Cacher le contextuel");
        hideContextualMenu();
    }

});


// Escape Key
document.addEventListener('keyup', function (e) {
    if (e.key === "Escape") {
        $.post(`https://${GetParentResourceName()}/closeoutfitmenu`);
        $.post(`https://${GetParentResourceName()}/closeMyOutfitMenu`);
    }
});

// X Key
document.addEventListener('keyup', function (e) {
    if (e.key === "x") {
        $.post(`https://${GetParentResourceName()}/handsup`);
    }
});

const copyToClipboard = str => {
    const el = document.createElement('textarea');
    el.value = str;
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
};

window.addEventListener('message', (event) => {
    if (event.data.type === 'clipboard') {
        copyToClipboard(event.data.data);
    }
});





///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                    LOAD RED INPUT                                                 //
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////


function updateRangeBackground(rangeInput) {

    const style = document.createElement('style');
    document.head.appendChild(style);

    const rangeInputElem = document.getElementById(rangeInput);
    const value = rangeInputElem.value;
    const min = rangeInputElem.min || 0;
    const max = rangeInputElem.max || 100;
    const percentage = ((value - min) / (max - min)) * 100;

    const backgroundStyle = `
                    #` + rangeInput + ` {
                    background: linear-gradient(to right, 
                        red 0%, 
                        red ${percentage}%, 
                        #ddd ${percentage}%, 
                        #ddd 100%
                    ) !important;
                    }

                    /* Styles supplémentaires pour assurer la compatibilité avec différents navigateurs */
                    #` + rangeInput + `::-webkit-slider-runnable-track {
                    background: transparent;
                    }
                    
                    #` + rangeInput + `::-moz-range-track {
                    background: transparent;
                    }
                    
                    #` + rangeInput + `::-ms-track {
                    background: transparent;
                    }
                `;

    style.textContent = backgroundStyle;
};

