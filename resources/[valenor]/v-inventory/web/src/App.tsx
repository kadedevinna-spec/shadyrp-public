import React, { useState, useEffect, MouseEvent } from 'react';
import { fetchNui } from './utils/fetchNui';
import './App.css';

interface Item {
    id: number;
    name: string;
    label: string;
    weight: number;
    amount: number;
    image: string;
    type: string;
    durability: number;
    dropId?: string;
    metadata?: any;
    price?: number;
    isShop?: boolean;
}
interface Slot {
    id: number;
    item: Item | null;
}

interface Locales {
    inventoryTitle: string;
    inventoryDesc: string;
    idLabel: string;
    filterLabel: string;
    filterDefault: string;
    filterAZ: string;
    filterZA: string;
    searchPlaceholder: string;
    weightTitle: string;
    noMetadata: string;
    amountTitle: string;
    useItem: string;
    giveItem: string;
    buyItem: string;
    takeOffClothes: string;
    wearClothes: string;
    exitInventory: string;
    customButton: string;
}

const INITIAL_LOCALE: Locales = {
    inventoryTitle: "INVENTORY",
    inventoryDesc: "Lorem ipsum dolor sit amet.",
    idLabel: "ID",
    filterLabel: "Filter",
    filterDefault: "Default",
    filterAZ: "A-Z",
    filterZA: "Z-A",
    searchPlaceholder: "Search...",
    weightTitle: "Weight",
    noMetadata: "No Metadata Found",
    amountTitle: "Amount",
    useItem: "Use",
    giveItem: "Give",
    buyItem: "Buy Item",
    takeOffClothes: "Take Off Clothes",
    wearClothes: "Wear Clothes",
    exitInventory: "Exit The Inventory",
    customButton: "Custom Button"
};

const INITIAL_SLOTS = 120;
const HORSE_SLOTS_COUNT = 10;
const GROUND_SLOTS_COUNT = 120;

const generateMockInventory = (count: number): Slot[] => {
    return Array.from({ length: count }, (_, i) => ({ id: i + 1, item: null }));
};

const MetadataContainer: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const ref = React.useRef<HTMLDivElement>(null);

    React.useEffect(() => {
        const el = ref.current;
        if (!el) return;

        const handleWheel = (e: WheelEvent) => {
            e.preventDefault();
            // Adjust the multiplier (0.1) to change the speed.
            // 0.1 means 10% of original speed.
            el.scrollTop += e.deltaY * 0.02;
        };

        el.addEventListener('wheel', handleWheel, { passive: false });

        return () => {
            el.removeEventListener('wheel', handleWheel);
        };
    }, []);

    return (
        <div className="item-metadata-container" ref={ref}>
            {children}
        </div>
    );
};

