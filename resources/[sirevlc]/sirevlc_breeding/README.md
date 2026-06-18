
==================================================

			--= SIREVLC BREEDING =--

==================================================

LINK: https://sire-vlc-scripts.tebex.io/package/6987594
GUIDE LINK: https://sirevlc.com

=================================================

				--INSTALLATION--

=================================================
 
### Installation Instructions
 
## 1. Link your server to CFX Portal
Make sure your server is properly linked to your **CFX Portal** account.

## 2. Install oxmysql
Ensure **oxmysql** is installed and working correctly on your server.
 
## 3. Download sire_menu
Download **sire_menu** from the Tebex email or from our Discord file section.  
 
## 4. Download notifications resource and images
Download **sirevlc_notifications** and the **images provided via Tebex email**.  
The images are also available in our Discord file channel.

## 5. Download required granted assets (cfx.re portal)
From your **cfx.re portal → Granted Assets**, download the required resources.  
Make sure you are using the **correct versions for your framework**, then place them directly into your server’s **resources folder**.

### Required resources:
- `sire_menu`
- `sirevlc_notifications`
- `sirevlc_horses`
- `sirevlc_horses_interactions`
- `sirevlc_breeding`

⚠️ Use an archive extractor such as **WinRAR** and ftp software such as Winscp. Make sure it's transfer mode is in **BINARY MODE**.
Ensure the **.fxap files** are correctly imported for:
- `sirevlc_horses`
- `sirevlc_horses_interactions`
- `sirevlc_breeding`

`.fxap` files are required for **cfx.re authentication**.

## 7. Ensure resources in the correct order
In your `server.cfg` or `resources.cfg`, ensure the resources in the following order:

```cfg
ensure oxmysql
ensure <your framework resources>

ensure sire_menu
ensure sirevlc_notifications
ensure sirevlc_horses
ensure sirevlc_horses_interactions
ensure sirevlc_breeding
````

⚠️ **Important:**
* `sire_menu` **must be ensured before** all other sire resources.
* Do **not** ensure these resources as subfolders, as this can break the ensure order.

## 8. Import the cooldown sql file
Import `breeding_system_cooldown.sql` into your database and confirm that your database is properly linked to your server.

## 9. Enjoy! 🐎
 

=================================================

				--REQUIREMENTS--

==================================================
x- REDEMRP REBOOT/VORP/RSG frameworks
x- sire_menu 
x- sirevlc_horses
x- sirevlc_notifications (provided with resource)
x- oxmysql


