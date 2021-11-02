# Oracle APEX Plug-In: Image Zoom

A plug in to enlarge a image using lens or mirror (glass). Credits goes to **W3schools**.

Demo Application: https://apex.oracle.com/pls/apex/f?p=133110:9999::BRANCH_TO_PAGE_ACCEPT::9999:P9999_APP_PAGE_REDIRECT:12

# Prerequisite:

**DB versions:**	12.1.0.1,12.2.0.1,18.4.0.0,19.0.0.0.0,19.2.0.0.19,21.0.0.0.0,21.1.0.0.0,21.1.0.0.1

**APEX versions**	20.1.0.00.13,20.2.0.00.20,21.1.0

# Installation:

Export plugin file **"item_type_plugin_orclking_image_zoom.sql"** from source directory and import it into your application.

# Steps to Achieve:

**Step 1:** Export plugin file **"item_type_plugin_orclking_image_zoom.sql"** from Source directory and import it into your application.

**Navigation:** Shared Components ==> Plug-ins ==> Import

![image](https://user-images.githubusercontent.com/85283603/139847375-c02f9170-faaa-4bac-a51f-bab93290007d.png)

Plugin will be listed under plug-ins bucket after successful installation.

![image](https://user-images.githubusercontent.com/85283603/139847295-b0b652ef-0819-423c-8ed3-c114ff9b7d40.png)

**Step 2:** Create a new blank page.

**Step 3:** Create a new region to the page.

![image](https://user-images.githubusercontent.com/85283603/139847581-693612e5-9514-463e-bffe-2af4a2e9bc15.png)

**Step 4:** Create a item to the region and change the item type to **Image Zoom [Plug-In]**.

![image](https://user-images.githubusercontent.com/85283603/139847971-5e6c17c7-e619-40ca-af0b-2e0445d65ddf.png)

![image](https://user-images.githubusercontent.com/85283603/139847879-49e4fbd2-71c2-45a8-9612-6f8507b4bfcc.png)

**Note:** You can define image url using page item or direct image link.
 
 **Step 5:** Fill required attributes
 
![image](https://user-images.githubusercontent.com/85283603/139847879-49e4fbd2-71c2-45a8-9612-6f8507b4bfcc.png)

1) Image Link
2) Image Width
3) Image Height
4) Glass Color
5) Glass Size
 
 **Output:** Then you output would display like this,
 
 ![image](https://user-images.githubusercontent.com/85283603/139848238-53021e8c-0b03-42d0-ad0f-54e0f0f29d0f.png)
  
That's it.

Happy APEXing!!!...

# References:

https://www.w3schools.com/howto/howto_js_image_zoom.asp