const App: React.FC = () => {
    const [inventoryActive, setInventoryActive] = useState(false);
    const [horseInventoryActive, setHorseInventoryActive] = useState(false);

    const processServerItems = (items: any[], totalSlots: number): Slot[] => {
        const slots = generateMockInventory(totalSlots);
        if (!items || !Array.isArray(items)) return slots;

        if (items.length > 0 && items[0].dropId) {
        } else if (items.length > 0 && items[0].item && items[0].item.dropId) {
        }

        items.forEach((serverItem: any) => {
            let itemData = serverItem.item || serverItem;
            let slotId = serverItem.slot || serverItem.slotId;

            if (slotId && slotId <= totalSlots) {
                slots[slotId - 1].item = {
                    ...itemData,
                    id: itemData.id || Math.random(),
                    image: itemData.image || itemData.name + '.png',
                    type: itemData.type,
                    durability: itemData.durability || (itemData.metadata && itemData.metadata.durability),
                    dropId: itemData.dropId,
                    metadata: itemData.metadata
                };
            } else {
                const emptySlot = slots.find(s => !s.item);
                if (emptySlot) {
                    emptySlot.item = {
                        ...itemData,
                        id: itemData.id || Math.random(),
                        image: itemData.image || itemData.name + '.png',
                        type: itemData.type,
                        durability: itemData.durability || (itemData.metadata && itemData.metadata.durability),
                        dropId: itemData.dropId,
                        metadata: itemData.metadata
                    };
                }
            }
        });
        return slots;
    };

    const [playerCapacity, setPlayerCapacity] = useState(200);
    const [groundLabel, setGroundLabel] = useState('GROUND');
    const [horseLabel, setHorseLabel] = useState('HORSE INVENTORY');
    const [horseCapacity, setHorseCapacity] = useState(20);
    const [horseSlotsMax, setHorseSlotsMax] = useState(HORSE_SLOTS_COUNT);
    const [money, setMoney] = useState(0);
    const [gold, setGold] = useState(0);
    const [horseType, setHorseType] = useState<string | null>(null);
    const [containerId, setContainerId] = useState<string | null>(null);
    const [playerId, setPlayerId] = useState(0);
    const [permanentItems, setPermanentItems] = useState<string[]>([]);
    const [usableItems, setUsableItems] = useState<string[]>([]);

    const [, setCharId] = useState('');

    const CLOTHING_TYPES = ['hat', 'mask', 'neckwear', 'glove', 'belt', 'pant', 'shirt', 'vest', 'coat', 'poncho', 'boots'];
    const [removedClothes, setRemovedClothes] = useState<string[]>([]);
    const [customButton, setCustomButton] = useState<any>(null);
    const [locales, setLocales] = useState<Locales>(INITIAL_LOCALE);
    const [showClothingMenu, setShowClothingMenu] = useState(false); // Config for menu-2-group visibility

    const toggleCloth = (item: string) => {
        fetchNui('toggleClothing', { item });
        setRemovedClothes(prev => {
            if (prev.includes(item)) return prev.filter(i => i !== item);
            return [...prev, item];
        });
    };

    const handleGlobalClothingToggle = () => {
        const isAllOn = removedClothes.length === 0;
        if (isAllOn) {
            setRemovedClothes(CLOTHING_TYPES);
            fetchNui('toggleBatch', { items: CLOTHING_TYPES });
        } else {
            fetchNui('toggleBatch', { items: removedClothes });
            setRemovedClothes([]);
        }
    };

    useEffect(() => {
        const handleMessage = (event: MessageEvent) => {
            const { action, data, locales: newLocales, showClothingMenu: configShowClothingMenu } = event.data;
            if (action === 'OPEN') {
                setInventoryActive(true);
                if (newLocales) setLocales(newLocales);
                if (configShowClothingMenu !== undefined) setShowClothingMenu(configShowClothingMenu);
            }
            if (action === 'CLOSE') {
                setInventoryActive(false);
                setHorseInventoryActive(false);
                setHorseType(null);
                setContainerId(null);
            }
            if (action === 'UPDATE_DATA') {
                if (data.main) setMainSlots(processServerItems(data.main, INITIAL_SLOTS));
                let hMax = horseSlotsMax;
                if (data.horseSlotsMax) {
                    hMax = data.horseSlotsMax;
                    setHorseSlotsMax(data.horseSlotsMax);
                }
                if (data.horseCapacity) setHorseCapacity(data.horseCapacity);

                if (data.horse) setHorseSlots(processServerItems(data.horse, hMax));
                if (data.ground) setGroundSlots(processServerItems(data.ground, GROUND_SLOTS_COUNT));
                if (data.groundLabel) setGroundLabel(data.groundLabel);
                if (data.horseLabel) {
                    setHorseLabel(data.horseLabel);
                    setHorseInventoryActive(true);
                }
                if (data.money !== undefined) setMoney(data.money);
                if (data.gold !== undefined) setGold(data.gold);
                if (data.id !== undefined) setPlayerId(data.id);
                if (data.charId !== undefined) setCharId(data.charId);
                if (data.permanentItems !== undefined) setPermanentItems(data.permanentItems);
                if (data.customButton !== undefined) setCustomButton(data.customButton);
                if (data.playerCapacity !== undefined) setPlayerCapacity(data.playerCapacity);
                if (data.horseType !== undefined) setHorseType(data.horseType);
                if (data.containerId !== undefined) setContainerId(data.containerId);
                if (data.showClothingMenu !== undefined) setShowClothingMenu(data.showClothingMenu);
                if (data.usableItems !== undefined) setUsableItems(data.usableItems);

            }
        };

        const handleKeyDown = (e: KeyboardEvent) => {
            if (e.key === 'Escape') {
                fetchNui('close');
            }
        };

        window.addEventListener('message', handleMessage);
        window.addEventListener('keydown', handleKeyDown);
        return () => {
            window.removeEventListener('message', handleMessage);
            window.removeEventListener('keydown', handleKeyDown);
        };
    }, []);

    useEffect(() => {
        if (inventoryActive) {
            document.body.classList.add('inventory-open');
        } else {
            document.body.classList.remove('inventory-open');
        }
    }, [inventoryActive]);

    const [mainSlots, setMainSlots] = useState<Slot[]>(() => {
        const slots = generateMockInventory(INITIAL_SLOTS);
        slots[0].item = { id: 1, name: 'apple', label: 'Apple', weight: 0.5, amount: 5, image: 'item_example.png', type: 'food', durability: 100 };
        slots[1].item = { id: 2, name: 'water', label: 'Water Bottle', weight: 1.0, amount: 2, image: 'item_example.png', type: 'drink', durability: 100 };
        return slots;
    });

    const [horseSlots, setHorseSlots] = useState<Slot[]>(() => {
        const slots = generateMockInventory(HORSE_SLOTS_COUNT);
        slots[0].item = { id: 3, name: 'revolver', label: 'Cattleman Revolver', weight: 2.5, amount: 1, image: 'item_example.png', type: 'weapon', durability: 85 };
        return slots;
    });

    const [groundSlots, setGroundSlots] = useState<Slot[]>(() => {
        const slots = generateMockInventory(GROUND_SLOTS_COUNT);
        slots[0].item = { id: 4, name: 'bread', label: 'Bread', weight: 0.2, amount: 3, image: 'item_example.png', type: 'food', durability: 90 };
        return slots;
    });

    const [draggedItem, setDraggedItem] = useState<{ container: 'main' | 'horse' | 'ground', slotId: number, item: Item } | null>(null);
    const dragPreviewRef = React.useRef<HTMLDivElement>(null);
    const lastMousePos = React.useRef<{ x: number, y: number } | null>(null);
    const isDraggingRef = React.useRef(false);

    useEffect(() => {
        if (draggedItem && dragPreviewRef.current && lastMousePos.current) {
            dragPreviewRef.current.style.left = `${lastMousePos.current.x}px`;
            dragPreviewRef.current.style.top = `${lastMousePos.current.y}px`;
            dragPreviewRef.current.style.display = 'flex';
        }
    }, [draggedItem]);

    const [contextMenu, setContextMenu] = useState<{
        visible: boolean;
        x: number;
        y: number;
        item: Item | null;
        amount: number;
        container: 'main' | 'horse' | 'ground' | null;
        slotId: number | null;
    }>({
        visible: false,
        x: 0,
        y: 0,
        item: null,
        amount: 0,
        container: null,
        slotId: null
    });
    const [searchTerm, setSearchTerm] = useState('');
    const [filterType, setFilterType] = useState<'default' | 'asc' | 'desc'>('default');

    const [isFilterOpen, setIsFilterOpen] = useState(false);

    const filterRef = React.useRef<HTMLDivElement>(null);

    useEffect(() => {
        const handleOutside = (e: globalThis.MouseEvent) => {
            setContextMenu(prev => prev.visible ? { ...prev, visible: false } : prev);

            if (filterRef.current && !filterRef.current.contains(e.target as Node)) {
                setIsFilterOpen(false);
            }
        };

        window.addEventListener('mousedown', handleOutside);
        window.addEventListener('contextmenu', handleOutside);
        return () => {
            window.removeEventListener('mousedown', handleOutside);
            window.removeEventListener('contextmenu', handleOutside);
        };
    }, []);

    const handleItemMouseDown = (e: React.MouseEvent, container: 'main' | 'horse' | 'ground', slotId: number, item: Item) => {
        if (item.isShop) return;
        if (e.button !== 0) return;
        e.preventDefault();

        if (contextMenu.visible && contextMenu.item && contextMenu.item.id === item.id) {
            e.stopPropagation();
        }

        if (isDraggingRef.current) return;
        isDraggingRef.current = true;

        let moveAmount = item.amount;

        if (e.shiftKey && item.amount > 1) {
            moveAmount = Math.floor(item.amount / 2);
        }

        const isSplit = contextMenu.visible && contextMenu.item &&
            contextMenu.container === container && contextMenu.slotId === slotId &&
            contextMenu.amount > 0;

        if (isSplit) {
            moveAmount = Math.min(contextMenu.amount, item.amount);
        }

        if (contextMenu.visible) {
            setContextMenu(prev => ({ ...prev, visible: false }));
        }

        const dragItemObj = { ...item, amount: moveAmount };

        setDraggedItem({ container, slotId, item: dragItemObj });

        const startX = e.clientX;
        const startY = e.clientY;
        lastMousePos.current = { x: startX, y: startY };
        let hasMoved = false;

        if (dragPreviewRef.current) {
            dragPreviewRef.current.style.left = `${startX}px`;
            dragPreviewRef.current.style.top = `${startY}px`;
            dragPreviewRef.current.style.display = 'none';
        }

        const handleMouseMove = (mvEvent: globalThis.MouseEvent) => {
            const dist = Math.sqrt(Math.pow(mvEvent.clientX - startX, 2) + Math.pow(mvEvent.clientY - startY, 2));

            if (!hasMoved && dist > 10) {
                hasMoved = true;
                if (dragPreviewRef.current) dragPreviewRef.current.style.display = 'flex';
            }

            if (dragPreviewRef.current && hasMoved) {
                dragPreviewRef.current.style.left = `${mvEvent.clientX}px`;
                dragPreviewRef.current.style.top = `${mvEvent.clientY}px`;
            }
        };

        const handleMouseUp = (upEvent: globalThis.MouseEvent) => {
            isDraggingRef.current = false;

            window.removeEventListener('mousemove', handleMouseMove);
            window.removeEventListener('mouseup', handleMouseUp);

            if (hasMoved) {
                const elements = document.elementsFromPoint(upEvent.clientX, upEvent.clientY);
                const slotElement = elements.find(el => el.hasAttribute('data-slot-id'));

                if (slotElement) {
                    const targetSlotId = parseInt(slotElement.getAttribute('data-slot-id') || '-1');
                    const targetContainer = slotElement.getAttribute('data-container') as 'main' | 'horse' | 'ground';

                    if (targetSlotId !== -1 && targetContainer) {
                        handleDropLogic(container, slotId, dragItemObj, targetContainer, targetSlotId);
                    }
                }
            } else {
                if (upEvent.shiftKey) {
                    handleFastMove(container, slotId, item);
                }
            }

            setDraggedItem(null);
        };

        window.addEventListener('mousemove', handleMouseMove);
        window.addEventListener('mouseup', handleMouseUp);
    };

    const getSlots = (container: string) => {
        if (container === 'main') return mainSlots;
        if (container === 'horse') return horseSlots;
        return groundSlots;
    };

    const handleDropLogic = (sourceContainer: 'main' | 'horse' | 'ground', sourceSlotId: number, item: Item, targetContainer: 'main' | 'horse' | 'ground', targetSlotId: number) => {
        if (sourceContainer === targetContainer && sourceSlotId === targetSlotId) return;

        if (targetContainer === 'horse' && horseType === 'shop') return;

        const sourceSlots = getSlots(sourceContainer);
        const targetSlots = getSlots(targetContainer);

        const sourceIndex = sourceSlots.findIndex(s => s.id === sourceSlotId);
        const targetIndex = targetSlots.findIndex(s => s.id === targetSlotId);

        if (sourceIndex === -1 || !sourceSlots[sourceIndex].item || sourceSlots[sourceIndex].item.id !== item.id) {
            return;
        }

        const targetItem = targetSlots[targetIndex] ? targetSlots[targetIndex].item : null;

        let actionType = 'move';
        let isSwap = false;
        let isMerge = false;

        if (sourceContainer === targetContainer) {
            if (targetItem) {
                if (targetItem.name === item.name) {
                    isMerge = true;
                } else if (item.amount === sourceSlots[sourceIndex].item!.amount) {
                    isSwap = true;
                    actionType = 'swap';
                } else {
                    return;
                }
            } else {
            }
        } else {
            if (targetItem) {
                if (targetItem.name === item.name) {
                    isMerge = true;
                } else {
                    if (item.amount === sourceSlots[sourceIndex].item!.amount) {
                        return;
                    }
                    return;
                }
            }
        }

        fetchNui('moveItem', {
            item: { ...item, dropId: item.dropId },
            from: { container: sourceContainer, slot: sourceSlotId },
            to: { container: targetContainer, slot: targetSlotId },
            type: actionType
        });

        const getSetter = (container: string) => {
            if (container === 'main') return setMainSlots;
            if (container === 'horse') return setHorseSlots;
            return setGroundSlots;
        };
        const setSource = getSetter(sourceContainer);
        const setTarget = getSetter(targetContainer);
        setSource(prev => {
            const next = [...prev];
            const sIdx = next.findIndex(s => s.id === sourceSlotId);
            if (sIdx === -1 || !next[sIdx].item) return prev;

            if (isSwap && sourceContainer === targetContainer) {
                const tIdx = next.findIndex(s => s.id === targetSlotId);
                const temp = next[sIdx].item;
                next[sIdx].item = next[tIdx].item;
                next[tIdx].item = temp;
                return next;
            }

            next[sIdx] = { ...next[sIdx] };

            if (next[sIdx].item) {
                next[sIdx].item = { ...next[sIdx].item };

                if (item.amount >= next[sIdx].item.amount) {
                    next[sIdx].item = null;
                } else {
                    next[sIdx].item.amount -= item.amount;
                }
            }

            if (sourceContainer === targetContainer && !isSwap) {
                const tIdx = next.findIndex(s => s.id === targetSlotId);
                if (tIdx !== -1) {
                    next[tIdx] = { ...next[tIdx] };

                    if (isMerge) {
                        if (next[tIdx].item) {
                            next[tIdx].item = { ...next[tIdx].item };
                            next[tIdx].item.amount += item.amount;
                        }
                    } else if (!next[tIdx].item) {
                        next[tIdx].item = { ...item, amount: item.amount };
                    }
                }
            }

            return next;
        });

        if (sourceContainer !== targetContainer) {
            setTarget(prev => {
                const next = [...prev];
                const tIdx = next.findIndex(s => s.id === targetSlotId);
                if (tIdx === -1) return prev;

                next[tIdx] = { ...next[tIdx] };

                if (isMerge) {
                    if (next[tIdx].item) {
                        next[tIdx].item = { ...next[tIdx].item };
                        next[tIdx].item.amount += item.amount;
                    }
                } else if (!next[tIdx].item) {
                    next[tIdx].item = { ...item, amount: item.amount };
                }
                return next;
            });
        }

    };

    const handleRightClick = (e: MouseEvent, container: 'main' | 'horse' | 'ground', slotId: number, item: Item | null) => {
        if (!item) return;
        e.preventDefault();
        e.stopPropagation();
        setContextMenu({
            visible: true,
            x: e.clientX,
            y: e.clientY,
            item: item,
            amount: 0,
            container: container,
            slotId: slotId
        });
    };

    const updateAmount = (newAmount: number) => {
        if (!contextMenu.item) return;
        const validAmount = Math.max(0, Math.min(newAmount, contextMenu.item.amount));
        setContextMenu(prev => ({ ...prev, amount: validAmount }));
    };

    const handleFilterToggle = (e: React.MouseEvent) => {
        e.stopPropagation();
        setIsFilterOpen(!isFilterOpen);
    };

    const handleFilterSelect = (e: React.MouseEvent, type: 'default' | 'asc' | 'desc') => {
        e.stopPropagation();
        setFilterType(type);
        setIsFilterOpen(false);
    };

    const getProcessedSlots = (slots: Slot[]) => {
        let displaySlots = [...slots];
        let itemsOnly = displaySlots.filter(s => s.item !== null) as { id: number, item: Item }[];
        let emptySlots = displaySlots.filter(s => s.item === null);

        if (searchTerm) {
            itemsOnly = itemsOnly.filter(s => s.item.label.toLowerCase().includes(searchTerm.toLowerCase()));
        }

        if (filterType === 'asc') {
            itemsOnly.sort((a, b) => a.item.label.localeCompare(b.item.label));
        } else if (filterType === 'desc') {
            itemsOnly.sort((a, b) => b.item.label.localeCompare(a.item.label));
        }

        if (filterType !== 'default' || searchTerm) {
            return [...itemsOnly, ...emptySlots];
        }

        return slots;
    };

    const handleUseItem = (item: Item) => {
        if (item.name && (item.name.toUpperCase().includes("WEAPON_") || item.type === "item_weapon")) {
            fetchNui('useItem', { item });
        } else {
            fetchNui('useItem', { item, amount: 1 });
        }
    };

    const handleFastMove = (sourceContainer: 'main' | 'horse' | 'ground', slotId: number, item: Item) => {
        let targetContainer: 'main' | 'horse' | 'ground' = 'main';
        let targetSlots: Slot[] = [];

        if (sourceContainer === 'main') {
            if (horseInventoryActive) {
                targetContainer = 'horse';
                targetSlots = horseSlots;
            } else {
                targetContainer = 'ground';
                targetSlots = groundSlots;
            }
        } else {
            targetContainer = 'main';
            targetSlots = mainSlots;
        }

        if (sourceContainer === targetContainer) return;

        if (targetContainer === 'horse' && horseType === 'shop') return;

        const emptySlot = targetSlots.find(s => !s.item);
        if (emptySlot) {
            handleDropLogic(sourceContainer, slotId, item, targetContainer, emptySlot.id);
        }
    };

    const handleCustomButtonClick = () => {
        if (!customButton) return;
        fetchNui('customButtonClick', { config: customButton });
    };

    const displayedMainSlots = getProcessedSlots(mainSlots);

    const renderSlot = (slot: Slot, container: 'main' | 'horse' | 'ground') => (
        <div
            key={slot.id}
            className={slot.item ? "slot" : "slot-empty"}
            data-slot-id={slot.id}
            data-container={container}
            onDoubleClick={() => slot.item && handleUseItem(slot.item)}
            onMouseDown={(e) => {
                if (!slot.item) return;
                handleItemMouseDown(e, container, slot.id, slot.item);
            }}
            onContextMenu={(e) => {
                e.preventDefault();
                if (!slot.item) return;
                handleRightClick(e, container, slot.id, slot.item);
            }}
        >
            {slot.item && (
                <>
                    <div className="item-details">
                        <div className="item-weight">
                            {!slot.item.isShop && (
                                <>
                                    <div className="item-weight-text">{slot.item.weight}</div>
                                    <div className="item-weight-icon">g</div>
                                </>
                            )}

                        </div>
                        <div className="item-amount">
                            <div className="item-amount-text">
                                {slot.item.isShop ? slot.item.price?.toFixed(2) : (typeof slot.item.amount === 'number' && slot.item.amount % 1 !== 0 ? slot.item.amount.toFixed(2) : slot.item.amount)}
                            </div>
                            <div className="item-amount-icon">
                                {slot.item.isShop ? '$' : 'x'}
                            </div>
                        </div>
                    </div>
                    <div className="item">
                        <div style={{ backgroundImage: `url("./items/${slot.item.image}")` }}></div>
                    </div>
                    <div className="item-name">{slot.item.label}</div>
                </>
            )}
        </div>
    );

    return (
        <div className={`inventory-main ${inventoryActive ? 'active' : ''}`}>
            {draggedItem && (
                <div
                    ref={dragPreviewRef}
                    className="drag-preview"
                    style={{
                        position: 'fixed',
                        left: 0,
                        top: 0,
                        pointerEvents: 'none',
                        zIndex: 9999,
                        transform: 'translate(-50%, -50%)'
                    }}
                >
                    <div className="item" style={{ width: '3.6458vw', height: '3.6458vw', backgroundImage: `url("./img/item_bg_1.png")`, backgroundSize: '100% 100%', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                        <div style={{ backgroundImage: `url("./items/${draggedItem.item.image}")`, width: '1.8229vw', height: '1.8229vw', backgroundSize: '100% 100%' }}></div>
                    </div>
                </div>
            )}

            <div className="inventory">
                <div className="label">
                    <div className="label-icon"><div></div></div>
                    <div className="label-texts">
                        <div className="label-title">{locales.inventoryTitle}</div>
                        <div className="label-desc">{locales.inventoryDesc}</div>
                    </div>
                </div>
                <div className="details">
                    <div className="money">
                        <div className="money-icon"></div>
                        <div className="money-currency">
                            <div className="currency-icon">$</div>
                            <div className="currency">{money.toFixed(2)}</div>
                        </div>
                    </div>
                    <div className="gold">
                        <div className="gold-icon"></div>
                        <div className="gold-currency">{gold.toFixed(2)}</div>
                    </div>
                    <div className="id">
                        <div className="id-icon">{locales.idLabel}</div>
                        <div className="id-text">
                            {/* <div className="id-text-1">{charId}</div> */}
                            <div className="id-text-2">{playerId}</div>
                        </div>
                    </div>
                </div>
                <div className="filter-group">
                    <div className="search">
                        <div className="search-icon"></div>
                        <div className="search-text">
                            <input
                                type="text"
                                placeholder={locales.searchPlaceholder}
                                value={searchTerm}
                                onChange={(e) => setSearchTerm(e.target.value)}
                            />
                        </div>
                    </div>
                    <div
                        className="filter"
                        ref={filterRef}
                        onClick={handleFilterToggle}
                        style={{ cursor: 'pointer', position: 'relative' }}
                    >
                        <div className="filter-text">
                            {filterType === 'default' ? locales.filterLabel : filterType === 'asc' ? locales.filterAZ : locales.filterZA}
                        </div>
                        <div className="filter-icon"></div>
                        {isFilterOpen && (
                            <div className="filter-options">
                                <div className="filter-option" onClick={(e) => handleFilterSelect(e, 'default')}>{locales.filterDefault}</div>
                                <div className="filter-option" onClick={(e) => handleFilterSelect(e, 'asc')}>{locales.filterAZ}</div>
                                <div className="filter-option" onClick={(e) => handleFilterSelect(e, 'desc')}>{locales.filterZA}</div>
                            </div>
                        )}
                    </div>
                </div>
                <div className="slot-group">
                    <div className="slot-label">
                        <div className="weight-title">{locales.weightTitle}</div>
                        <div className="weight-amount-group">
                            <div className="weight-amount-current">
                                {mainSlots.reduce((acc, slot) => acc + (slot.item ? slot.item.weight * slot.item.amount : 0), 0).toFixed(1)}
                            </div>
                            <div className="weight-amount">/{playerCapacity}</div>
                        </div>
                    </div>
                    <div className="slots">
                        {displayedMainSlots.map(slot => renderSlot(slot, 'main'))}
                    </div>
                </div>
            </div>

            {contextMenu.visible && contextMenu.item && (
                <div
                    className="item-action"
                    style={{
                        display: 'flex',
                        position: 'fixed',
                        left: contextMenu.x,
                        top: contextMenu.y,
                        zIndex: 1000,
                        marginLeft: 0
                    }}
                    onClick={(e) => e.stopPropagation()}
                    onMouseDown={(e) => e.stopPropagation()}
                >
                    <div className="item-detail-group">
                        <div className="item-detail-title">{contextMenu.item.label}</div>
                        <div className="item-detail-desc">Item Type: {contextMenu.item.type}</div>

                    </div>




                    {contextMenu.container === 'main' && (
                        <MetadataContainer>
                            {contextMenu.item.metadata && Object.keys(contextMenu.item.metadata).length > 0 ? (
                                Object.entries(contextMenu.item.metadata).map(([key, value]) => (
                                    <div className="metadata-row" key={key}>
                                        <div className="item-durability-title">{key}:</div>
                                        <div className="item-durability-rate-group">
                                            <div className="item-druability-rate-icon"></div>
                                            <div className="item-durability-rate">{String(value)}</div>
                                        </div>
                                    </div>
                                ))
                            ) : (
                                <div className="item-durability-title">{locales.noMetadata}</div>
                            )}
                        </MetadataContainer>
                    )}
                    <div className="item-amount-group">
                        <div className="item-amount-tittle">{locales.amountTitle}</div>
                        <div className="item-amount-group-2" style={contextMenu.container !== 'main' ? { marginTop: "2vh" } : {}}>
                            <div className="min" onClick={() => updateAmount(contextMenu.amount - 1)}></div>
                            <div className="amount">
                                <input
                                    type="number"
                                    placeholder="0"
                                    value={contextMenu.amount.toString()}
                                    onChange={(e) => {
                                        const isMoney = contextMenu.item && (contextMenu.item.type === 'item_money' || contextMenu.item.type === 'item_account' || contextMenu.item.name === 'money');
                                        const val = e.target.value;
                                        if (isMoney) {
                                            updateAmount(Number(val) || 0)
                                        } else {
                                            updateAmount(parseInt(val) || 0)
                                        }
                                    }}
                                />
                            </div>
                            <div className="add" onClick={() => updateAmount(contextMenu.amount + 1)}></div>
                        </div>
                    </div>

                    {contextMenu.item.isShop ? (
                        <div
                            className="buy"
                            onClick={() => {
                                if (!contextMenu.item) return;
                                fetchNui('buyItem', {
                                    item: contextMenu.item,
                                    amount: contextMenu.amount === 0 ? 1 : contextMenu.amount,
                                    containerId: containerId
                                });
                                setContextMenu({ ...contextMenu, visible: false });
                            }}
                        >
                            <div className="use-icon"></div>
                            <div className="use-tittle">{locales.buyItem}</div>
                        </div>
                    ) : (
                        contextMenu.container === 'main' && (
                            <>
                                {contextMenu.item && (
                                    contextMenu.item.type === 'item_weapon' ||
                                    contextMenu.item.name?.toUpperCase().includes('WEAPON_') ||
                                    usableItems.includes(contextMenu.item.name)
                                ) && (
                                        <div
                                            className="use"
                                            onClick={() => {
                                                if (!contextMenu.item) return;
                                                fetchNui('useItem', { item: contextMenu.item, amount: contextMenu.amount });
                                                setContextMenu({ ...contextMenu, visible: false });
                                            }}
                                        >
                                            <div className="use-icon"></div>
                                            <div className="use-tittle">{locales.useItem}</div>
                                        </div>
                                    )}
                                <div
                                    className={`give ${contextMenu.item && permanentItems.includes(contextMenu.item.name) ? 'disabled' : ''}`}
                                    style={contextMenu.item && !(
                                        contextMenu.item.type === 'item_weapon' ||
                                        contextMenu.item.name?.toUpperCase().includes('WEAPON_') ||
                                        usableItems.includes(contextMenu.item.name)
                                    ) ? { marginTop: '0.65vw' } : {}}
                                    onClick={() => {
                                        if (!contextMenu.item || permanentItems.includes(contextMenu.item.name)) return;
                                        fetchNui('giveItem', { item: contextMenu.item, amount: contextMenu.amount });
                                        setContextMenu({ ...contextMenu, visible: false });
                                    }}
                                >
                                    <div className="give-icon"></div>
                                    <div className="give-tittle">{locales.giveItem}</div>
                                </div>
                            </>
                        )
                    )}
                </div>
            )
            }


            <div className="menus">
                <div className="menu-2-group" style={!showClothingMenu ? { display: "none" } : {}}>
                    <div className="clothes-menu" >
                        <div className="hat-icon" onClick={() => toggleCloth('hat')}><div className="hat"></div></div>
                        <div className="mask-icon" onClick={() => toggleCloth('mask')}><div className="mask"></div></div>
                        <div className="necklace-icon" onClick={() => toggleCloth('neckwear')}><div className="necklace"></div></div>
                        <div className="necktie-icon" onClick={() => toggleCloth('neckwear')}><div className="necktie"></div></div>
                        <div className="gloves-icon" onClick={() => toggleCloth('glove')}><div className="gloves"></div></div>
                        <div className="belt-icon" onClick={() => toggleCloth('belt')}><div className="belt"></div></div>
                    </div>
                    <div className="clothes-menu">
                        <div className="tshirt-icon" onClick={() => toggleCloth('shirt')}><div className="tshirt"></div></div>
                        <div className="vest-icon" onClick={() => toggleCloth('vest')}><div className="vest"></div></div>
                        <div className="coat-icon" onClick={() => toggleCloth('coat')}><div className="coat"></div></div>
                        <div className="poncho-icon" onClick={() => toggleCloth('poncho')}><div className="poncho"></div></div>
                        <div className="pant-icon" onClick={() => toggleCloth('pant')}><div className="pant"></div></div>
                        <div className="shoes-icon" onClick={() => toggleCloth('boots')}><div className="shoes"></div></div>
                    </div>
                </div>
                <div className="menu-1" style={!showClothingMenu ? { marginTop: "115.0417%" } : {}}>
                    <div className={`menu-1-button ${!showClothingMenu ? 'disabled' : ''}`} onClick={() => { if (showClothingMenu) handleGlobalClothingToggle() }}>
                        <div className="button-icon"></div>
                        <div className="button-tittle">
                            {removedClothes.length === 0 ? locales.takeOffClothes : locales.wearClothes}
                        </div>
                    </div>
                    <div className="menu-2-button" onClick={() => { setInventoryActive(false); fetchNui('close') }}>
                        <div className="button-icon-2"></div>
                        <div className="button-tittle-2">{locales.exitInventory}</div>
                    </div>
                    {customButton && customButton.enabled && (
                        <div className="menu-3-button" onClick={handleCustomButtonClick}>
                            <div className={customButton.icon || "button-icon-3"}></div>
                            <div className="button-tittle-3">{customButton.label || locales.customButton}</div>
                        </div>
                    )}
                </div>
            </div>

            <div className={`other-inventorys ${!horseInventoryActive ? 'ground-only-layout' : ''}`}>
                {horseInventoryActive && (
                <div
                    className="horse-inventory"
                    style={{
                        height: 'min(24.4792vw, 46vh)'
                    }}
>                        <div className="label">
                            <div className="label-icon">
                                <div className={
                                    horseType === 'stash' ? 'stash-icon' :
                                        horseType === 'shop' ? 'shop-icon' :
                                            (horseType === 'player' ? 'player-icon' : 'horse-icon')
                                } />
                            </div>
                            <div className="label-texts">
                                <div className="label-title">{horseLabel}</div>
                                <div className="label-desc">{locales.inventoryDesc}</div>
                            </div>
                        </div>
                        <div className="slot-group">
                            <div className="slot-label">
                                <div className="weight-title">{locales.weightTitle}</div>
                                <div className="weight-amount-group">
                                    <div className="weight-amount-current">
                                        {horseSlots.reduce((acc, slot) => acc + (slot.item ? slot.item.weight * slot.item.amount : 0), 0).toFixed(1)}
                                    </div>
                                    <div className="weight-amount">/{horseCapacity}</div>
                                </div>
                            </div>
                            <div
                                className="horse-slots"
                                style={{
                                    maxHeight: 'min(15.3646vw, 29vh)'
                                }}
>                                {horseSlots.map(slot => renderSlot(slot, 'horse'))}
                            </div>
                        </div>
                    </div>
                )}
                    <div
                        className={`ground-inventory ${!horseInventoryActive ? 'ground-only' : ''}`}
                        style={
                            !horseInventoryActive
                                ? {
                                      height: 'min(39vw, 72vh)',
                                      width: '25vw',
                                      backgroundImage: 'url("./img/full_size_bg.png")'
                                  }
                                : { height: 'min(16.6667vw, 31vh)' }
                        }
                    >
                    <div className="label">
                        <div className="label-icon"><div className="ground-icon" /></div>
                        <div className="label-texts">
                            <div className="label-title">{groundLabel}</div>
                            <div className="label-desc">{locales.inventoryDesc}</div>
                        </div>
                    </div>
                    <div className="slot-group">
                        <div className="slot-label">
                            <div className="weight-title">{locales.weightTitle}</div>
                            <div className="weight-amount-group">
                                <div className="weight-amount-current">
                                    {groundSlots.reduce((acc, slot) => acc + (slot.item ? slot.item.weight * slot.item.amount : 0), 0).toFixed(1)}
                                </div>
                                <div className="weight-amount">/200</div>
                            </div>
                        </div>
                            <div
                                className={`ground-slots ${!horseInventoryActive ? 'ground-only-slots' : ''}`}
                                style={
                                    !horseInventoryActive
                                        ? { maxHeight: 'min(29vw, 56vh)' }
                                        : { maxHeight: 'min(7.5521vw, 14vh)' }
                                }
                            >
                            {groundSlots.map(slot => renderSlot(slot, 'ground'))}
                        </div>
                    </div>
                </div>
            </div>
        </div >
    )
}

export default App
