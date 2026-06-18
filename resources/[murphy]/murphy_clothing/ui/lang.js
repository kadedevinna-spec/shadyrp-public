/**
 * Language/Translation File for Murphy Clothing
 * 
 * HOW TO USE:
 * 1. To change language, modify the LANG variable below (e.g., 'en', 'pl', 'fr', 'de', 'ua', etc.)
 * 2. To add a new language, copy an existing language object and translate all strings
 * 3. All text displayed in the UI comes from this file
 * 
 * IMPORTANT: 
 * - When updating script.js, translations will remain intact in this file!
 * - Make sure to hard refresh your browser (Ctrl+F5) after changing LANG to clear the cache
 * - If translations don't appear, check browser console for errors
 */

// Set your language here: 'en', 'pl', 'fr', 'de', 'es', 'ua', etc.
const LANG = 'en';

// Translation object
const Lang = {
    // English
    en: {
        // Outfit Menu
        save: "Save",
        savePrice: "Save - $",
        
        // Outfit Name Dialog
        outfitName: "Outfit Name",
        outfitNamePlaceholder: "Enter the name of the outfit",
        create: "Create",
        cancel: "Cancel",
        
        // Outfit List
        outfit: "OUTFIT",
        createNew: "CREATE NEW",
        modify: "Modify",
        equip: "Equip",
        delete: "Delete",
        recover: "Recover",
        
        // Deletion Confirmation
        warning: "Warning!",
        deleteConfirm: "Are you sure you want to delete",
        deleteConfirmOutfit: "outfit?",
        resetConfirm: "Are you sure you want to reset the outfit you are creating?",
        yes: "Yes",
        no: "No",
        
        // My Outfit Menu
        myOutfit: "MY OUTFIT",
        naked: "Naked",
        dressed: "Dressed",
        
        // Contextual Menu
        variation: "Variation",
        tint: "Tint",
        
        // Camera Controls
        horizontal: "Horizontal",
        zoom: "Zoom",
        rotation: "Rotation",
        
        // Buttons
        back: "Back",
        confirm: "Confirm",
        close: "Close",
        reset: "Reset",
        
        // Messages
        noOutfits: "No outfits available",
        loading: "Loading...",
        
        // Body Selector
        mpBody: "MP Body",
        npcBody: "NPC Body",
        state: "State",
        model: "Model",

        // Single Item
        buySingleItem: "BUY SINGLE ITEM",
        buyPrice: "Buy - $",

        // Clothing Selector (MP/NPC toggle)
        mp: "MP",
        npc: "NPC",

        // Categories (add as needed)
        hats: "Hats",
        shirts: "Shirts",
        pants: "Pants",
        boots: "Boots",
        coats: "Coats",
        vests: "Vests",
        gloves: "Gloves",
        accessories: "Accessories"
    },
    
    // Polish
    pl: {
        // Outfit Menu
        save: "Zapisz",
        savePrice: "Zapisz - $",
        
        // Outfit Name Dialog
        outfitName: "Nazwa Stroju",
        outfitNamePlaceholder: "Wprowadź nazwę stroju",
        create: "Utwórz",
        cancel: "Anuluj",
        
        // Outfit List
        outfit: "STRÓJ",
        createNew: "UTWÓRZ NOWY",
        modify: "Modyfikuj",
        equip: "Załóż",
        delete: "Usuń",
        recover: "Odzyskaj",
        
        // Deletion Confirmation
        warning: "Ostrzeżenie!",
        deleteConfirm: "Czy na pewno chcesz usunąć",
        deleteConfirmOutfit: "strój?",
        resetConfirm: "Czy na pewno chcesz zresetować tworzony strój?",
        yes: "Tak",
        no: "Nie",
        
        // My Outfit Menu
        myOutfit: "MÓJ STRÓJ",
        naked: "Nagi",
        dressed: "Ubrany",
        
        // Contextual Menu
        variation: "Wariant",
        tint: "Kolor",
        
        // Camera Controls
        horizontal: "Poziomo",
        zoom: "Przybliżenie",
        rotation: "Obrót",
        
        // Buttons
        back: "Wstecz",
        confirm: "Potwierdź",
        close: "Zamknij",
        reset: "Resetuj",
        
        // Messages
        noOutfits: "Brak dostępnych strojów",
        loading: "Ładowanie...",
        
        // Body Selector
        mpBody: "Ciało MP",
        npcBody: "Ciało NPC",
        state: "Stan",
        model: "Model",

        // Single Item
        buySingleItem: "KUP POJEDYNCZY PRZEDMIOT",
        buyPrice: "Kup - $",

        // Clothing Selector
        mp: "MP",
        npc: "NPC",

        // Categories
        hats: "Kapelusze",
        shirts: "Koszule",
        pants: "Spodnie",
        boots: "Buty",
        coats: "Płaszcze",
        vests: "Kamizelki",
        gloves: "Rękawiczki",
        accessories: "Akcesoria"
    },
    
    // French
    fr: {
        // Outfit Menu
        save: "Sauvegarder",
        savePrice: "Sauvegarder - $",
        
        // Outfit Name Dialog
        outfitName: "Nom de la Tenue",
        outfitNamePlaceholder: "Entrez le nom de la tenue",
        create: "Créer",
        cancel: "Annuler",
        
        // Outfit List
        outfit: "TENUE",
        createNew: "CRÉER NOUVEAU",
        modify: "Modifier",
        equip: "Équiper",
        delete: "Supprimer",
        recover: "Récupérer",
        
        // Deletion Confirmation
        warning: "Attention!",
        deleteConfirm: "Êtes-vous sûr de vouloir supprimer",
        deleteConfirmOutfit: "tenue?",
        resetConfirm: "Êtes-vous sûr de vouloir réinitialiser la tenue en cours de création ?",
        yes: "Oui",
        no: "Non",
        
        // My Outfit Menu
        myOutfit: "MA TENUE",
        naked: "Nu",
        dressed: "Habillé",
        
        // Contextual Menu
        variation: "Variation",
        tint: "Teinte",
        
        // Camera Controls
        horizontal: "Horizontal",
        zoom: "Zoom",
        rotation: "Rotation",
        
        // Buttons
        back: "Retour",
        confirm: "Confirmer",
        close: "Fermer",
        reset: "Réinitialiser",
        
        // Messages
        noOutfits: "Aucune tenue disponible",
        loading: "Chargement...",
        
        // Body Selector
        mpBody: "Corps MP",
        npcBody: "Corps NPC",
        state: "État",
        model: "Modèle",

        // Single Item
        buySingleItem: "ACHETER UN ARTICLE",
        buyPrice: "Acheter - $",

        // Clothing Selector
        mp: "MP",
        npc: "NPC",

        // Categories
        hats: "Chapeaux",
        shirts: "Chemises",
        pants: "Pantalons",
        boots: "Bottes",
        coats: "Manteaux",
        vests: "Gilets",
        gloves: "Gants",
        accessories: "Accessoires"
    },
    
    // German
    de: {
        // Outfit Menu
        save: "Speichern",
        savePrice: "Speichern - $",
        
        // Outfit Name Dialog
        outfitName: "Outfit-Name",
        outfitNamePlaceholder: "Geben Sie den Namen des Outfits ein",
        create: "Erstellen",
        cancel: "Abbrechen",
        
        // Outfit List
        outfit: "OUTFIT",
        createNew: "NEU ERSTELLEN",
        modify: "Ändern",
        equip: "Ausrüsten",
        delete: "Löschen",
        recover: "Wiederherstellen",
        
        // Deletion Confirmation
        warning: "Warnung!",
        deleteConfirm: "Möchten Sie wirklich löschen",
        deleteConfirmOutfit: "Outfit?",
        resetConfirm: "Möchten Sie das Outfit, das Sie gerade erstellen, wirklich zurücksetzen?",
        yes: "Ja",
        no: "Nein",
        
        // My Outfit Menu
        myOutfit: "MEIN OUTFIT",
        naked: "Nackt",
        dressed: "Angezogen",
        
        // Contextual Menu
        variation: "Variation",
        tint: "Färbung",
        
        // Camera Controls
        horizontal: "Horizontal",
        zoom: "Zoom",
        rotation: "Drehung",
        
        // Buttons
        back: "Zurück",
        confirm: "Bestätigen",
        close: "Schließen",
        reset: "Zurücksetzen",
        
        // Messages
        noOutfits: "Keine Outfits verfügbar",
        loading: "Wird geladen...",
        
        // Body Selector
        mpBody: "MP-Körper",
        npcBody: "NPC-Körper",
        state: "Zustand",
        model: "Modell",

        // Single Item
        buySingleItem: "EINZELARTIKEL KAUFEN",
        buyPrice: "Kaufen - $",

        // Clothing Selector
        mp: "MP",
        npc: "NPC",

        // Categories
        hats: "Hüte",
        shirts: "Hemden",
        pants: "Hosen",
        boots: "Stiefel",
        coats: "Mäntel",
        vests: "Westen",
        gloves: "Handschuhe",
        accessories: "Zubehör"
    },
    
    // Spanish
    es: {
        // Outfit Menu
        save: "Guardar",
        savePrice: "Guardar - $",
        
        // Outfit Name Dialog
        outfitName: "Nombre del Atuendo",
        outfitNamePlaceholder: "Ingrese el nombre del atuendo",
        create: "Crear",
        cancel: "Cancelar",
        
        // Outfit List
        outfit: "ATUENDO",
        createNew: "CREAR NUEVO",
        modify: "Modificar",
        equip: "Equipar",
        delete: "Eliminar",
        recover: "Recuperar",
        
        // Deletion Confirmation
        warning: "¡Advertencia!",
        deleteConfirm: "¿Estás seguro de que quieres eliminar",
        deleteConfirmOutfit: "atuendo?",
        resetConfirm: "¿Estás seguro de que quieres reiniciar el atuendo que estás creando?",
        yes: "Sí",
        no: "No",
        
        // My Outfit Menu
        myOutfit: "MI ATUENDO",
        naked: "Desnudo",
        dressed: "Vestido",
        
        // Contextual Menu
        variation: "Variación",
        tint: "Tinte",
        
        // Camera Controls
        horizontal: "Horizontal",
        zoom: "Zoom",
        rotation: "Rotación",
        
        // Buttons
        back: "Atrás",
        confirm: "Confirmar",
        close: "Cerrar",
        reset: "Reiniciar",
        
        // Messages
        noOutfits: "No hay atuendos disponibles",
        loading: "Cargando...",
        
        // Body Selector
        mpBody: "Cuerpo MP",
        npcBody: "Cuerpo NPC",
        state: "Estado",
        model: "Modelo",

        // Single Item
        buySingleItem: "COMPRAR ARTÍCULO",
        buyPrice: "Comprar - $",

        // Clothing Selector
        mp: "MP",
        npc: "NPC",

        // Categories
        hats: "Sombreros",
        shirts: "Camisas",
        pants: "Pantalones",
        boots: "Botas",
        coats: "Abrigos",
        vests: "Chalecos",
        gloves: "Guantes",
        accessories: "Accesorios"
    }
};

// Helper function to get translated text
function T(key) {
    if (Lang[LANG] && Lang[LANG][key]) {
        return Lang[LANG][key];
    }
    // Fallback to English if translation not found
    if (Lang.en && Lang.en[key]) {
        return Lang.en[key];
    }
    // Return key if nothing found
    return key;
}

// Export for use in script.js
if (typeof window !== 'undefined') {
    window.T = T;
    window.Lang = Lang;
    window.LANG = LANG;
}
