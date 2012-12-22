Chronicle makes it easy for Pathfinder Society GM's to collect player info and generate chronicle sheets.

# Installation:

First, [download the latest release here](https://s3.amazonaws.com/chronicle.windycitypathfinder.com/chronicle.jar). Then just run the jar (double click on it, or run `java -jar chronicle.jar`).

Chronicle requires Java. If you don't have Java installed, try [getting it here](http://java.com/en/download/index.jsp). Once you have Java installed, just double click on chronicle.jar to run it.

# Setup:

To sign and initial your chronicle sheets, you'll need create two images: `signature.png` and `initials.png`. These files must be placed in your home directory under the `.chronicle` subdirectory. The signature file should be 500x100 and the initials file should 100x100. Both should be 300dpi.

## Creating an Online Signup Form
0. First, [click here to create](https://docs.google.com/previewtemplate?id=0Ann48md_Q6mkdGtocUJ4NVZhQjVSdWRidzUtU3dKOHc&mode=public) a simple online signup form for your session.
0. Give your signup form a name and a description and hit "Save". 
0. Click "See responses"&rarr;"Spreadsheet", and select the "ScenarioMetadata" sheet
0. If you haven't already, [register your event at paizo.com](https://secure.paizo.com/pathfinderSociety/myAccount/eventCoordinator) and use the information provided to fill in the "In Play" sheet
0. Click "Form"&rarr;"Go to live form". Copy the signup form URL, and fill out the form once for the character you plan to give your GM reward to.
0. You can now publish the signup form URL to let people know how to sign up for your session. Consider updating the URL field for the event on paizo.com.

## Filling Out the Chronicle Sheet
0. Go to https://docs.google.com and open your registration form spreadsheet.
0. Select the "Signups" sheet and review the information to ensure it is correct.
0. Select the "ChronicleSheetInfo" sheet and fill in the results of the scenario in columns D through G
0. Click "File"&rarr;"Download As..."&rarr;"CSV (Current Sheet)".
0. Run chronicle and load the chronicle sheet and roster. 
0. Click and drag the mouse to draw on the sheet and indicate subtier, or check off boons.
0. Hit "Generate Sheets" and choose a directory to output to.

Done! A chronicle sheet for each character (including your GM reward character) should have been created in the directory you selected.

## Formatting Notes

Chronicle is still a little rough, and it a bit particular about the formatting of values in the CSV. This is especially true for the items bought/sold list. Each item in the list should take the form of:

    <item description> (amount)(units)
    
For example, a wayfinder could be listed as: "Standard Wayfinder 250gp". Units can be one of "gp", "sp", or "cp". For things that cost prestige, I generally note that in the description and list the cost as 0gp. 

## Notes for Programmers

Run `warble` to generate the jar file. You will have to install the "warbler" gem first (version 1.3.5)

### About Chronicle

Chronicle was written by Ben Rady, and is distribuited under the MIT License

Copyright (c) 2012 Ben Rady <benrady@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

