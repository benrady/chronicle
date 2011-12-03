
Chronicle makes it easy for Pathfinder Society GM's to collect player info and generate chronicle sheets right from the scenario PDFs.

# Installation:

Chronicle requires JRuby 1.5 and various gems. The docsplit gem requires GraphicsMagick and Poppler to be installed. If you do not have these installed, first install the <code>graphicsmagick</code> and <code>poppler</code> packaged. I used brew to do this by running:

$ brew install graphicsmagick poppler

Once you have these packages installed, then installing the chronicle gem should be as easy as:

$ gem install chronicle

# Setup:

To sign and initial your chronicle sheets, you'll need create two images: <code>signature.png</code> and <code>initials.png</code>. These files must be placed in your home directory under the <code>.chronicle</code> subdirectory. The signature file should be 500x100 and the initials file should 100x100. Both should be 300dpi.

# Usage:

I organize the scenarios I play into directories (folders). Each directory contains the scenario PDF as well as the other materials I use to run the session. All the chronicle commands listed below are run from a directory such as this. 

## Preparing to Play

0. Open a terminal and change to your scenario directory.
0. Run <code>chron-prepare AScenarioFile.pdf</code>. This should 

## Creating an Online Signup Form
0. First, [click here to create](https://docs.google.com/previewtemplate?id=0Ann48md_Q6mkdGtocUJ4NVZhQjVSdWRidzUtU3dKOHc&mode=public) a simple online signup form for your session.
0. Give your signup form a name and a description and hit "Save". 
0. Click "See responses"->"Spreadsheet", and select the "ScenarioMetadata" sheet
0. If you haven't already, [register your event at paizo.com](https://secure.paizo.com/pathfinderSociety/myAccount/eventCoordinator) and use the information provided to fill in the "ScenarioMetadata" sheet
0. Click "Form"->"Go to live form". Copy the signup form URL, and fill out the form once for the character you plan to give your GM reward to.
0. You can now publish the signup form URL to let people know how to sign up for your session. Consider updating the URL field for the event on paizo.com.

## Generating Chronicle Sheets
0. Go to https://docs.google.com and open your registration form spreadsheet.
0. Select the "ChronicleSheetInfo" sheet and fill in the results of the scenario in columns D through G
0. Click "File"->"Download As..."->"CSV (Current Sheet)". Save this file to the "rosters" subdirectory in your scenario directory.
0. Open a terminal and change to your scenario directory.
0. Run <code>chron-finish rosters/[new roster file].csv</code>. If you want to generate your sheets to a different directory, you can pass that as the second parameter.

Done! A chronicle sheet for each character (including your GM reward character) should
I like to create a folder for each scenario I regularly GM. In this folder, I keep the scenario pdf, as well as other materials such as the maptools campaign, pogs, maps and other images. The chronicle gem will generate a chronicle sheet


Then you can create a simple online signup form by using the template here:

When you finish playing the scenario, fill in the rest of the data in the form (XP, gold, etc..). Then, download the "ChronicleSheetInfo" sheet in the google doc as a CSV file and save in your scenario folder under "rosters".

If you need to mark out any items that the players did not earn, open up your favorite image editor and mark up chronicle_sheet.png. 

Finally, when you're ready to generate the chronicle sheets, run:

chron-finish rosters/PathfinderRemoteSession-1-12-2012.csv

and a sheet for each character will be generated in ChronicleSheets
