
==================================================

			--= SIREVLC DEBUG TOOL =--

==================================================

LINK: [INSERT LINK]
GUIDE LINK:  https://www.sirevlc.com/debug-tool-guide

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

## 6. Required resources:
- `sire_menu`
- `sirevlc_notifications`
- `sirevlc_debug_tool`
 
⚠️ Use an archive extractor such as **WinRAR** and ftp software such as Winscp. Make sure it's transfer mode is in **BINARY MODE**.
Ensure the **.fxap files** are correctly imported for:
- `sirevlc_debug_tool`
 
`.fxap` files are required for **cfx.re authentication**.

## 7. Ensure resources in the correct order
In your `server.cfg` or `resources.cfg`, ensure the resources in the following order:

```cfg
ensure oxmysql
ensure <your framework resources>

ensure sire_menu
ensure sirevlc_notifications
ensure sirevlc_debug_tool
 ````

⚠️ **Important:**

* `sire_menu` **must be ensured before** all other sire resources.
* Do **not** ensure these resources as subfolders, as this can break the ensure order.
 
## 8. Enjoy! 
 
 
=================================================

				--REQUIREMENTS--

==================================================

x- REDEMRP REBOOT/VORP/RSG frameworks
x- sire_menu 
x- oxmysql
x- sirevlc_notifications (provided with resource)

