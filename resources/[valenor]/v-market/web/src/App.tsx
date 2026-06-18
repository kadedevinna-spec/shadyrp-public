import { useState, useEffect } from 'react'
import './App.css'

interface Item {
  id: number
  itemName: string
  itemLabel?: string
  category: string
  description: string
  price: number
  weaponId?: number
  maxQuantityinStore: number
  imageUrl: string
  metadata?: any
}

interface SellItem {
  itemName: string
  itemLabel?: string
  price: number
  imageUrl: string
}

interface CartItem {
  id: number
  itemName: string
  itemLabel?: string
  category: string
  description: string
  price: number
  weaponId?: number
  imageUrl: string
  quantity: number
  metadata?: any
}

interface Lang {
  market: string
  market_description: string
  market_blip: string
  market_blip_description: string
  market_access_denied: string
  market_grade_required: string
  market_not_found: string
  not_enough_money: string
  invalid_amount: string
  item_added_to_market: string
  item_updated_successfully: string
  market_withdraw_cash_required: string
  market_details_updated_successfully: string
  not_enough_items: string
  item_out_of_stock: string
  returned_item: string
  could_not_return_item: string
  added_item_to_market: string
  not_enough_items_in_inventory: string
  item_removed_from_market: string
  not_enough_cash_in_market_case: string
  withdrew_cash_from_market_case: string
  purchase_successful: string
  purchase_limit_reached: string
  added_to_cart: string
  add_to_cart: string
  your_cart_is_empty: string
  your_cart_title: string
  money: string
  back_products: string
  total_price: string
  processing: string
  pay_via_cash: string
  back_market: string
  merchant_logo: string
  merchant_logo_description: string
  merchant_name_title: string
  merchant_name_title_description: string
  merchant_description_title: string
  merchant_description_title_description: string
  case_title: string
  case_description: string
  case_amount_title: string
  amount_title: string
  withdraw_cash: string
  no_permission: string
  add_item: string
  back: string
  save: string
  item_name: string
  price: string
  category: string
  cancel: string
  confirm: string
  food_category: string
  description: string
  search_placeholder: string
  management: string
  select_category: string
  error_valid_number: string
  error_greater_than: string
  error_select_category: string
  error_negative_number: string
  sell_tab: string
  sell_title: string
  sell_description: string
  sold_item: string
  sell_error: string
  error_occurred: string
  connection_error: string
  max_available: string
  weapon_quantity_error: string
  error_adding_item: string
  update_failed: string
  successfully_saved: string
  failed_to_save: string
  purchase_failed: string
  sell_button: string
  no_sellable_items: string
  enter_url_placeholder: string
  enter_name_placeholder: string
  enter_desc_placeholder: string
  default_item_description: string
}

