# OCCS Wizard 
The **OCCS Wizard** is a **Ruby** gem that allows you to create **widgets / extensions** based project structures to extend **[Oracle Commerce Cloud Service](https://cloud.oracle.com/en_US/commerce-cloud)** out-of-the-box functionalities.

## How to use install the gem

```javascript
sudo gem install occs-wizard-1.0.0.gem
```
Once executed the above command you should get the below message:

```javascript
Successfully installed occs-wizard-1.0.0
Parsing documentation for occs-wizard-1.0.0
Installing ri documentation for occs-wizard-1.0.0
Done installing documentation for occs-wizard after 0 seconds
1 gem installed
```
If you see the above result in your command line, you are now ready to use it.

**NOTE:** You need an extension ID, it can be retrieved directly from your **Oracle Commerce Cloud instance**.

**NOTE:** This is the list of values you need to pass to the wizard gem when executed

```javascript
{
  "extensionID": "EXTENSIONID-KEY",
  "developerID": "12345678",
  "createdBy": "Valerio D'Alessio",
  "name": "servicerequest",
  "version": 1,
  "timeCreated": "2018-03-01",
  "description": "Open a service request to Oracle Service Cloud"
}
```
**NOTE:** You can use the official [Oracle Commerce Cloud Service Widget Development Guide](http://docs.oracle.com/cd/E65426_01/Cloud.15-3/WidgetDev/html/s0201developacustomwidget01.html) as reference.

## How to use it

Open a new terminal session and type"

```javascript
irb
```
Once the new **irb** session has been loaded you must require the gem using the below command:

```javascript
require 'occs-wizard'
```
This will automatically lunch the gem and now you can provide the mandatory fields in order to create you Oracle Commerce Cloud widget/extension based project.

```javascript
.:: OCCS Widget Wizard ::.

Please have a look at the Oracle Commerce Cloud official documentation for more info
https://goo.gl/i5d6us

Please enter the extension id: 
```
Once the wizard process is completed the gem will create a project structure for a new OCCS extension and the mandatory folders and files will be saved on your HDD.
The last thing you must do is simply **zip** the **widget** folder and the **ext.json** file and you will be ready to upload the **.zip archive** to your OCCS instance.

For more information about Oracle Commerce Cloud custom widget development please read the following doc:

[OCCS Custom Widgets](https://docs.oracle.com/cd/E65426_01/Cloud.15-3/WidgetDev/html/s0201developacustomwidget01.html)

## License

Licence detail about the use of this project is available at the following [URL](https://github.com/valdal14/From-CommerceCloud-To-ServiceCloud/blob/master/LICENSE)