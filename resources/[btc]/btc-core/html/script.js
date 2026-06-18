// script.js
document.addEventListener('DOMContentLoaded', () => {
    // Elementos do Menu
    const menuContainer = document.getElementById('menu-container');
    const menuTitle = document.getElementById('menu-title');
    const menuSubtext = document.getElementById('menu-subtext');
    const menuSearchWrapper = document.getElementById('menu-search-wrapper');
    const menuSearch = document.getElementById('menu-search');
    const menuButtons = document.getElementById('menu-buttons');
    const itemFooter = document.getElementById('menu-item-footer');
    const menuHeader = menuTitle.parentElement;

    // Elementos da Barra de Progresso
    const progressBarContainer = document.getElementById('progress-bar-container');
    const progressBarLabel = document.getElementById('progress-bar-label');
    const progressBarFill = document.getElementById('progress-bar-fill');
    let progressTimer = null;

    if (!menuContainer || !menuTitle || !menuSubtext || !menuButtons || !itemFooter || !menuHeader || !progressBarContainer) {
        console.error('[btc-core] ERRO CRÍTICO: Um ou mais elementos da UI não foram encontrados. Verifique o seu ficheiro `html/index.html`.');
        return;
    }

    let selectedIndex = 0;
    let currentElements = [];
    let currentData = [];
    let isInputFocused = false;
    let isSearchFocused = false;
    let allRenderedElements = [];
    let allRenderedData = [];
    let isDragging = false;
    let offsetX, offsetY;

    if (menuHeader) {
        menuHeader.style.cursor = 'move';
        menuHeader.addEventListener('mousedown', (e) => {
            if (e.button !== 0) return;
            isDragging = true;
            offsetX = e.clientX - menuContainer.getBoundingClientRect().left;
            offsetY = e.clientY - menuContainer.getBoundingClientRect().top;
            menuContainer.style.transition = 'none';
            document.body.style.userSelect = 'none';
            document.addEventListener('mousemove', onMouseMove);
            document.addEventListener('mouseup', onMouseUp, { once: true });
        });
    }

    function onMouseMove(e) {
        if (!isDragging) return;
        const newX = e.clientX - offsetX;
        const newY = e.clientY - offsetY;
        menuContainer.style.left = `${newX}px`;
        menuContainer.style.top = `${newY}px`;
        menuContainer.style.right = 'auto';
        menuContainer.style.bottom = 'auto';
        menuContainer.style.transform = 'none';
    }

    function onMouseUp() {
        isDragging = false;
        menuContainer.style.transition = '';
        document.body.style.userSelect = '';
        document.removeEventListener('mousemove', onMouseMove);
    }

    async function post(eventName, data = {}) {
        try {
            const response = await fetch(`https://btc-core/${eventName}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=UTF-8' },
                body: JSON.stringify(data),
            });
            return await response.json();
        } catch (error) {
            console.error('[btc-core] Falha ao enviar POST para LUA:', error);
            return null;
        }
    }

    function createBar(barData) {
        const [current, max] = barData;
        const barContainer = document.createElement('div');
        barContainer.className = 'footer-item-bar-container';
        const barFill = document.createElement('div');
        barFill.className = 'footer-item-bar-fill';
        const percentage = Math.max(0, Math.min(100, (current / max) * 100));
        barFill.style.width = `${percentage}%`;
        barContainer.appendChild(barFill);
        return barContainer;
    }

    function updateFooter(elementData) {
        itemFooter.innerHTML = '';
        let hasContent = false;

        if (!elementData) {
            itemFooter.classList.add('hidden');
            return;
        }

        // 1. descriptionimages — grid de ícones com contagem (estilo btc-stable)
        if (Array.isArray(elementData.descriptionimages) && elementData.descriptionimages.length) {
            const grid = document.createElement('div');
            grid.className = 'description-images';
            elementData.descriptionimages.forEach(img => {
                const item = document.createElement('div');
                item.className = 'desc-img-item';
                if (img.count !== undefined && img.count !== null) {
                    const count = document.createElement('span');
                    count.className = 'desc-img-count';
                    count.textContent = img.count;
                    item.appendChild(count);
                }
                const icon = document.createElement('img');
                icon.className = 'desc-img-icon';
                icon.src = img.src || '';
                item.appendChild(icon);
                if (img.text) {
                    const text = document.createElement('span');
                    text.className = 'desc-img-text';
                    text.textContent = img.text;
                    item.appendChild(text);
                }
                grid.appendChild(item);
            });
            itemFooter.appendChild(grid);
            hasContent = true;
        }

        // 2. priceInfo — preço estruturado com divisores (estilo btc-stable)
        if (elementData.priceInfo) {
            const pi = elementData.priceInfo;
            const container = document.createElement('div');
            container.className = 'price-container';
            const topDiv = document.createElement('div');
            topDiv.className = 'divider-line';
            container.appendChild(topDiv);
            const row = document.createElement('div');
            row.className = 'price-row';
            if (pi.buyLabel) {
                const lbl = document.createElement('span');
                lbl.className = 'price-label';
                lbl.textContent = pi.buyLabel;
                row.appendChild(lbl);
            }
            const vals = document.createElement('div');
            vals.className = 'price-values';
            if (pi.price !== undefined && pi.price !== null) {
                const cash = document.createElement('span');
                cash.className = 'price-text';
                cash.textContent = '$' + pi.price.toLocaleString();
                vals.appendChild(cash);
            }
            if (pi.priceGold !== undefined && pi.priceGold !== null) {
                const gold = document.createElement('span');
                gold.className = 'price-text-gold';
                gold.textContent = '● ' + pi.priceGold;
                vals.appendChild(gold);
            }
            row.appendChild(vals);
            container.appendChild(row);
            const botDiv = document.createElement('div');
            botDiv.className = 'divider-line';
            container.appendChild(botDiv);
            itemFooter.appendChild(container);
            hasContent = true;
        }

        // 3. desc — texto descritivo do elemento (estilo btc-stable)
        if (elementData.desc) {
            const descDiv = document.createElement('div');
            descDiv.className = 'description-text';
            descDiv.innerHTML = elementData.desc;
            itemFooter.appendChild(descDiv);
            hasContent = true;
        }

        // 4. bottom — array de linhas com ícone, label e barra (funcionalidade original)
        if (Array.isArray(elementData.bottom)) {
            elementData.bottom.forEach(item => {
                const itemDiv = document.createElement('div');
                itemDiv.className = 'footer-item';
                let rowHasContent = false;
                if (item.lbar && Array.isArray(item.lbar) && item.lbar.length === 2) {
                    itemDiv.classList.add('is-bar-only');
                    itemDiv.appendChild(createBar(item.lbar));
                    rowHasContent = true;
                } else {
                    const row = document.createElement('div');
                    row.style.cssText = 'display:flex;align-items:center;width:100%';
                    if (item.icon) {
                        const iconDiv = document.createElement('div');
                        iconDiv.className = 'footer-item-icon';
                        let iconPath = item.icon;
                        if (!iconPath.includes('://')) iconPath = `./images/${iconPath}.png`;
                        iconDiv.style.backgroundImage = `url(${iconPath})`;
                        row.appendChild(iconDiv);
                        rowHasContent = true;
                    }
                    if (item.label) {
                        const lbl = document.createElement('span');
                        lbl.className = 'footer-item-label';
                        lbl.textContent = item.label;
                        row.appendChild(lbl);
                        rowHasContent = true;
                    }
                    if (rowHasContent) itemDiv.appendChild(row);
                    if (item.bar && Array.isArray(item.bar) && item.bar.length === 2) {
                        itemDiv.appendChild(createBar(item.bar));
                        rowHasContent = true;
                    }
                }
                if (rowHasContent) {
                    itemFooter.appendChild(itemDiv);
                    hasContent = true;
                }
            });
        }

        itemFooter.classList.toggle('hidden', !hasContent);
    }

    function filterBySearch(query) {
        const q = query.trim().toLowerCase();
        currentElements = [];
        currentData = [];
        allRenderedElements.forEach((el, i) => {
            const label = (allRenderedData[i].label || '').toLowerCase();
            const visible = !q || label.includes(q);
            el.style.display = visible ? '' : 'none';
            if (visible) {
                currentElements.push(el);
                currentData.push(allRenderedData[i]);
            }
        });
        selectedIndex = 0;
        if (currentElements.length > 0) updateSelection();
        else updateFooter(null);
    }

    function updateSelection() {
        if (currentElements.length === 0) return;
        currentElements.forEach((el, index) => {
            el.classList.toggle('selected', index === selectedIndex);
        });
        const selectedElement = currentElements[selectedIndex];
        selectedElement.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        updateFooter(currentData[selectedIndex]);
        const elem = currentData[selectedIndex];
        if (elem && elem.selectId) {
            post('onElementSelect', { selectId: elem.selectId });
        }
    }

    function openMenu(data) {
        menuContainer.className = '';
        menuContainer.style.left = '';
        menuContainer.style.top = '';
        menuContainer.style.right = '';
        menuContainer.style.bottom = '';
        menuContainer.style.transform = '';

        const menuTypeClass = data.menuType === 'other' ? 'layout-other' : 'layout-default';
        menuContainer.classList.add(menuTypeClass);
        const alignClass = `align-${data.align || 'top-left'}`;
        menuContainer.classList.add(alignClass);

        menuTitle.textContent = data.title || 'Menu';
        if (data.subtext) {
            menuSubtext.textContent = data.subtext;
            menuSubtext.classList.remove('hidden');
        } else {
            menuSubtext.classList.add('hidden');
        }
        menuButtons.innerHTML = '';
        currentElements = [];
        currentData = [];
        allRenderedElements = [];
        allRenderedData = [];
        selectedIndex = (typeof data.selectedIndex === 'number') ? data.selectedIndex : 0;

        if (data.searchable) {
            menuSearch.value = '';
            menuSearchWrapper.classList.remove('hidden');
            isSearchFocused = false;
        } else {
            menuSearchWrapper.classList.add('hidden');
        }

        data.elements.forEach((elem) => {
            const type = elem.type || 'button';
            const container = document.createElement('div');
            container.className = `menu-element ${type}-container`;
            if (elem.isBackButton) {
                container.classList.add('back-button');
            }

            if (elem.icon) {
                const iconDiv = document.createElement('div');
                iconDiv.className = 'element-icon';
                let iconPath = elem.icon;
                if (!iconPath.includes('://')) iconPath = `./images/${iconPath}.png`;
                iconDiv.style.backgroundImage = `url(${iconPath})`;
                container.appendChild(iconDiv);
            }
            const labelContainer = document.createElement('div');
            labelContainer.className = 'element-label-container';
            labelContainer.appendChild(createLabel(elem));
            container.appendChild(labelContainer);
            const moneyDisplay = buildMoneyDisplay(elem);
            if (moneyDisplay) container.appendChild(moneyDisplay);
            let interactiveElement;
            if (type === 'button') interactiveElement = buildButton(container, elem);
            else if (type === 'checkbox') interactiveElement = buildCheckbox(container, elem);
            else if (type === 'slider') interactiveElement = buildSlider(container, elem);
            else if (type === 'input') interactiveElement = buildInput(container, elem);

            if (interactiveElement) {
                interactiveElement.addEventListener('mouseenter', () => {
                    const newIndex = currentElements.indexOf(interactiveElement);
                    if (newIndex !== -1) {
                        selectedIndex = newIndex;
                        updateSelection();
                    }
                });
                menuButtons.appendChild(interactiveElement);
                if (type !== 'input') {
                    currentElements.push(interactiveElement);
                    currentData.push(elem);
                    allRenderedElements.push(interactiveElement);
                    allRenderedData.push(elem);
                }
            }
        });
        menuContainer.classList.remove('hidden');
        if (currentElements.length > 0) updateSelection();
    }

    function createLabel(elem) {
        const labelDiv = document.createElement('div');
        let content = `<div class="button-label">${elem.label || ''}</div>`;
        if (elem.description) {
            content += `<div class="button-description">${elem.description}</div>`;
        }
        labelDiv.innerHTML = content;
        return labelDiv;
    }

    function buildMoneyDisplay(elem) {
        if (!elem.money && elem.money !== 0) return null;
        const moneyContainer = document.createElement('div');
        moneyContainer.className = 'element-money-container';
        let cashValue = null, goldValue = null, bloodValue = null;
        if (typeof elem.money === 'object' && elem.money !== null) {
            cashValue = elem.money.cash;
            goldValue = elem.money.gold;
            bloodValue = elem.money.bloodmoney;
        } else if (typeof elem.money === 'number') {
            cashValue = elem.money;
        }
        if (cashValue !== null && cashValue !== undefined) {
            const cashDiv = document.createElement('div');
            cashDiv.className = 'money-value money-cash';
            cashDiv.textContent = cashValue.toLocaleString();
            moneyContainer.appendChild(cashDiv);
        }
        if (goldValue !== null && goldValue !== undefined) {
            const goldDiv = document.createElement('div');
            goldDiv.className = 'money-value money-gold';
            goldDiv.textContent = goldValue.toLocaleString();
            moneyContainer.appendChild(goldDiv);
        }
        if (bloodValue !== null && bloodValue !== undefined) {
            const bloodDiv = document.createElement('div');
            bloodDiv.className = 'money-value money-bloodmoney';
            bloodDiv.textContent = bloodValue.toLocaleString();
            moneyContainer.appendChild(bloodDiv);
        }
        return moneyContainer.hasChildNodes() ? moneyContainer : null;
    }

    function buildButton(container, elem) {
        container.classList.add('menu-button');
        container.addEventListener('click', () => post('onButtonClick', { actionId: elem.actionId }));
        return container;
    }

    function buildCheckbox(container, elem) {
        const checkboxVisual = document.createElement('div');
        checkboxVisual.className = 'checkbox-visual';
        if (elem.checked) checkboxVisual.classList.add('checked');
        const action = () => {
            const isChecked = !checkboxVisual.classList.contains('checked');
            checkboxVisual.classList.toggle('checked', isChecked);
            post('onValueChange', { elementId: elem.elementId, value: isChecked });
        };
        container.addEventListener('click', action);
        container.clickAction = action;
        container.appendChild(checkboxVisual);
        return container;
    }

    function buildSlider(container, elem) {
        const controlsDiv = document.createElement('div');
        controlsDiv.className = 'slider-controls';
        const slider = document.createElement('input');
        slider.type = 'range';
        slider.min = elem.min || 0;
        slider.max = elem.max || 100;
        slider.value = elem.value || 50;
        container.sliderInput = slider;
        const valueDisplay = document.createElement('span');
        valueDisplay.className = 'slider-value';
        valueDisplay.textContent = slider.value;
        slider.addEventListener('input', () => valueDisplay.textContent = slider.value);
        slider.addEventListener('change', () => post('onValueChange', { elementId: elem.elementId, value: parseFloat(slider.value) }));
        controlsDiv.appendChild(slider);
        controlsDiv.appendChild(valueDisplay);
        container.appendChild(controlsDiv);
        return container;
    }

    function buildInput(container, elem) {
        const input = document.createElement('input');
        input.type = 'text';
        input.value = elem.value || '';
        input.maxLength = elem.maxLength || 50;
        input.addEventListener('input', () => {
            const inputType = elem.inputType || 'any';
            if (inputType === 'letters') {
                input.value = input.value.replace(/[^a-zA-Z\s]/g, '');
            } else if (inputType === 'numbers') {
                let valor = input.value.replace(/[^0-9.]/g, '');
                const primeiroPonto = valor.indexOf('.');
                if (primeiroPonto !== -1) {
                    // Pega a parte da string ANTES e incluindo o primeiro ponto.
                    const parteInteiraDecimal = valor.substring(0, primeiroPonto + 1);

                    // Pega a parte da string DEPOIS do primeiro ponto.
                    const resto = valor.substring(primeiroPonto + 1);

                    // No 'resto', remove todos os outros pontos.
                    const restoSemPontos = resto.replace(/\./g, '');

                    // Junta as duas partes para formar o valor final.
                    valor = parteInteiraDecimal + restoSemPontos;
                }

                input.value = valor;
            }
            post('onValueChange', { elementId: elem.elementId, value: input.value });
        });
        input.addEventListener('focus', () => {
            isInputFocused = true;
            post('setInputFocus', { hasFocus: true });
        });
        input.addEventListener('blur', () => {
            isInputFocused = false;
            post('setInputFocus', { hasFocus: false });
        });
        container.appendChild(input);
        return container;
    }

    function closeMenu() {
        menuContainer.classList.add('hidden');
        menuButtons.innerHTML = '';
        itemFooter.innerHTML = '';
        menuSubtext.classList.add('hidden');
        menuSearchWrapper.classList.add('hidden');
        menuSearch.value = '';
        currentElements = [];
        currentData = [];
        allRenderedElements = [];
        allRenderedData = [];
        isInputFocused = false;
        isSearchFocused = false;
        post('setInputFocus', { hasFocus: false });
    }

    // Função para mostrar a barra de progresso
    function showProgressBar(data) {
        if (progressTimer) {
            clearInterval(progressTimer);
        }

        progressBarLabel.textContent = data.label || 'Aguarde...';
        progressBarFill.style.backgroundColor = data.color || '#e67e22';
        progressBarFill.style.width = '0%';
        progressBarFill.style.transition = 'width 0.1s linear';
        progressBarContainer.classList.remove('hidden');

        const duration = data.duration || 3000;
        let startTime = Date.now();

        progressTimer = setInterval(() => {
            const elapsedTime = Date.now() - startTime;
            const percentage = Math.min(100, (elapsedTime / duration) * 100);
            progressBarFill.style.width = `${percentage}%`;

            if (percentage >= 100) {
                clearInterval(progressTimer);
                progressTimer = null;
                setTimeout(() => {
                    progressBarContainer.classList.add('hidden');
                }, 300);
            }
        }, 30);
    }

    menuSearch.addEventListener('input', () => filterBySearch(menuSearch.value));
    menuSearch.addEventListener('focus', () => {
        isSearchFocused = true;
        post('setInputFocus', { hasFocus: true });
    });
    menuSearch.addEventListener('blur', () => {
        isSearchFocused = false;
        post('setInputFocus', { hasFocus: false });
    });

    window.addEventListener('message', (event) => {
        const { type, menuData, progressBarData, text } = event.data;
        if (type === 'open') {
            openMenu(menuData);
        } else if (type === 'close') {
            closeMenu();
        } else if (type === 'showProgressBar') {
            showProgressBar(progressBarData);
        } else if (type === 'btc_copy' && text) {
            const ta = document.createElement('textarea');
            ta.value = text;
            ta.style.cssText = 'position:fixed;opacity:0;pointer-events:none;';
            document.body.appendChild(ta);
            ta.focus();
            ta.select();
            document.execCommand('copy');
            document.body.removeChild(ta);
        }
    });

    document.addEventListener('keydown', (event) => {
        if (menuContainer.classList.contains('hidden')) return;

        if (isSearchFocused) {
            if (event.key === 'Escape') {
                event.preventDefault();
                menuSearch.blur();
                menuSearch.value = '';
                filterBySearch('');
                return;
            }
            // Setas e Enter saem do input e navegam o menu normalmente
            if (event.key === 'ArrowDown' || event.key === 'ArrowUp' || event.key === 'Enter') {
                menuSearch.blur();
                // cai no handler abaixo
            } else {
                return;
            }
        }

        if (isInputFocused && event.key === 'Backspace') {
            return;
        }

        const key = event.key;
        if (key === 'ArrowDown' || key === 'ArrowUp') {
            event.preventDefault();
            if (currentElements.length > 0) {
                if (key === 'ArrowDown') selectedIndex = (selectedIndex + 1) % currentElements.length;
                else selectedIndex = (selectedIndex - 1 + currentElements.length) % currentElements.length;
                updateSelection();
            }
        } else if (key === 'ArrowLeft' || key === 'ArrowRight') {
            const selectedElement = currentElements[selectedIndex];
            if (selectedElement && selectedElement.sliderInput) {
                event.preventDefault();
                const slider = selectedElement.sliderInput;
                const step = key === 'ArrowLeft' ? -1 : 1;
                const newValue = parseInt(slider.value, 10) + step;
                if (newValue >= slider.min && newValue <= slider.max) {
                    slider.value = newValue;
                    slider.dispatchEvent(new Event('input'));
                    slider.dispatchEvent(new Event('change'));
                }
            }
        } else if (key === 'Enter') {
            event.preventDefault();
            const selectedElement = currentElements[selectedIndex];
            if (selectedElement) {
                if (typeof selectedElement.clickAction === 'function') selectedElement.clickAction();
                else selectedElement.click();
            }
        } else if (key === 'Escape' || key === 'Backspace') {
            event.preventDefault();
            post('onMenuClose');
        }
    });
});