function App() {
  let firstOpen = '';
  const [imageServer, setImageServer] = useState<string>('')
  const [lang, setLang] = useState<Lang>({
    market: 'Market',
    market_description: 'Welcome to the market',
    market_blip: 'Market',
    market_blip_description: 'Welcome to the market',
    market_access_denied: 'You don\'t have access to this market!',
    market_grade_required: 'You don\'t have the required grade!',
    market_not_found: 'Market not found!',
    not_enough_money: 'You don\'t have enough money!',
    invalid_amount: 'Invalid amount!',
    item_added_to_market: 'Item added to market successfully!',
    item_updated_successfully: 'Item updated successfully!',
    market_withdraw_cash_required: 'You don\'t have permission to withdraw cash!',
    market_details_updated_successfully: 'Market details updated successfully!',
    not_enough_items: 'Not enough items in market! Available: {maxQuantityinStore}, Requested: {quantity}',
    item_out_of_stock: 'Item {itemName} is now out of stock and removed from market!',
    returned_item: 'Returned {quantityToReturn} {itemName} to your inventory!',
    could_not_return_item: 'Could not return {quantityToReturn} {itemName} - inventory full!',
    added_item_to_market: 'Added {quantityToAdd} {itemName} to market from your inventory!',
    not_enough_items_in_inventory: 'Not enough {itemName} in your inventory! You have {playerItemCount}, need {quantityToAdd}',
    item_removed_from_market: 'Item {itemName} removed from market (quantity = 0)',
    not_enough_cash_in_market_case: 'Not enough cash in market case! Available: {case}',
    withdrew_cash_from_market_case: 'Withdrew {amount} from market case!',
    purchase_successful: 'Purchase successful! Total: {totalCost}',
    purchase_limit_reached: 'You can purchase at most {Config.MarketLimit} items per transaction!',
    added_to_cart: 'Added to cart',
    add_to_cart: 'Add to cart',
    your_cart_is_empty: 'Your cart is empty',
    your_cart_title: 'Your Cart',
    money: 'Money',
    back_products: 'Back Products',
    total_price: 'Total Price',
    processing: 'Processing...',
    pay_via_cash: 'Pay Via Cash',
    back_market: 'Back Market',
    merchant_logo: 'Merchant Logo',
    merchant_logo_description: 'Merchant Logo Description',
    merchant_name_title: 'Merchant Name',
    merchant_name_title_description: 'Merchant Name Description',
    merchant_description_title: 'Merchant Description',
    merchant_description_title_description: 'Merchant Description Description',
    case_title: 'Case',
    case_description: 'Case Description',
    case_amount_title: 'Case Amount',
    amount_title: 'Amount',
    withdraw_cash: 'Withdraw Cash',
    no_permission: 'No Permission',
    add_item: 'Add Item',
    back: 'Back',
    save: 'Save',
    item_name: 'Item Name',
    price: 'Price',
    category: 'Category',
    cancel: 'Cancel',
    confirm: 'Confirm',
    food_category: 'Food',
    description: 'Item Description.',
    search_placeholder: 'Search...',
    management: 'Management',
    select_category: 'Select Category',
    error_valid_number: 'Please enter a valid amount',
    error_greater_than: 'Number must be greater than 0!',
    error_select_category: 'Please select a category!',
    error_negative_number: 'Number cannot be negative!',
    sell_tab: 'Sell Items',
    sell_title: 'Sell your items',
    sell_description: 'Select items to sell to the market.',
    sold_item: 'You sold {quantity}x {itemName} for ${totalPrice}!',
    sell_error: 'Could not sell item!',
    error_occurred: 'An error occurred!',
    connection_error: 'Connection error!',
    max_available: 'Max available: {max}',
    weapon_quantity_error: '1 Amount only for weapons!',
    error_adding_item: 'Error adding item!',
    update_failed: 'Update failed!',
    successfully_saved: 'Successfully saved!',
    failed_to_save: 'Failed to save!',
    purchase_failed: 'Purchase failed!',
    sell_button: 'Sell',
    no_sellable_items: '(No sellable items)',
    enter_url_placeholder: 'Enter a url...',
    enter_name_placeholder: 'Enter a name...',
    enter_desc_placeholder: 'Enter a desc...',
    default_item_description: 'Lorem ipsum dolor sit amet.',
  })
  const [marketId, setMarketId] = useState<number>(0)
  const [customMarketCategory, setcustomMarketCategory] = useState<'Saloon' | 'Gunsmith'>('Saloon')
  const [activeCategory, setActiveCategory] = useState<string>('All')
  const [marketName, setMarketName] = useState<string>(lang.market)
  const [marketDescription, setMarketDescription] = useState<string>(lang.market_description)
  const [cartItems, setCartItems] = useState<CartItem[]>([])
  const [view, setView] = useState<'market' | 'cart' | 'custom-market' | 'custom-marketbasket' | 'custom-marketmanagement' | 'sell'>('market')
  const [searchQuery, setSearchQuery] = useState<string>('')

  const [marketIcon, setMarketIcon] = useState<string>('')
  const [customMarketName, setCustomMarketName] = useState<string>(lang.market)
  const [customMarketDescription, setCustomMarketDescription] = useState<string>(lang.market_description)

  const getItemCategories = () => {
    if (customMarketCategory === "Saloon") {
      return ['Food', 'Drink'] as const
    } else if (customMarketCategory === "Gunsmith") {
      return ['Weapon', 'Ammo', 'Materials'] as const
    } else {
      return ['Food', 'Drink', 'Health', 'Tools', 'Weapon', 'Ammo', 'Materials'] as const
    }
  }

  const ITEM_CATEGORIES = getItemCategories()

  const [isMenuOpen, setIsMenuOpen] = useState<boolean>(false)

  const [isPurchasing, setIsPurchasing] = useState<boolean>(false)
  const [playerMoney, setPlayerMoney] = useState<number>(100)
  const [marketCase, setMarketCase] = useState<number>(100)
  const [withdrawAmount, setWithdrawAmount] = useState<number>(0)
  const [isAccessManagementMenu, setAccessManagementMenu] = useState<boolean>(false)
  const [isEditOrAddMenuActive, setEditOrAddMenuActive] = useState<boolean>(false)
  const [isDropdownOpen, setIsDropdownOpen] = useState<boolean>(false)
  const [selectedCategory, setSelectedCategory] = useState<string>(lang.select_category)
  const [errorMessage, setErrorMessage] = useState<string>('')
  const [selectedItem, setSelectedItem] = useState<Item | null>(null)
  const [editPrice, setEditPrice] = useState<number>(0)
  const [editQuantity, setEditQuantity] = useState<number>(0)
  const [inventoryItems, setInventoryItems] = useState<Item[]>([])
  const [isInventoryMode, setIsInventoryMode] = useState<boolean>(false)
  const [isExistingInMarket, setIsExistingInMarket] = useState<boolean>(false)
  const [canWithdraw, setCanWithdraw] = useState<boolean>(false)
  const [framework, setFramework] = useState<string>('vorp')
  const [sellItems, setSellItems] = useState<SellItem[]>([])

  const [items, setItems] = useState<Item[]>([
    {
      id: 1,
      itemName: "Cooked Meat",
      itemLabel: "Cooked Meat",
      category: "Food",
      description: "Lorem ipsum dolor consectetur.",
      price: 100,
      maxQuantityinStore: 50,
      imageUrl: "./src/img/example_item.png"
    },
    {
      id: 2,
      itemName: "Health Potion",
      itemLabel: "Health Potion",
      category: "Health",
      description: "Restores health points.",
      price: 50,
      maxQuantityinStore: 50,
      imageUrl: "./src/img/example_item.png"
    },
    {
      id: 3,
      itemName: "Hammer",
      itemLabel: "Hammer",
      category: "Tools",
      description: "A sturdy hammer for construction.",
      price: 200,
      maxQuantityinStore: 50,
      imageUrl: "./src/img/example_item.png"
    },
    {
      id: 4,
      itemName: "Bread",
      itemLabel: "Bread",
      category: "Food",
      description: "Fresh baked bread.",
      price: 25,
      maxQuantityinStore: 50,
      imageUrl: "./src/img/example_item.png"
    },
    {
      id: 5,
      itemName: "Bandage",
      itemLabel: "Bandage",
      category: "Health",
      description: "Basic medical supplies.",
      price: 15,
      maxQuantityinStore: 50,
      imageUrl: "./src/img/example_item.png"
    },
    {
      id: 6,
      itemName: "Saw",
      itemLabel: "Saw",
      category: "Tools",
      description: "Cutting tool for wood.",
      price: 150,
      maxQuantityinStore: 50,
      imageUrl: "./src/img/example_item.png"
    },
    {
      id: 7,
      itemName: "Apple",
      itemLabel: "Apple",
      category: "Food",
      description: "Fresh red apple.",
      price: 10,
      maxQuantityinStore: 50,
      imageUrl: "./src/img/example_item.png"
    },
  ])

  {/*
    npm run build etdikden sonra index html "/assets" -> "./assets" olması gerek 
    css de "/assets" ile ilgili tüm kodlar "." diye değiştirilmeli
  */}

  const filteredItems = (items || []).filter(item => {
    const matchesCategory = activeCategory === 'All' || item.category === activeCategory
    const matchesSearch = searchQuery === '' ||
      (item.itemLabel || item.itemName).toLowerCase().includes(searchQuery.toLowerCase()) ||
      item.description.toLowerCase().includes(searchQuery.toLowerCase())
    return matchesCategory && matchesSearch
  })

  const handleCategoryClick = (category: string) => setActiveCategory(category)

  const handleSearchChange = (event: React.ChangeEvent<HTMLInputElement>) => setSearchQuery(event.target.value)

  const handleIconChange = (event: React.ChangeEvent<HTMLInputElement>) => setMarketIcon(event.target.value)
  const handleNameChange = (event: React.ChangeEvent<HTMLInputElement>) => setCustomMarketName(event.target.value)
  const handleDescriptionChange = (event: React.ChangeEvent<HTMLInputElement>) => setCustomMarketDescription(event.target.value)

  const handleWithdrawAmountChange = (event: React.ChangeEvent<HTMLInputElement>) => setWithdrawAmount(event.target.value === '' ? 0 : Number(event.target.value))

  const handleWithdrawAmountBlur = () => {
    if (withdrawAmount > marketCase) {
      setWithdrawAmount(marketCase)
    }
  }

  const handleWithdrawAmountFocus = (event: React.FocusEvent<HTMLInputElement>) => {
    event.target.select()
  }

  const handleWithdrawCash = async () => {
    if (withdrawAmount <= 0) {
      setErrorMessage(lang.error_valid_number)
      setTimeout(() => setErrorMessage(''), 3000)
      return
    }

    if (withdrawAmount > marketCase) {
      setErrorMessage(lang.not_enough_cash_in_market_case)
      setTimeout(() => setErrorMessage(''), 3000)
      return
    }

    const resourceName = "v-market"
    try {
      const response = await fetch(`https://${resourceName}/withdrawCash`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
          marketId: marketId,
          amount: withdrawAmount
        }),
      })
      const result = await response.json()
      if (result === 'ok') {
        setWithdrawAmount(0)
      } else {
        setErrorMessage(lang.error_occurred)
        setTimeout(() => setErrorMessage(''), 3000)
      }
    } catch (error) {
      setErrorMessage(lang.connection_error)
      setTimeout(() => setErrorMessage(''), 3000)
    }
  }

  const handleDropdownToggle = () => {
    setIsDropdownOpen(!isDropdownOpen)
  }

  const handleCategorySelect = (category: string) => {
    setSelectedCategory(category)
    setIsDropdownOpen(false)
  }

  const isWeapon = (itemName: string) => {
    return itemName && itemName.toUpperCase().startsWith('WEAPON_')
  }

  const handleItemClick = (item: Item) => {
    setSelectedItem(item)
    if (isInventoryMode) {
      const isWeaponItem = isWeapon(item.itemName)

      const existing = (items || []).find(m => {
        if (isWeaponItem) {
          return m.itemName === item.itemName && m.weaponId === item.weaponId
        } else {
          return m.itemName === item.itemName
        }
      })

      const maxQuantity = isWeaponItem ? 1 : item.maxQuantityinStore

      if (existing) {
        setIsExistingInMarket(true)
        setEditPrice(existing.price)
        setEditQuantity(isWeaponItem ? 1 : maxQuantity)
        setSelectedCategory(existing.category)
      } else {
        setIsExistingInMarket(false)
        setEditPrice(0)
        setEditQuantity(isWeaponItem ? 1 : maxQuantity)
        setSelectedCategory(lang.select_category)
      }
    } else {
      setEditPrice(item.price)
      setEditQuantity(item.maxQuantityinStore)
      setSelectedCategory(item.category)
    }
    setEditOrAddMenuActive(true)
  }

  const handleSaveItem = async () => {
    if (!selectedItem) return
    if (isInventoryMode) {
      const isWeaponItem = isWeapon(selectedItem.itemName)
      const maxAvailable = isWeaponItem ? 1 : selectedItem.maxQuantityinStore

      if (editQuantity <= 0) {
        setErrorMessage(lang.error_greater_than)
        setTimeout(() => setErrorMessage(''), 3000)
        return
      }

      if (editQuantity > maxAvailable) {
        setErrorMessage(lang.max_available.replace('{max}', maxAvailable.toString()))
        setTimeout(() => setErrorMessage(''), 3000)
        return
      }

      if (isWeaponItem && editQuantity > 1) {
        setErrorMessage(lang.weapon_quantity_error)
        setTimeout(() => setErrorMessage(''), 3000)
        return
      }

      if (editPrice <= 0) {
        setErrorMessage(lang.error_greater_than)
        setTimeout(() => setErrorMessage(''), 3000)
        return
      }
      if (selectedCategory === lang.select_category) {
        setErrorMessage(lang.error_select_category)
        setTimeout(() => setErrorMessage(''), 3000)
        return
      }
      const newItem: Item = {
        ...selectedItem,
        price: editPrice,
        maxQuantityinStore: editQuantity,
        category: selectedCategory
      }
      const resourceName = "v-market"
      try {
        const response = await fetch(`https://${resourceName}/addItemToMarket`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({
            marketId: marketId,
            item: newItem
          }),
        })
        const result = await response.json()
        if (result === 'ok') {
          setInventoryItems(prevInventory => prevInventory.filter(it => it.id !== selectedItem.id))
          setIsInventoryMode(false)
          setEditOrAddMenuActive(false)
          setSelectedItem(null)
          setEditPrice(0)
          setEditQuantity(0)
          setSelectedCategory(lang.select_category)
          setIsExistingInMarket(false)
        } else {
          setErrorMessage(lang.error_adding_item)
          setTimeout(() => setErrorMessage(''), 3000)
        }
      } catch (error) {
        setErrorMessage(lang.connection_error)
        setTimeout(() => setErrorMessage(''), 3000)
      }
    } else {
      const isWeaponItem = selectedItem && isWeapon(selectedItem.itemName)

      if (editPrice < 0) {
        setErrorMessage(lang.error_negative_number)
        setTimeout(() => setErrorMessage(''), 3000)
        return
      }
      if (editQuantity < 0) {
        setErrorMessage(lang.error_negative_number)
        setTimeout(() => setErrorMessage(''), 3000)
        return
      }

      if (isWeaponItem && editQuantity > 1) {
        setErrorMessage(lang.weapon_quantity_error)
        setTimeout(() => setErrorMessage(''), 3000)
        setEditQuantity(1)
        return
      }

      const updatedItem = {
        ...selectedItem,
        price: editPrice,
        maxQuantityinStore: editQuantity,
        category: selectedCategory
      }
      const resourceName = "v-market"
      try {
        const response = await fetch(`https://${resourceName}/updateMarketItem`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({
            marketId: marketId,
            item: updatedItem
          }),
        })
        const result = await response.json()
        if (result === 'ok') {
          setEditOrAddMenuActive(false)
          setSelectedItem(null)
          setEditPrice(0)
          setEditQuantity(0)
          setSelectedCategory(lang.select_category)
          setIsExistingInMarket(false)
        } else {
          setErrorMessage(lang.update_failed)
          setTimeout(() => setErrorMessage(''), 3000)
        }
      } catch (error) {
        setErrorMessage(lang.connection_error)
        setTimeout(() => setErrorMessage(''), 3000)
      }
    }
  }


  const fetchInventoryItems = async () => {
    try {
      const resourceName = "v-market"
      const response = await fetch(`https://${resourceName}/getInventoryItems`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      })
      if (response.ok) {
        const data = await response.json()
        let combinedItems: any[] = []

        if (data.items && Array.isArray(data.items)) {
          combinedItems = [...combinedItems, ...data.items]
        }
        if (data.weapons && Array.isArray(data.weapons)) {
          combinedItems = [...combinedItems, ...data.weapons]
        }
        if (Array.isArray(data)) {
          combinedItems = data
        }

        const mappedItems = combinedItems.map((item: any) => {
          const qty = item.maxQuantityinStore || item.count || item.Count || item.amount || item.Amount || item.quantity || item.qty || 1
          return {
            ...item,
            maxQuantityinStore: typeof qty === 'string' ? parseInt(qty) : qty
          }
        })

        setInventoryItems(mappedItems)
      }
    } catch (error) {
    }
  }

  const handleAddProduct = async () => {
    if (isInventoryMode) {
      setInventoryItems([])
      setIsInventoryMode(false)
      setEditOrAddMenuActive(false)
      setEditPrice(0)
      setEditQuantity(0)
      setSelectedCategory(lang.select_category)
      setActiveCategory('All')
      setSearchQuery('')
    } else {
      await fetchInventoryItems()
      setIsInventoryMode(true)
    }
  }

  const removeFromCart = (itemToRemove: CartItem) => {
    setCartItems(prevCart => prevCart.filter(item => {
      if (isWeapon(item.itemName)) {
        return item.weaponId !== itemToRemove.weaponId || item.itemName !== itemToRemove.itemName
      }
      return item.itemName !== itemToRemove.itemName
    }))
  }

  const calculateTotal = () => cartItems.reduce((total, item) => total + (item.price * item.quantity), 0)

  const isItemInCart = (item: Item) => {
    if (isWeapon(item.itemName)) {
      return cartItems.some(cartItem =>
        cartItem.itemName === item.itemName && cartItem.weaponId === item.weaponId
      )
    } else {
      return cartItems.some(cartItem => cartItem.itemName === item.itemName)
    }
  }

  const changeMarketDetails = async () => {
    if (marketId === 0) return
    if (marketIcon && marketIcon.length > 0 && customMarketName && customMarketName.length > 0 && customMarketDescription && customMarketDescription.length > 0) {
      const resourceName = "v-market"
      try {
        const response = await fetch(`https://${resourceName}/changeDetails`, {
          method: 'post',
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({ marketId: marketId, marketIcon: marketIcon, marketName: customMarketName, marketDescription: customMarketDescription }),
        })
        const result = await response.json()
        if (result === 'ok') {
          setErrorMessage(lang.successfully_saved)
          setTimeout(() => setErrorMessage(''), 3000)
        } else {
          setErrorMessage(lang.failed_to_save)
          setTimeout(() => setErrorMessage(''), 3000)
        }
      } catch (error) {
        setErrorMessage(lang.connection_error)
        setTimeout(() => setErrorMessage(''), 3000)
      }
    }
  }



  const addToCart = (item: Item) => {
    const weaponCheck = isWeapon(item.itemName)
    setCartItems(prevCart => {
      let itemPrice = item.price
      if (isInventoryMode) {
        const sellConfig = sellItems.find(i => i.itemName === item.itemName)
        if (sellConfig) {
          itemPrice = sellConfig.price
        }
      }
      const itemToAdd = { ...item, price: itemPrice }

      if (weaponCheck) {
        const existingWeapon = prevCart.find(cartItem =>
          cartItem.itemName === itemToAdd.itemName && cartItem.weaponId === itemToAdd.weaponId
        )
        if (existingWeapon) {
          return prevCart
        }
        return [...prevCart, { ...itemToAdd, quantity: 1 }]
      } else {
        const existingItem = prevCart.find(cartItem => cartItem.itemName === itemToAdd.itemName)
        if (existingItem) {
          return prevCart.map(cartItem =>
            cartItem.itemName === itemToAdd.itemName
              ? { ...cartItem, quantity: Math.min(itemToAdd.maxQuantityinStore, cartItem.quantity + 1) }
              : cartItem
          )
        } else {
          return [...prevCart, { ...itemToAdd, quantity: 1 }]
        }
      }
    })
  }

  const updateQuantity = (itemToUpdate: CartItem, newQuantity: number) => {
    if (newQuantity <= 0) return removeFromCart(itemToUpdate)

    const isWeaponItem = isWeapon(itemToUpdate.itemName)
    if (isWeaponItem && newQuantity > 1) return

    const sourceList = isInventoryMode ? inventoryItems : items
    const marketItem = sourceList.find(item => {
      if (isWeaponItem) {
        return item.itemName === itemToUpdate.itemName && item.weaponId === itemToUpdate.weaponId
      }
      return item.itemName === itemToUpdate.itemName
    })

    if (marketItem && newQuantity > marketItem.maxQuantityinStore) {
      return
    }

    setCartItems(prevCart => prevCart.map(item => {
      const matches = isWeaponItem
        ? (item.itemName === itemToUpdate.itemName && item.weaponId === itemToUpdate.weaponId)
        : (item.itemName === itemToUpdate.itemName)

      return matches ? { ...item, quantity: newQuantity } : item
    }))
  }

  const purchaseItems = async () => {
    if (cartItems.length === 0) return
    if (isPurchasing) return

    setIsPurchasing(true)
    if (!isInventoryMode && calculateTotal() > playerMoney) {
      setErrorMessage(lang.not_enough_money);
      setTimeout(() => setErrorMessage(''), 3000);
      setIsPurchasing(false);
      return;
    }

    const purchaseData: any = {
      items: cartItems?.map(item => ({
        name: item.itemName,
        quantity: item.quantity,
        weaponId: item.weaponId,
      })),
      marketName: marketName
    };
    if (marketId !== 0) {
      purchaseData.marketId = marketId;
    }

    const resourceName = "v-market"

    const endpoint = isInventoryMode ? 'sellItems' : 'purchase'

    try {
      const response = await fetch(`https://${resourceName}/${endpoint}`, {
        method: 'post',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(purchaseData),
      })
      const result = await response.json()
      if (result === 'ok') {
        setCartItems([])
        if (isInventoryMode) {
          fetchInventoryItems()
        } else {
          setIsMenuOpen(false)
          fetch(`https://${resourceName}/close`, { method: 'POST' })
        }
      } else {
        setErrorMessage(isInventoryMode ? lang.sell_error : lang.purchase_failed)
        setTimeout(() => setErrorMessage(''), 3000)
      }
    } catch (error) {
      setErrorMessage(lang.connection_error)
      setTimeout(() => setErrorMessage(''), 3000)
    } finally {
      setIsPurchasing(false)
    }
  }

  useEffect(() => {
    const resourceName = "v-market" // window.location.origin.split("https://cfx-nui-")[1]
    const handleKeyPress = (event: KeyboardEvent) => {
      if (event.key === 'Escape' && isMenuOpen) {
        setIsMenuOpen(false)
        fetch(`https://${resourceName}/close`, {
          method: 'POST',
        })

        setCartItems([])
      }
    }

    const handleClickOutside = (event: MouseEvent) => {
      const target = event.target as HTMLElement
      if (isDropdownOpen && !target.closest('.custom-select')) {
        setIsDropdownOpen(false)
      }
    }

    document.addEventListener('keydown', handleKeyPress)
    document.addEventListener('click', handleClickOutside)
    return () => {
      document.removeEventListener('keydown', handleKeyPress)
      document.removeEventListener('click', handleClickOutside)
    }
  }, [isMenuOpen, isDropdownOpen])

  const getItemImageUrl = (item: Item | CartItem) => {
    if (item.imageUrl && (item.imageUrl.startsWith('http') || item.imageUrl.startsWith('nui://'))) {
      return item.imageUrl
    }

    if (imageServer && imageServer.length > 0) {
      const filename = (item.imageUrl && item.imageUrl.length > 0) ? item.imageUrl : `${item.itemName}.png`
      return `${imageServer}${filename}`
    }

    if (framework === 'rsg-core') {
      return `https://cfx-nui-rsg-inventory/html/images/${item.imageUrl || (item.itemName + '.png')}`
    }

    if (item.imageUrl && item.imageUrl.length > 0) {
      return item.imageUrl
    }

    return `https://cfx-nui-vorp_inventory/html/img/items/${item.itemName}.png`
  }

  useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
      const { type, data, money, framework: frameworkType, imageServer: imgServer } = event.data || {}

      if (imgServer !== undefined) {
        setImageServer(imgServer)
      }

      if (frameworkType) {
        setFramework(frameworkType)
      }

      switch (type) {
        case 'OPEN_MENU':
          if (frameworkType) {
            setFramework(frameworkType)
          }
          setMarketId(0)
          setMarketCase(0)
          setItems(data.items || [])
          setSellItems(data.sellItems || [])
          setIsMenuOpen(true)
          setPlayerMoney(money)
          setMarketName(data.name)
          setMarketDescription(data.description)
          if (firstOpen !== 'OPEN_MENU') {
            setCartItems([])
            firstOpen = 'OPEN_MENU'
          }

          setEditOrAddMenuActive(false)

          if ((data.items && data.items.length > 0)) {
            setView("market")
            setIsInventoryMode(false)
          } else if (data.sellItems && data.sellItems.length > 0) {
            setView("sell")
            setIsInventoryMode(true)

            const resourceName = "v-market"
            fetch(`https://${resourceName}/getInventoryItems`, {
              method: 'GET',
              headers: { 'Content-Type': 'application/json; charset=UTF-8' }
            })
              .then(res => { if (res.ok) return res.json(); return [] })
              .then(invData => {
                let combinedItems: any[] = []

                if (invData.items && Array.isArray(invData.items)) {
                  combinedItems = [...combinedItems, ...invData.items]
                }
                if (invData.weapons && Array.isArray(invData.weapons)) {
                  combinedItems = [...combinedItems, ...invData.weapons]
                }
                if (Array.isArray(invData)) {
                  combinedItems = invData
                }

                const mappedItems = combinedItems.map((item: any) => ({
                  ...item,
                  maxQuantityinStore: item.maxQuantityinStore || item.count || item.amount || 1
                }))

                setInventoryItems(mappedItems)
              })
              .catch(() => { })

          } else {
            setView("market")
            setIsInventoryMode(false)
          }
          break
        case 'OPEN_CUSTOM':
          setMarketIcon(data.icon)
          setCustomMarketName(data.name)
          setCustomMarketDescription(data.description)
          if (firstOpen !== 'OPEN_CUSTOM') {
            setCartItems([])
            firstOpen = 'OPEN_CUSTOM'
          }
          setView("custom-market")
          setIsMenuOpen(true)
          setIsInventoryMode(false)
          setSellItems([])
          setMarketId(data.marketId)
          setMarketCase(data.caseMoney)
          setAccessManagementMenu(data.managementAccess)
          setcustomMarketCategory(data.category)
          setCanWithdraw(data.canWithdraw || false)
          setItems(data.items || [])
          setPlayerMoney(money)
          break
        case 'MARKET_UPDATED':
          setCustomMarketName(data.name)
          setCustomMarketDescription(data.description)
          setMarketIcon(data.icon)
          setItems(data.items || [])
          setMarketCase(data.caseMoney)
          setPlayerMoney(money)
          break
        case 'CASE_UPDATED':
          setMarketCase(data.caseMoney)
          setPlayerMoney(money)
          break
        case 'LANG_UPDATED':
          setLang(data)
          break
      }
    }

    window.addEventListener('message', handleMessage)
    return () => {
      window.removeEventListener('message', handleMessage)
    }
  }, [])

  return (
    <div className={`menu-container ${isMenuOpen ? 'open' : ''}`}>
      <div className={`market-products ${view === 'market' || view === 'sell' ? 'active' : ''}`}>
        <div className="background">
          <div className="market-logo">
            <div className="logo-icon"></div>
          </div>
          <div className="market-title">{marketName}</div>
          <div className="market-desc">{view === 'sell' ? lang.sell_description : marketDescription}</div>
          <div className="money">
            <div className="money-icon"></div>
            <div className="money-text-group">
              <div className="money-title">{lang.money}</div>
              <div className="money-amount-group">
                <div className="money-dolar-icon">$</div>
                <div className="money-amount">{playerMoney.toFixed(2)}</div>
              </div>
            </div>
          </div>
          <div className="transition" onClick={() => setView('cart')}>
            <div className="transition-icon"></div>
            <div className="transition-title">{lang.your_cart_title}</div>
          </div>
          <div className="search">
            <div className="search-icon"></div>
            <input
              type="text"
              className="search-input"
              placeholder={lang.search_placeholder}
              value={searchQuery || ''}
              onChange={handleSearchChange}
            />
          </div>
          <div className="menu">
            <div
              className={`all-category ${activeCategory === 'All' ? 'active' : ''}`}
              onClick={() => handleCategoryClick('All')}
            >
              <div className="all-icon">
              </div>
            </div>
            <div
              className={`foods-category ${activeCategory === 'Food' ? 'active' : ''}`}
              onClick={() => handleCategoryClick('Food')}
            >
              <div className="foods-icon">
              </div>
            </div>
            <div
              className={`healths-category ${activeCategory === 'Health' ? 'active' : ''}`}
              onClick={() => handleCategoryClick('Health')}
            >
              <div className="healths-icon">
              </div>
            </div>
            <div
              className={`tools-category ${activeCategory === 'Tools' ? 'active' : ''}`}
              onClick={() => handleCategoryClick('Tools')}
            >
              <div className="tools-icon">
              </div>
            </div>
          </div>
          <div className="product-list">
            {view === 'sell' ? (
              (() => {
                const searchLower = searchQuery.toLowerCase();
                
                const itemsInInv = inventoryItems.filter(invItem => {
                  const hasSellConfig = sellItems.some(sellConfig => sellConfig.itemName === invItem.itemName);
                  if (!hasSellConfig) return false;
                  if (activeCategory !== 'All' && invItem.category !== activeCategory) return false;
                  if (searchLower === '') return true;
                  return (invItem.itemLabel || invItem.itemName).toLowerCase().includes(searchLower) ||
                    (invItem.description || '').toLowerCase().includes(searchLower);
                });
                
                const sellItemsNotInInv = sellItems.filter(sellConfig => {
                  const inInv = inventoryItems.some(invItem => invItem.itemName === sellConfig.itemName);
                  if (inInv) return false;
                  if (activeCategory !== 'All') return false; // Non-inv items don't have category info by default, but we can assume 'All'
                  if (searchLower === '') return true;
                  return (sellConfig.itemLabel || sellConfig.itemName).toLowerCase().includes(searchLower);
                });

                const renderInvItems = itemsInInv.map((item, index) => {
                  const sellConfig = sellItems.find(i => i.itemName === item.itemName)!;
                  const itemQuantity = item.maxQuantityinStore || 1;

                  return (
                    <div key={`sell-inv-${item.id}-${index}`} className="product">
                      <div className="item">
                        <img src={getItemImageUrl(item)} alt={item.itemLabel || item.itemName} />
                        <div style={{ position: 'absolute', bottom: '5px', right: '5px', background: 'rgba(0,0,0,0.8)', color: 'white', padding: '2px 6px', borderRadius: '4px', fontSize: '10px', pointerEvents: 'none' }}>
                          {itemQuantity}x
                        </div>
                      </div>
                      <div className="item-details">
                        <div className="item-catagory">{item.category || lang.category}</div>
                        <div className="item-label">{item.itemLabel || item.itemName}</div>
                        <div className="item-desc">{item.description || lang.default_item_description}</div>
                      </div>
                      <div className="item-price-group">
                        <div className="item-price">
                          <div className="price-icon">$</div>
                          <div className="price-amount">{sellConfig.price.toFixed(2)}</div>
                        </div>
                        <div className="item-money-icon"></div>
                      </div>
                      <div
                        className={`add-basket`}
                        onClick={() => !isItemInCart(item) && addToCart(item)}
                      >
                        {isItemInCart(item) ? lang.added_to_cart : lang.sell_button}
                      </div>
                    </div>
                  );
                });

                const renderMissingItems = sellItemsNotInInv.map((sellItem, index) => {
                  const item: Item = {
                    id: 2000000 + index,
                    itemName: sellItem.itemName,
                    itemLabel: sellItem.itemLabel || sellItem.itemName,
                    category: lang.category,
                    description: lang.default_item_description,
                    price: sellItem.price,
                    maxQuantityinStore: 0,
                    imageUrl: sellItem.imageUrl || "",
                  };

                  return (
                    <div key={`sell-missing-${item.itemName}-${index}`} className="product">
                      <div className="item">
                        <img src={getItemImageUrl(item)} alt={item.itemLabel || item.itemName} />
                        <div style={{ position: 'absolute', bottom: '5px', right: '5px', background: 'rgba(0,0,0,0.8)', color: 'white', padding: '2px 6px', borderRadius: '4px', fontSize: '10px', pointerEvents: 'none' }}>
                          0x
                        </div>
                      </div>
                      <div className="item-details">
                        <div className="item-catagory">{item.category}</div>
                        <div className="item-label">{item.itemLabel || item.itemName}</div>
                        <div className="item-desc">{item.description}</div>
                      </div>
                      <div className="item-price-group">
                        <div className="item-price">
                          <div className="price-icon">$</div>
                          <div className="price-amount">{sellItem.price.toFixed(2)}</div>
                        </div>
                        <div className="item-money-icon"></div>
                      </div>
                      <div
                        className={`add-basket`}
                        style={{ opacity: 0.5, cursor: 'not-allowed' }}
                      >
                        {lang.no_sellable_items}
                      </div>
                    </div>
                  );
                });

                const allRendered = [...renderInvItems, ...renderMissingItems];
                
                if (allRendered.length === 0) {
                  return <div className="empty-cart">{lang.your_cart_is_empty} {lang.no_sellable_items}</div>;
                }
                
                return allRendered;
              })()
            ) : (
              filteredItems.map((item, index) => {
                return (
                  <div key={`${item.id}-${index}`} className="product">
                    <div className="item">
                      <img
                        src={getItemImageUrl(item)}
                        alt={item.itemLabel || item.itemName}
                      />
                    </div>
                    <div className="item-details">
                      <div className="item-catagory">{item.category}</div>
                      <div className="item-label">{item.itemLabel || item.itemName}</div>
                      <div className="item-desc">{item.description}</div>
                    </div>
                    <div className="item-price-group">
                      <div className="item-price">
                        <div className="price-icon">$</div>
                        <div className="price-amount">{item.price.toFixed(2)}</div>
                      </div>
                      <div className="item-money-icon"></div>
                    </div>
                    <div
                      className={`add-basket`}
                      onClick={() => !isItemInCart(item) && addToCart(item)}
                    >
                      {isItemInCart(item) ? lang.added_to_cart : lang.add_to_cart}
                    </div>
                  </div>
                )
              })
            )}
          </div>
        </div>
      </div>
      <div className={`market-products ${view === 'cart' ? 'active' : ''}`}>
        <div className="background">
          <div className="market-logo">
            <div className="logo-icon"></div>
          </div>
          <div className="market-title">{marketName}</div>
          <div className="market-desc">{marketDescription}</div>
          <div className="money">
            <div className="money-icon"></div>
            <div className="money-text-group">
              <div className="money-title">{lang.money}</div>
              <div className="money-amount-group">
                <div className="money-dolar-icon">$</div>
                <div className="money-amount">{playerMoney.toFixed(2)}</div>
              </div>
            </div>
          </div>
          <div className="transition-2" onClick={() => setView(isInventoryMode ? 'sell' : 'market')}>
            <div className="transition-icon-2"></div>
            <div className="transition-title-2">{lang.back_products}</div>
          </div>
          <div className="basket-list">
            {cartItems.length === 0 ? (
              <div className="empty-cart">{lang.your_cart_is_empty}</div>
            ) : (
              cartItems.map((cartItem, index) => (
                <div key={`${cartItem.id}-${index}`} className="product">
                  <div className="item">
                    <img src={getItemImageUrl(cartItem)} alt={cartItem.itemName} />
                  </div>
                  <div className="item-details">
                    <div className="item-catagory">{cartItem.category}</div>
                    <div className="item-label">{cartItem.itemLabel || cartItem.itemName}</div>
                    <div className="product-price-group">
                      <div className="item-money-icon"></div>
                      <div className="item-price">
                        <div className="price-icon">$</div>
                        <div className="price-amount">{(cartItem.price * cartItem.quantity).toFixed(2)}</div>
                      </div>
                    </div>
                    <div className="amount-group">
                      {!isWeapon(cartItem.itemName) && (
                        <div className="remove" onClick={() => updateQuantity(cartItem, cartItem.quantity - 1)}></div>
                      )}
                      <div className="amount">{cartItem.quantity}</div>
                      {!isWeapon(cartItem.itemName) && (
                        <div className="add" onClick={() => updateQuantity(cartItem, cartItem.quantity + 1)}></div>
                      )}
                    </div>
                  </div>
                </div>
              ))
            )}
          </div>
          <div className="total">
            <div className="total-title">{lang.total_price}:</div>
            <div className="total-money-group">
              <div className="total-money-icon"></div>
              <div className="total-price-group">
                <div className="total-dolar-icon">$</div>
                <div className="total-amount">{calculateTotal().toFixed(2)}</div>
              </div>
              <div
                className={`pay ${isPurchasing ? 'purchasing' : ''}`}
                onClick={purchaseItems}
              >
                {errorMessage !== ''
                  ? <span className="error-message">{errorMessage}</span>
                  : (isPurchasing ? lang.processing : (isInventoryMode ? lang.confirm : lang.pay_via_cash))}
              </div>
            </div>
          </div>
        </div>
      </div>
      <div className="shadows"></div>
      <div className={`market-products ${view === 'custom-market' ? 'active' : ''}`}>
        <div className="background-2">
          <div className="market-logo">
            <div
              className="logo-icon"
              style={
                marketIcon && marketIcon.length > 0
                  ? { backgroundImage: `url("${marketIcon}")` }
                  : { backgroundImage: `url("./src/img/market_icon.png")` }
              }
            ></div>
          </div>
          <div className="market-title">{customMarketName}</div>
          <div className="market-desc">{customMarketDescription}</div>
          <div className="money">
            <div className="money-icon"></div>
            <div className="money-text-group">
              <div className="money-title">{lang.money}</div>
              <div className="money-amount-group">
                <div className="money-dolar-icon">$</div>
                <div className="money-amount">{playerMoney.toFixed(2)}</div>
              </div>
            </div>
          </div>
          <div className={`management${isAccessManagementMenu ? " active" : ""}`} onClick={() => setView('custom-marketmanagement')}>
            <div className="management-icon"></div>
            {lang.management}
          </div>
          <div className="transition-3" onClick={() => setView('custom-marketbasket')}>
            <div className="transition-icon-3"></div>
            <div className="transition-title-3">{lang.your_cart_title}</div>
          </div>
          <div className="search-2">
            <div className="search-icon-2"></div>
            <input type="text" className="search-input-2" placeholder={lang.search_placeholder} value={searchQuery || ''} onChange={handleSearchChange} />
          </div>
          <div className="menu-2">
            <div className={`all-category ${activeCategory === 'All' ? 'active' : ''}`} onClick={() => handleCategoryClick('All')}>
              <div className="all-icon"></div>
            </div>
            {customMarketCategory === "Saloon" && (
              <>
                <div className={`foods-category ${activeCategory === 'Food' ? 'active' : ''}`} onClick={() => handleCategoryClick('Food')}>
                  <div className="food-icon"></div>
                </div>
                <div className={`drink-category ${activeCategory === 'Drink' ? 'active' : ''}`} onClick={() => handleCategoryClick('Drink')}>
                  <div className="drink-icon"></div>
                </div>
              </>
            )}
            {customMarketCategory === "Gunsmith" && (
              <>
                <div className={`weapon-category ${activeCategory === 'Weapon' ? 'active' : ''}`} onClick={() => handleCategoryClick('Weapon')}>
                  <div className="weapon-icon"></div>
                </div>
                <div className={`ammu-category ${activeCategory === 'Ammo' ? 'active' : ''}`} onClick={() => handleCategoryClick('Ammo')}>
                  <div className="ammu-icon"></div>
                </div>
                <div className={`materials-category ${activeCategory === 'Materials' ? 'active' : ''}`} onClick={() => handleCategoryClick('Materials')}>
                  <div className="materials-icon"></div>
                </div>
              </>
            )}
          </div>
          <div className="product-list-2">
            {filteredItems.map((item, index) => (
              <div key={`${item.id}-${index}`} className="product-2">
                <div className="item-2"><img src={getItemImageUrl(item)} />
                </div>
                <div className="item-details-2">
                  <div className="item-catagory-2">{item.category}</div>
                  <div className="item-label-2">{item.itemLabel || item.itemName}</div>
                  <div className="item-desc-2">{item.description}</div>
                </div>
                <div className="item-price-group-2">
                  <div className="item-price">
                    <div className="price-icon">$</div>
                    <div className="price-amount">{item.price.toFixed(2)}</div>
                  </div>
                  <div className="item-money-icon"></div>
                </div>
                <div className={`add-basket-2`} onClick={() => !isItemInCart(item) && addToCart(item)}>
                  {isItemInCart(item) ? lang.added_to_cart : lang.add_to_cart}
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
      <div className={`market-products ${view === 'custom-marketbasket' ? 'active' : ''}`}>
        <div className="background-2">
          <div className="market-logo">
            <div
              className="logo-icon"
              style={
                marketIcon && marketIcon.length > 0
                  ? { backgroundImage: `url("${marketIcon}")` }
                  : { backgroundImage: `url("./src/img/market_icon.png")` }
              }
            ></div>
          </div>
          <div className="market-title">{customMarketName}</div>
          <div className="market-desc">{customMarketDescription}</div>
          <div className="money">
            <div className="money-icon"></div>
            <div className="money-text-group">
              <div className="money-title">{lang.money}</div>
              <div className="money-amount-group">
                <div className="money-dolar-icon">$</div>
                <div className="money-amount">{playerMoney.toFixed(2)}</div>
              </div>
            </div>
          </div>
          <div className="transition-3" onClick={() => setView('custom-market')}>
            <div className="transition-icon-4"></div>
            <div className="transition-title-3">{lang.back_products}</div>
          </div>
          <div className="product-list-3">
            {cartItems.length === 0 ? (
              <div className="empty-cart-2">{lang.your_cart_is_empty}</div>
            ) : (
              cartItems.map((cartItem, index) => (
                <div key={`${cartItem.id}-${index}`} className="product-2">
                  <div className="item-2"><img src={getItemImageUrl(cartItem)} alt={cartItem.itemName} />
                  </div>
                  <div className="item-details-2">
                    <div className="item-catagory-2">{lang.food_category}</div>
                    <div className="item-label-2">{cartItem.itemLabel || cartItem.itemName}</div>
                    <div className="item-desc-2">{lang.description}</div>
                  </div>
                  <div className="item-price-group-2">
                    <div className="item-price">
                      <div className="price-icon">$</div>
                      <div className="price-amount">{(cartItem.price * cartItem.quantity).toFixed(2)}</div>
                    </div>
                    <div className="item-money-icon"></div>
                  </div>
                  <div className="amount-group-2">
                    {!isWeapon(cartItem.itemName) && (
                      <div className="remove" onClick={() => updateQuantity(cartItem, cartItem.quantity - 1)}></div>
                    )}
                    <div className="amount-2">{cartItem.quantity}</div>
                    {!isWeapon(cartItem.itemName) && (
                      <div className="add" onClick={() => updateQuantity(cartItem, cartItem.quantity + 1)}></div>
                    )}
                  </div>
                </div>
              )))}
          </div>
          <div className="total-2">
            <div className="total-title-2">{lang.total_price}:</div>
            <div
              className={`pay-2 ${isPurchasing ? 'purchasing' : ''}`}
              onClick={purchaseItems}
            >
              {errorMessage !== ''
                ? <span className="error-message">{errorMessage}</span>
                : (isPurchasing ? lang.processing : lang.pay_via_cash)}
            </div>
            <div className="total-money-group-2">
              <div className="total-money-icon"></div>
              <div className="total-price-group">
                <div className="total-dolar-icon">$</div>
                <div className="total-amount">{calculateTotal().toFixed(2)}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div className={`market-products ${view === 'custom-marketmanagement' ? 'active' : ''}`}>
        <div className="background-3">
          <div className="market-logo">
            <div
              className="logo-icon"
              style={
                marketIcon && marketIcon.length > 0
                  ? { backgroundImage: `url("${marketIcon}")` }
                  : { backgroundImage: `url("./src/img/market_icon.png")` }
              }
            ></div>
          </div>
          <div className="market-title">{customMarketName}</div>
          <div className="market-desc">{customMarketDescription}</div>
          <div className="transition-4" onClick={() => { setView('custom-market'); setEditOrAddMenuActive(false); }}>
            <div className="transition-icon-4"></div>
            <div className="transition-title-3">{lang.back_market}</div>
          </div>
          <div className="menu-3">
            <div className={`all-category ${activeCategory === 'All' ? 'active' : ''}`} onClick={() => handleCategoryClick('All')}>
              <div className="all-icon"></div>
            </div>
            {customMarketCategory === "Saloon" && (
              <>
                <div className={`foods-category ${activeCategory === 'Food' ? 'active' : ''}`} onClick={() => handleCategoryClick('Food')}>
                  <div className="food-icon"></div>
                </div>
                <div className={`drink-category ${activeCategory === 'Drink' ? 'active' : ''}`} onClick={() => handleCategoryClick('Drink')}>
                  <div className="drink-icon"></div>
                </div>
              </>
            )}
            {customMarketCategory === "Gunsmith" && (
              <>
                <div className={`weapon-category ${activeCategory === 'Weapon' ? 'active' : ''}`} onClick={() => handleCategoryClick('Weapon')}>
                  <div className="weapon-icon"></div>
                </div>
                <div className={`ammu-category ${activeCategory === 'Ammo' ? 'active' : ''}`} onClick={() => handleCategoryClick('Ammo')}>
                  <div className="ammu-icon"></div>
                </div>
                <div className={`materials-category ${activeCategory === 'Materials' ? 'active' : ''}`} onClick={() => handleCategoryClick('Materials')}>
                  <div className="materials-icon"></div>
                </div>
              </>
            )}
          </div>
          <div className="input-1">
            <div className="input-title">{lang.merchant_logo}</div>
            <div className="input-desc">{lang.merchant_logo_description}</div>
            <div className="input">
              <input type="text" value={marketIcon || ''} onChange={handleIconChange} placeholder={lang.enter_url_placeholder} />

            </div>
          </div>
          <div className="input-2">
            <div className="input-title">{lang.merchant_name_title}</div>
            <div className="input-desc">{lang.merchant_name_title_description}</div>
            <div className="input">
              <input type="text" value={customMarketName || ''} onChange={handleNameChange} placeholder={lang.enter_name_placeholder} />

            </div>
          </div>
          <div className="input-3">
            <div className="input-title">{lang.merchant_description_title}</div>
            <div className="input-desc">{lang.merchant_description_title_description}</div>
            <div className="input">
              <input type="text" value={customMarketDescription || ''} onChange={handleDescriptionChange} placeholder={lang.enter_desc_placeholder} />
            </div>
          </div>
          <div className="case-group">
            <div className="case-title">{lang.case_title}</div>
            <div className="case-desc">{lang.case_description}</div>
            <div className="case">
              <div className="case-amount-title">{lang.case_amount_title}</div>
              <div className="case-money">
                <div className="case-dolar-icon">$</div>
                <div className="case-amount">{marketCase.toFixed(2)}</div>
              </div>
            </div>
            <div className="case-amount-group">
              <div className="amount-group-3">{lang.amount_title}</div>
              <div className="case-money-enter">
                <div className="enter-dolar-icon">$</div>
                <input
                  type="number"
                  placeholder="0.00"
                  min={0}
                  max={marketCase}
                  value={withdrawAmount || ''}
                  onChange={handleWithdrawAmountChange}
                  onBlur={handleWithdrawAmountBlur}
                  onFocus={handleWithdrawAmountFocus}
                />
              </div>
            </div>
            <div
              className={`withdraw ${!canWithdraw ? 'disabled' : ''}`}
              onClick={canWithdraw ? handleWithdrawCash : undefined}
              style={{
                opacity: canWithdraw ? 1 : 0.5,
                cursor: canWithdraw ? 'pointer' : 'not-allowed'
              }}
            >
              <div className="withdraw-icon"></div>
              <div className="withdraw-title">
                {canWithdraw ? lang.withdraw_cash : lang.no_permission}
              </div>
            </div>
          </div>
          <div className="add-product" onClick={handleAddProduct}>
            <div className="add-product-icon"></div>
            <div className="add-product-title">{!isInventoryMode ? lang.add_item : lang.back}</div>
          </div>
          {isInventoryMode && (
            <div className="edit-group" onClick={() => {
              setIsInventoryMode(false);
              setInventoryItems([]);
            }}>
              <div className="edit-icon"></div>
            </div>
          )}
          <div className="item-list-group">
            {(isInventoryMode ? inventoryItems : filteredItems).map((item, index) => (
              <div className="item-box" key={`${item.id}-${index}`} onClick={() => handleItemClick(item)}>
                <div className="box-money-group">
                  <div className="box-dolar-icon">$</div>
                  <div className="box-money-amount">{item.price.toFixed(2)}</div>
                </div>
                <div className="box-item-amount">
                  <div className="box-amount">{item.maxQuantityinStore}</div>
                  <div className="box-amount-icon">x</div>
                </div>
                <div className="item-box-name">{item.itemLabel || item.itemName}</div>
                <img src={getItemImageUrl(item)} />
              </div>
            ))}
            {Array.from({ length: Math.max(0, 18 - (isInventoryMode ? (inventoryItems || []).length : (filteredItems || []).length)) }).map((_, idx) => (
              <div className="item-box-empty" key={`empty-${idx}`}></div>
            ))}
          </div>
          <div className="save" onClick={() => changeMarketDetails()}>{lang.save}</div>
        </div>
      </div>
      <div className={`add-product-menu ${isEditOrAddMenuActive ? 'active' : ''}`}>
        <div className="menu-background">
          <div className="menu-item">
            <img
              src={
                selectedItem
                  ? getItemImageUrl(selectedItem)
                  : "img/item_example.png"
              }
            />
          </div>
          <div className="menu-title">{selectedItem?.itemLabel || selectedItem?.itemName || lang.item_name}</div>
          <div className="menu-desc">
            {selectedItem?.description || lang.default_item_description}
            {/* {selectedItem?.metadata && (
              <div style={{ marginTop: '10px', fontSize: '0.8em', color: '#ccc' }}>
                {selectedItem.metadata.serial && <div>Serial: {selectedItem.metadata.serial}</div>}
                {isWeapon(selectedItem.itemName) && selectedItem.metadata.ammo !== undefined && <div>Ammo: {selectedItem.metadata.ammo}</div>}
                {selectedItem.metadata.components && Object.keys(selectedItem.metadata.components).length > 0 && (
                  <div style={{ marginTop: '5px' }}>
                    Components: {Object.keys(selectedItem.metadata.components).join(', ')}
                  </div>
                )}
              </div>
            )} */}
          </div>
          <div className="price-input" style={{ opacity: isInventoryMode && isExistingInMarket ? 0.5 : 1 }}>
            <div className="price-input-title">{lang.price}:</div>
            <div className="price-input-money">
              <div className="price-input-dolar-icon">$</div>
              <input
                type="number"
                min={isInventoryMode ? 1 : 0}
                placeholder="0.00"
                value={editPrice || ''}
                onChange={(e) => setEditPrice(e.target.value === '' ? 0 : Number(e.target.value))}
                disabled={isInventoryMode && isExistingInMarket}
              />
            </div>
          </div>
          <div className="amount-input">
            <div className="price-input-title">{lang.amount_title}:</div>
            <div className="price-input-money">
              <input
                type="number"
                min={0}
                max={isInventoryMode && selectedItem ? (isWeapon(selectedItem.itemName) ? 1 : selectedItem.maxQuantityinStore) : undefined}
                placeholder="0"
                value={editQuantity || ''}
                onChange={(e) => {
                  const value = e.target.value === '' ? 0 : Number(e.target.value)
                  if (isInventoryMode && selectedItem) {
                    const isWeaponItem = isWeapon(selectedItem.itemName)
                    const maxValue = isWeaponItem ? 1 : selectedItem.maxQuantityinStore
                    setEditQuantity(Math.min(Math.max(0, value), maxValue))
                  } else {
                    const isWeaponItem = selectedItem && isWeapon(selectedItem.itemName)
                    if (isWeaponItem) {
                      setEditQuantity(value === 0 ? 0 : 1)
                    } else {
                      setEditQuantity(Math.max(0, value))
                    }
                  }
                }}
              />
            </div>
          </div>
          <div className="category-input" style={{ opacity: isInventoryMode && isExistingInMarket ? 0.5 : 1 }}>
            <div className="category-title">{lang.category}: </div>
            <div className="custom-select">
              <div className="selected" onClick={isInventoryMode && isExistingInMarket ? undefined : handleDropdownToggle}>
                {selectedCategory}
                <div className="select-icon"></div>
              </div>
              <div className={`options ${isDropdownOpen ? 'open' : ''}`}>
                {ITEM_CATEGORIES.map(category => (
                  <div key={category} className="option" onClick={() => handleCategorySelect(category)}>{category}</div>
                ))}
              </div>
            </div>
          </div>
          <div className="cancel" onClick={() => {
            setEditOrAddMenuActive(false)
            setEditPrice(0)
            setEditQuantity(0)
            setSelectedCategory(lang.select_category)
            setIsExistingInMarket(false)
          }}>{lang.cancel}</div>
          <div className="confirm" onClick={handleSaveItem}>{lang.confirm}</div>
        </div>
      </div>

    </div >
  )
}

export default App
