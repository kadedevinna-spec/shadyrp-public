-- ─── config_tutorial.lua ─────────────────────────────────────────────────────
-- Configuration for the /campinfo tutorial page.
-- You can add multiple PNGs or GIFs per step (displayed stacked vertically).
--
-- images     : List of image URLs or paths. You can add multiple:
--                images = { "url1", "url2", "url3" }
--              For a single image:
--                images = { "url1" }
--              No images: images = {} or nil
-- caption    : Common caption text shown below all images (per language).
--
-- Language is pulled from Config.Language (config.lua).
-- ─────────────────────────────────────────────────────────────────────────────

Config.Tutorial = {}

-- ─── STEPS ───────────────────────────────────────────────────────────────────

Config.Tutorial.Steps = {

    -- ── STEP 1 ────────────────────────────────────────────────────────────────
    [1] = {
        title = {
            en = "Buying Props from the Store",
            tr = "Magazadan Esya Satin Alma",
            de = "Gegenstaende im Laden kaufen",
        },
        desc = {
            en = "Find the Camping Store marker on your map and interact with the merchant. Browse categories, hover over an item to preview it in 3D, then add it to your cart. Press PURCHASE to buy everything at once. Items will be added directly to your inventory.",
            tr = "Haritanizda Kamp Magazasi isaretini bulun ve saticiyla etkilesime gecin. Kategorilere gozatin, bir esyanin uzerine gelin ve 3D onizlemesini goruntuleyin, ardindan sepetinize ekleyin. Tek seferde satin almak icin SATIN AL'a basin. Esyalar dogrudan envanterinize eklenir.",
            de = "Finde die Camping-Laden-Markierung auf deiner Karte und interagiere mit dem Haendler. Durchstoebere die Kategorien, fahre ueber einen Gegenstand fuer eine 3D-Vorschau und fuege ihn dem Warenkorb hinzu. Druecke KAUFEN, um alles auf einmal zu erwerben. Die Gegenstaende werden direkt deinem Inventar hinzugefuegt.",
        },
        images = {
            "https://upload.fixitfy.com.tr/images/FIXITFY-FYz4EeXSFWwM.gif",
            -- add a second image by continuing here:
            -- "https://...",
            "https://upload.fixitfy.com.tr/images/FIXITFY-qmu0cTdsKmka.gif",
        },
        caption = {
            en = "Preview",
            tr = "Onizleme",
            de = "",
        },
    },

    -- ── STEP 2 ────────────────────────────────────────────────────────────────
    [2] = {
        title = {
            en = "Setting Up Your Camp",
            tr = "Kampinizi Kurma",
            de = "Lager aufbauen",
        },
        desc = {
            en = "Type /createcamp to open the base item picker. Only tent, shelter, and wagon items (marked as base props) appear here. Alternatively, open your inventory and use a base item directly. Drag the item to the drop zone in the center of the screen, then use arrow keys to position it and press ENTER to confirm. You cannot set up camp inside towns.",
            tr = "/createcamp yazarak temel esya secici menusunu acin. Yalnizca cadir, signak ve araba esyalari (temel prop olarak isaretlenenler) burada gorunur. Alternatif olarak envanterinizi acip temel bir esyayi dogrudan kullanabilirsiniz. Esyayi ekranin ortasindaki birakma alanina surukleleyin, ardindan ok tuslarini kullanarak konumlandirin ve ENTER'a basin. Kasabalara kamp kuramazsiniz.",
            de = "Tippe /createcamp, um die Basisartikelauswahl zu oeffnen. Nur Zelt-, Unterstand- und Wagenartikel (als Basisobjekte markiert) erscheinen hier. Alternativ kannst du dein Inventar oeffnen und einen Basisartikel direkt verwenden. Ziehe den Artikel in die Ablagezone in der Mitte des Bildschirms, verwende dann die Pfeiltasten zur Positionierung und druecke ENTER zum Bestaetigen. In Staedten kannst du kein Lager aufbauen.",
        },
        images = {"https://upload.fixitfy.com.tr/images/FIXITFY-4Yt6DHeSnTBE.gif", "https://upload.fixitfy.com.tr/images/FIXITFY-m4dW44xuCDR9.gif"},   -- example: { "assets/tutorial/step2_a.gif", "assets/tutorial/step2_b.png" }
        caption = {
            en = "Preview",
            tr = "Onizleme",
            de = "",
        },
    },

    -- ── STEP 3 ────────────────────────────────────────────────────────────────
    [3] = {
        title = {
            en = "Placing Props (/mycamp)",
            tr = "Esya Yerlestirme (/mycamp)",
            de = "Objekte platzieren (/mycamp)",
        },
        desc = {
            en = "Type /mycamp to open your camp management menu. Your inventory camp items appear on the right panel. Drag any item from the right panel to the center drop zone to enter placement mode. Use the arrow keys to move the prop, A/D to rotate left/right, Q/Z to raise/lower, SPACE to snap to the ground, and ENTER to confirm placement.",
            tr = "/mycamp yazarak kamp yonetim menunuzu acin. Envanter kamp esyalariniz sag panelde gorunur. Yerlestirme moduna girmek icin sag paneldeki herhangi bir esyayi merkezdeki birakma alanina surukleleyin. Prop'u tasimak icin ok tuslarini kullanin, sol/sag dondurme icin A/D, yukari/asagi icin Q/Z, zemine yapistirmak icin SPACE ve yerlestirmeyi onaylamak icin ENTER'a basin.",
            de = "Tippe /mycamp, um dein Lagerverwaltungsmenue zu oeffnen. Deine Inventar-Lagerartikel erscheinen im rechten Panel. Ziehe einen Artikel aus dem rechten Panel in die mittlere Ablagezone, um den Platziermodus zu starten. Benutze die Pfeiltasten zum Bewegen, A/D zum Links-/Rechtsdrehen, Q/Z zum Heben/Senken, SPACE zum Einrasten am Boden und ENTER zum Bestaetigen der Platzierung.",
        },
        images = {"https://upload.fixitfy.com.tr/images/FIXITFY-i8MRrEcfDKEb.gif"},
        caption = {
            en = "Preview",
            tr = "Onizleme",
            de = "",
        },
    },

    -- ── STEP 4 ────────────────────────────────────────────────────────────────
    [4] = {
        title = {
            en = "Installing Props",
            tr = "Esya Kurulumu",
            de = "Objekte installieren",
        },
        desc = {
            en = "Newly placed props are temporary and semi-transparent. To make them permanent, select a prop in the /mycamp left panel and click INSTALL, or walk up to the prop in the world and hold the install key prompt that appears. A hammer animation plays during installation. Installed props are fully solid and saved to the database.",
            tr = "Yeni yerlestirilen esyalar gecici ve yari seffaftir. Onlari kalici hale getirmek icin /mycamp sol panelinde bir prop secin ve KUR'a tiklayin ya da dunyada prop'a yaklasip gorunen kurulum tus istemine basili tutun. Kurulum sirasinda bir cekic animasyonu oynatilir. Kurulan esyalar tamamen somuttur ve veritabanina kaydedilir.",
            de = "Neu platzierte Objekte sind temporaer und halbtransparent. Um sie dauerhaft zu machen, waehle ein Objekt im /mycamp linken Panel und klicke auf INSTALLIEREN, oder gehe in der Welt zum Objekt und halte den Installationshinweis gedrueckt. Waehrend der Installation wird eine Hammeranimation abgespielt. Installierte Objekte sind vollstaendig fest und werden in der Datenbank gespeichert.",
        },
        images = {"https://upload.fixitfy.com.tr/images/FIXITFY-iZs9TnKvEutl.gif"},
        caption = {
            en = "Preview",
            tr = "Onizleme",
            de = "",
        },
    },

    -- ── STEP 5 ────────────────────────────────────────────────────────────────
    [5] = {
        title = {
            en = "Moving & Editing Props",
            tr = "Esya Tasima ve Duzenleme",
            de = "Objekte verschieben und bearbeiten",
        },
        desc = {
            en = "Open /mycamp, click on a prop in the left panel to select it, then click the MOVE button. This re-enters placement mode for that specific prop. Adjust its position using the same controls as initial placement, then press ENTER to save the new location. The prop retains its installed status after moving.",
            tr = "/mycamp'i acin, sol panelde bir prop'a tiklayin, ardindan TASI dugmesine tiklayin. Bu, o belirli prop icin yerlestirme modunu yeniden baslatir. Ayni kontrolleri kullanarak konumunu ayarlayin, ardindan yeni konumu kaydetmek icin ENTER'a basin. Prop, tasindiktan sonra kurulu durumunu korur.",
            de = "Oeffne /mycamp, klicke auf ein Objekt im linken Panel zur Auswahl, dann klicke auf VERSCHIEBEN. Dies startet den Platziermodus fuer dieses spezifische Objekt neu. Passe seine Position mit denselben Steuerungen wie bei der ersten Platzierung an, dann druecke ENTER, um den neuen Ort zu speichern. Das Objekt behaelt seinen installierten Status nach dem Verschieben.",
        },
        images = {"https://upload.fixitfy.com.tr/images/FIXITFY-iGdqYkRa83Aw.gif"},
        caption = {
            en = "Preview",
            tr = "Onizleme",
            de = "",
        },
    },

    -- ── STEP 6 ────────────────────────────────────────────────────────────────
    [6] = {
        title = {
            en = "Removing Props",
            tr = "Esya Kaldirma",
            de = "Objekte entfernen",
        },
        desc = {
            en = "Open /mycamp, select a prop from the left panel, and click REMOVE. The item will be deleted from your camp and returned to your inventory. Note: removing the last prop from a camp will permanently delete the entire camp. The base prop (marked with a BASE tag) can only be removed last.",
            tr = "/mycamp'i acin, sol panelden bir prop secin ve KALDIR'a tiklayin. Esya kampinizdan silinecek ve envanterinize iade edilecektir. Not: Kamptan son prop'u kaldirmak tum kampi kalici olarak siler. Temel prop (BASE etiketiyle isaretli) yalnizca en son kaldirabilir.",
            de = "Oeffne /mycamp, waehle ein Objekt aus dem linken Panel und klicke auf ENTFERNEN. Das Objekt wird aus deinem Lager geloescht und in dein Inventar zurueckgegeben. Hinweis: Das Entfernen des letzten Objekts aus einem Lager loescht das gesamte Lager dauerhaft. Das Basisobjekt (mit BASE-Tag markiert) kann nur zuletzt entfernt werden.",
        },
        images = {"https://upload.fixitfy.com.tr/images/FIXITFY-jyldU1IX8kaZ.gif"},
        caption = {
            en = "Preview",
            tr = "Onizleme",
            de = "",
        },
    },


    -- ── STEP 7 ────────────────────────────────────────────────────────────────
    [7] = {
        title = {
            en = "Deleting Your Camp",
            tr = "Kampinizi Silme",
            de = "Dein Lager loeschen",
        },
        desc = {
            en = "Open /mycamp and click the DELETE button (bottom left of the right panel). A confirmation dialog will appear — confirm to permanently delete the camp. WARNING: all placed props and items inside storage chests will be lost forever. This action cannot be undone.",
            tr = "/mycamp'i acin ve SIL dugmesine tiklayin (sag panelin sol alti). Bir onay iletisim kutusu gorunecektir — kampi kalici olarak silmek icin onaylayin. UYARI: Tum yerlestirilen prop'lar ve depolama sandiklari icindeki esyalar sonsuza kadar kaybolur. Bu islem geri alinamaz.",
            de = "Oeffne /mycamp und klicke auf die LOESCHEN-Schaltflaeche (unten links im rechten Panel). Ein Bestaetigungsdialog erscheint -- bestaetigen, um das Lager dauerhaft zu loeschen. WARNUNG: Alle platzierten Objekte und Gegenstaende in Lagerkisten gehen fuer immer verloren. Diese Aktion kann nicht rueckgaengig gemacht werden.",
        },
        images = {"https://upload.fixitfy.com.tr/images/FIXITFY-D3R11Rih1zwk.gif"},
        caption = {
            en = "Preview",
            tr = "Onizleme",
            de = "",
        },
    },
    -- ── STEP 8 ────────────────────────────────────────────────────────────────
    [8] = {
        title = {
            en = "Move Camp & Wagons",
            tr = "Kamp ve Wagon Tasima",
            de = "Lager und Wagen verlegen",
        },
        desc = {
            en = "Open /mycamp and click the MOVE CAMP button. A wagon will spawn near your camp — all placed props and storage chest contents are automatically packed into the wagon's stash. Ride the wagon to your desired location, then open /mycamp and click UNPACK to deploy the camp at the new spot. Uninstalled props are returned directly to your inventory instead.",
            tr = "/mycamp'i acin ve KAMPI TASI dugmesine tiklayin. Kampinizin yakinina bir wagon belirecek — tum yerlestirilen prop'lar ve depolama sandigi icerikleri otomatik olarak wagon'un stash'ine aktarilir. Wagon'u istediginiz yere goturun, ardindan /mycamp'i acip PAKETI AC'a tiklayin ve kampi yeni konumda kurun. Kurulmamis prop'lar ise dogrudan envanterinize iade edilir.",
            de = "Oeffne /mycamp und klicke auf LAGER VERLEGEN. Ein Wagen erscheint in der Naehe deines Lagers -- alle platzierten Objekte und Lagerkisteninhalte werden automatisch in den Stauraum des Wagens gepackt. Fahre den Wagen zum gewuenschten Ort, oeffne dann /mycamp und klicke auf AUSPACKEN, um das Lager am neuen Ort aufzubauen. Nicht installierte Objekte werden direkt in dein Inventar zurueckgegeben.",
        },
        images = {"https://upload.fixitfy.com.tr/images/FIXITFY-77Hiw6kRJXjN.gif"},
        caption = {
            en = "Preview",
            tr = "Onizleme",
            de = "",
        },
    },

    -- ── STEP 9 ────────────────────────────────────────────────────────────────
    [9] = {
        title = {
            en = "Adding Members to Your Camp",
            tr = "Kampa Uye Ekleme",
            de = "Mitglieder zum Lager hinzufuegen",
        },
        desc = {
            en = "Open /mycamp and click the MEMBERS button (bottom of the left panel). You can add a player by typing their Server ID in the input field, or click the + button next to a nearby player shown in the Nearby Players list. Members appear in the members list. As the owner you can edit or remove them at any time.",
            tr = "/mycamp'i acin ve UYELER dugmesine tiklayin (sol panelin alti). Giris alanina bir oyuncunun Server ID'sini yazarak ekleyebilir ya da Yakin Oyuncular listesinde gorunen bir oyuncunun yanindaki + dugmesine tiklanilabilirsiniz. Uyeler, uye listesinde gorunur. Sahip olarak onlari istediginiz zaman duzenleyebilir veya kaldirabilirsiniz.",
            de = "Oeffne /mycamp und klicke auf die MITGLIEDER-Schaltflaeche (unten im linken Panel). Du kannst einen Spieler hinzufuegen, indem du seine Server-ID in das Eingabefeld tippst, oder klicke auf die +-Schaltflaeche neben einem nahegelegenen Spieler in der Naehe-Spieler-Liste. Mitglieder erscheinen in der Mitgliederliste. Als Besitzer kannst du sie jederzeit bearbeiten oder entfernen.",
        },
        images = {"https://upload.fixitfy.com.tr/images/FIXITFY-J8ymohzZ0Ly5.gif"},
        caption = {
            en = "Preview",
            tr = "Onizleme",
            de = "",
        },
    },

    -- ── STEP 10 ───────────────────────────────────────────────────────────────
    [10] = {
        title = {
            en = "Member Permissions",
            tr = "Uye Yetkileri",
            de = "Mitgliederberechtigungen",
        },
        desc = {
            en = "Each member can be granted specific permissions:\n• Camp Admin — all permissions (full access)\n• Access Storage — can open camp chests\n• Access Camp Menu — can open /mycamp\n• Manage Members — can add or remove other members\n• Move Camp — can pack and relocate the camp wagon\n• Place Props — can place new items from their inventory\n• Remove Props — can delete placed props\nClick the pencil icon next to a member to edit their permissions.",
            tr = "Her uyeye belirli yetkiler verilebilir:\n• Kamp Admini — tum yetkiler (tam erisim)\n• Depolama Erisimi — kamp sandiklarina erisebilir\n• Kamp Menusu Erisimi — /mycamp'i acabilir\n• Uye Yonetimi — diger uyeleri ekleyebilir veya kaldirabilir\n• Kamp Tasima — kamp arabasini paketleyebilir ve yeniden konumlandirabili\n• Esya Yerlestirme — envanterinden yeni esyalar yerlestirebilir\n• Esya Kaldirma — yerlestirilen prop'lari silebilir\nYetkilerini duzenlemek icin uyenin yanindaki kalem ikonuna tiklayin.",
            de = "Jedem Mitglied koennen bestimmte Berechtigungen gewaehrt werden:\n* Lageradmin -- alle Berechtigungen (voller Zugriff)\n* Lager Zugriff -- kann Lagerkisten oeffnen\n* Lagermenue Zugriff -- kann /mycamp oeffnen\n* Mitglieder verwalten -- kann andere Mitglieder hinzufuegen oder entfernen\n* Lager verlegen -- kann den Lagerwagen packen und verlagern\n* Objekte platzieren -- kann neue Objekte aus seinem Inventar platzieren\n* Objekte entfernen -- kann platzierte Objekte loeschen\nKlicke auf das Stiftsymbol neben einem Mitglied, um seine Berechtigungen zu bearbeiten.",
        },
        images = {"https://upload.fixitfy.com.tr/images/FIXITFY-8Y0eadIh761T.gif"},
        caption = {
            en = "Preview",
            tr = "Onizleme",
            de = "",
        },
    },
}
