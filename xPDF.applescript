-- xPDF.applescript
-- xPDF 2.0

--  Created by Tom-Marius Olsen on 29.04.05, updated 06.11.06
--  Copyright 2006 Tom-Marius Olsen. All rights reserved.


--#### NOTES ####--
(*
	#Table reordering
	The allow reordering feature of the NSTable dose'nt work. This might is beacause the drag `n dop is enabled, i haven«t found a workaround for this yet. 
	It's possible that it will work if I use a OutlineView insted of a TableView, but I havent tryed that yet
	CODE: set allows reordering of table view "fileList" of scroll view "files" of window "main" to true	
	
	#Lauch panel 
	When the application launches the awake from nib will not complete until the launching of InDesign is complete
	I have made a progressbar to display while ID cs2 launches, but for some reason the progressbar will not initiate either...
	Update. I have now messed about with different application handlers as "on launch" and "on will launch" and tried placing the 
	startingcode for the progress indicator in a handler called before any request to ID cs2 is made. But this dose'nt seem to work either
*)

--#### Global vars go here ####--
--> This is the name of the users startdisk, the var is assigned to it on the "awake from nib" handler
global startDisk

--> This is an incremental used only when having multiple documents with multiple pages doing an incremental page extract.
--> We need this to stick through several functions, so this seems like a god place to store it.
global runIncremental

--> Create the globals that will contain the data from the plist
--> prefLeadingZero contains a boolean who dertermins wheter to use a leading zero in front of incrementals/pagenumbers less than 10
global prefLeadingZero
--> prefReplaceFiles contains a boolean who determins wheter to replace allready existing files
global prefReplaceFiles
-->prefScriptTimeout is a number containing the number of minutes the applescript timeout is set to.
global prefScriptTimeout

--##################--
--##### ON LAUNCH #####--
--##################--

on will finish launching theObject
	--> Display a progress bar while booting
	display panel window "lanchPanel" attached to window "main"
	tell progress indicator "launcher" of window "lanchPanel" to start
	tell progress indicator "launcher" of window "lanchPanel" to set indeterminate to true
	
	--> Create the extra entrys in the plist file. ***If these are ignores if they allready are set.
	make new default entry at end of default entry of user defaults with properties {name:"prefLeadingZero", contents:true}
	make new default entry at end of default entry of user defaults with properties {name:"prefReplaceFiles", contents:true}
	make new default entry at end of default entry of user defaults with properties {name:"prefScriptTimeout", contents:"30"}
	
	--> Set the global variables from the plist file
	set prefLeadingZero to contents of default entry "prefLeadingZero" of user defaults
	set prefReplaceFiles to contents of default entry "prefReplaceFiles" of user defaults
	set prefScriptTimeout to contents of default entry "prefScriptTimeout" of user defaults
end will finish launching

--#### When the application launches  ####--
on awake from nib theObject
	--#### Make the toolbar ####--
	--> Make the new toolbar, giving it a unique identifier
	set documentToolbar to make new toolbar at end with properties {name:"document toolbar", identifier:"document toolbar identifier", allows customization:true, auto sizes cells:false, display mode:default display mode, size mode:default size mode}
	
	--> Setup the allowed and default identifiers.
	set allowed identifiers of documentToolbar to {"make item identifier", "remove item identifier", "removeAll item identifier", "check errors identifier", "options item identifier", "customize toolbar item identifer", "flexible space item identifer", "space item identifier", "separator item identifier"}
	set default identifiers of documentToolbar to {"remove item identifier", "removeAll item identifier", "check errors identifier", "options item identifier", "flexible space item identifer", "make item identifier"}
	
	--> Create the toolbar items, adding them to the toolbar.
	make new toolbar item at end of toolbar items of documentToolbar with properties {identifier:"remove item identifier", name:"remove item", label:"Remove", palette label:"Remove", tool tip:"Remove from list", image name:"ico_remove"}
	make new toolbar item at end of toolbar items of documentToolbar with properties {identifier:"removeAll item identifier", name:"removeAll item", label:"Remove all", palette label:"Remove All", tool tip:"Remove all from list", image name:"ico_removeall"}
	make new toolbar item at end of toolbar items of documentToolbar with properties {identifier:"options item identifier", name:"options item", label:"PDF Options", palette label:"PDF Options", tool tip:"Open PDF options", image name:"ico_drawer"}
	make new toolbar item at end of toolbar items of documentToolbar with properties {identifier:"make item identifier", name:"make item", label:"Create PDF", palette label:"Create PDF", tool tip:"Create PDF files", image name:"ico_makepdf"}
	make new toolbar item at end of toolbar items of documentToolbar with properties {identifier:"check errors identifier", name:"check errors", label:"Check errors", palette label:"Check errors", tool tip:"Check files for errors", image name:"ico_checkerror"}
	
	--> Assign our toolbar to the window
	set toolbar of theObject to documentToolbar
	
	--#### Open the drawer with the options ####--
	tell window "main"
		tell drawer "drawer" to open drawer on right edge
	end tell
	
	--#### Alter the UI ####--
	--> Dissallow the user to choose basename and page-extract. 
	set editable of text field "tf_baseName" of box "options" of drawer "drawer" of window "main" to false
	set enabled of matrix "rg_extractPagesSuffix" of box "options" of drawer "drawer" of window "main" to false
	
	--#### Set the name of the basedisk ####--
	tell application "Finder"
		set startDisk to startup disk as string
		set the startDisk to (characters 1 thru ((number of characters of startDisk) - 1) of startDisk) as string
	end tell
end awake from nib

on launched theObject
	--#### Launch Adobe InDesign CS2 ####--
	try
		--#### Populate the drop-downmenu with the PDF presets from InDesign ####--
		--> Get the all the presets from InDesign
		tell application "Adobe InDesign CS2"
			--> Get the presets into a list
			set PDFpresetList to name of every PDF export preset as list
			-->Get number of items in the list
			set numOfPreset to (number of items of PDFpresetList)
		end tell
	on error
		display alert "Sorry..." as warning message "xPDF can't locate Adobe InDesign CS2." & (ASCII character 10) & "Try visiting our webpage at" & (ASCII character 10) & "http://www.creatordesign.no/xpdf/" default button "Ok" attached to window "main"
	end try
	
	--> First we need to make sure there the combobox is empty, to do this we need to delete all the menu items in it.
	delete every menu item of menu of popup button "PDFPresetList" of window "main"
	--> then add all our new menu items to the combobox based on the list we retrived
	repeat with i from 1 to numOfPreset
		make new menu item at the end of menu items of menu of popup button "PDFPresetList" of window "main" with properties {title:(item i of PDFpresetList), enabled:true}
	end repeat
	
	my updatedSummary(item 1 of PDFpresetList)
	
	--> Its is now safe to remove the launchpanel
	close panel window "lanchPanel"
	
end launched


--################--
--##### TOOLBAR #####--
--################--

--#### This event handler is called when the user clicks on one of the toolbar items ####--
--> theObject used is the identifier of the butten pressed
on clicked toolbar item theObject
	--#### If the make PDF button is pressed ####--
	if identifier of theObject is "make item identifier" then
		--> The golbal runIncremental must be reset every time we try to run the batchprocess
		set runIncremental to 0
		
		--> First check if there are any files in the list, if not we need to display a error message
		set fileListChecknum to number of data rows of data source of table view "fileList" of scroll view "files" of window "main"
		if fileListChecknum is equal to 0 then
			display alert "No files added!" as warning message "Please add some InDesignfiles to the list first." default button "Ok" attached to window "main"
			--> Return false to exit rest of the script
			return false
		end if
		
		--#### Set the values from the options box ####--
		--> Set the value for savinglocation as a boolean value
		set saveLocationCheck to contents of button "cb_chooseSave" of box "options" of drawer "drawer" of window "main" as boolean
		--> Set the value for basename as a boolean value
		set baseNameCheck to contents of button "cb_baseName" of box "options" of drawer "drawer" of window "main" as boolean
		--> Set the value for basename text as a string value
		set baseNameText to contents of text field "tf_baseName" of box "options" of drawer "drawer" of window "main" as string
		--> Set the value for page extraction as a boolean value
		set extractPagesCheck to contents of button "cb_extractPages" of box "options" of drawer "drawer" of window "main" as boolean
		--> Set the type of suffix for the pagesextraction
		set extractPagesType to current row of matrix "rg_extractPagesSuffix" of box "options" of drawer "drawer" of window "main" as number
		--> Set the value for missing images as a boolean value
		set missingImagesCheck to contents of button "cb_missingImages" of box "options" of drawer "drawer" of window "main" as boolean
		--> Set the value for missing fonts as a boolean value
		set missingFontsCheck to contents of button "cb_missingFonts" of box "options" of drawer "drawer" of window "main" as boolean
		--> Set PDF-export preset to use
		set PDFExportPreset to title of popup button "PDFPresetList" of window "main" as string
		
		--#### Open the savepanel ####--
		--> If the value of the savingloaction is set to true we display the sanvinglocaition panel
		if saveLocationCheck then
			--> Set the attributes for the savepanel
			tell open panel
				--> Set the title of the window
				set title to "Choose a folder"
				--> Set the name of the button
				set prompt to "Save"
				--> Dissallow packagebrowsing
				set treat packages as directories to false
				--> Allow the user to choose a folder
				set can choose directories to true
				--> Dissallow the user to choose a file
				set can choose files to false
				--> Dissallow the user to select multipel selections
				set allows multiple selection to false
			end tell
			--> Display the savepanel and set the var withResult
			set saveResult to display open panel
		else
			--> Even if the savepanel dosen't appear we still whant to contiue. Because this only means that the savelocation is not to be choosen
			set saveResult to 1
		end if
		
		--#### Set path returned from the savepanel ####--
		if saveResult is 1 then
			if saveLocationCheck then
				-- For some unknown (as of yet) you must coerce the 'path names' to a list (even though it is defined as list).
				set the saveFolder to (path names of open panel as list)
				set AppleScript's text item delimiters to "/"
				set the saveFolder to startDisk & saveFolder & ":" as string
				set AppleScript's text item delimiters to ""
			else
				--> If saveLocationCheck is set to false we create a empty variable to store the saveFoler beacuse we still need to pass it into the createPDF function
				set saveFolder to ""
			end if
			
			--#### Open the prgress panel ####--
			--> Open the progressbar window attached to the main window
			display panel window "progressPanel" attached to window "main"
			tell progress indicator "progress" of window "progressPanel" to set indeterminate to false
			
			--#### Set the datasources for the values in the NSTable ####--
			-->Create a new datasource containing all the files in the NSTable.
			set fileListSource to data source of table view "fileList" of scroll view "files" of window "main"
			--> Retrive the complete paths & filenames from the NSTable
			set thePaths to contents of data cell "path" of data rows of data source of table view "fileList" of scroll view "files" of window "main"
			set theFiles to contents of data cell "files" of data rows of data source of table view "fileList" of scroll view "files" of window "main"
			
			--#### Count the number of pages in the NSTabel ####--
			--> Set the number of files in the NSTable
			set numOfFiles to number of data rows of data source of table view "fileList" of scroll view "files" of window "main"
			
			--> Set the var for containing the total number of pages to be desilled
			set totalPages to 0
			
			--> Count up all the pages to be destilled, this will be used to make the progressbar 
			repeat with count_i from 1 to numOfFiles
				--> For each loop the var totalPages equals the previous totalPages pluss the current
				set open_document to startDisk & item count_i of thePaths as string
				--> Indesign does not understand the "/" delimiters, so we need to replace them with ":"
				set open_document to (my makeColonpath(open_document)) as string
				set totalPages to totalPages + (my countPages(open_document))
			end repeat
			
			--#### Initiate the progressbar ####--
			--> Now that we know the number of pages the need to be distilled we can initiate the progressbar
			my initiatePorgress(totalPages)
			
			--#### This is the main loop that loopes through all the files NSTable and executes the createPDF function ####--
			-->The loop is based on the number of files in out NSTable
			repeat with i from 1 to numOfFiles
				--#### Set the path to the document to open. InDesign does not understand the "/" delimiters, so we need to replace them with ":" ####--
				set openDocument to startDisk & item i of thePaths as string
				-->Debug display dialog (item i of thePaths as string) default button "ok"
				set openDocument to (my makeColonpath(openDocument)) as string
				
				--#### Set the path to the documents savinglocation ####--
				--> If the baseNameCheck is set to false we need to get the folder whitch contains the current document
				if not saveLocationCheck then
					--> Get the number of characters in the filename
					set length_filename to number of characters of item i of theFiles as number
					--> Remove the filename from the filepath to get path to the parent folder
					set saveFolder to startDisk & (characters 1 thru ((number of characters of item i of thePaths) - length_filename) of item i of thePaths) as string
					--> Create a colon separeted filepath 
					set saveFolder to (my makeColonpath(saveFolder)) as string
				else
					--> Create a colon separeted filepath 
					set saveFolder to (my makeColonpath(saveFolder)) as string
				end if
				
				if (my createPDF(openDocument, saveFolder, PDFExportPreset, baseNameCheck, baseNameText, extractPagesCheck, extractPagesType, missingImagesCheck, missingFontsCheck, i)) is true then
					--> If the createPDF returns true, the destilling was a success so we set the icon in the NSTabel to green
					set contents of data cell "icon" of data row i of fileListSource to load image "ico_green"
				else
					--> If the createPDF returns false, the destilling was a failure so we set the icon in the NSTabel to red
					set contents of data cell "icon" of data row i of fileListSource to load image "ico_red"
				end if
			end repeat
			
			--> Since we are done, close the status panel
			close panel window "progressPanel"
		end if
		
		--#### If the Options selected  button is pressed ####--
	else if identifier of theObject is "options item identifier" then
		--> Set the cirrent state of the drawer
		set currentDrawerState to state of drawer "drawer" of window "main"
		--> If the drawer is closed open it and vice versa
		if currentDrawerState is equal to drawer closed or currentDrawerState is equal to drawer closing then
			tell drawer "drawer" of window "main" to open drawer
		else if currentDrawerState is equal to drawer opened or currentDrawerState is equal to drawer opening then
			tell drawer "drawer" of window "main" to close drawer
		end if
		
		--#### If the Remove selected  button is pressed ####--
	else if identifier of theObject is "remove item identifier" then
		--> Call function to remove selected items from the list
		my removeSelected()
		
		--#### If the Remove all button is pressed ####--
	else if identifier of theObject is "removeAll item identifier" then
		--> Call function to remove all items from the list
		my removeAll()
		
		--#### If the Check errorbutton button is pressed ####--
	else if identifier of theObject is "check errors identifier" then
		--> Call function to check errors in all items from the list
		
		--#### Open the prgress panel ####--
		--> Open the progressbar window attached to the main window
		display panel window "progressPanel" attached to window "main"
		tell progress indicator "progress" of window "progressPanel" to set indeterminate to false
		
		--#### Set the datasources for the values in the NSTable ####--
		-->Create a new datasource containing all the files in the NSTable.
		set fileListSource to data source of table view "fileList" of scroll view "files" of window "main"
		--> Retrive the complete paths & filenames from the NSTable
		set thePaths to contents of data cell "path" of data rows of data source of table view "fileList" of scroll view "files" of window "main"
		set theFiles to contents of data cell "files" of data rows of data source of table view "fileList" of scroll view "files" of window "main"
		
		--#### Count the number of pages in the NSTabel ####--
		--> Set the number of files in the NSTable
		set numOfFiles to number of data rows of data source of table view "fileList" of scroll view "files" of window "main"
		
		--> Set up a default value for the error result
		set errorResult to true
		
		--> Count up all the pages to be destilled, this will be used to make the progressbar 
		repeat with error_i from 1 to numOfFiles
			--> For each loop the var totalPages equals the previous totalPages pluss the current
			set open_document to startDisk & item error_i of thePaths as string
			--> Indesign does not understand the "/" delimiters, so we need to replace them with ":"
			set open_document to (my makeColonpath(open_document)) as string
			
			--> Get the number of characters in the filename
			set length_filename to number of characters of item error_i of theFiles as number
			--> Remove the filename from the filepath to get path to the parent folder
			set saveFolder to startDisk & (characters 1 thru ((number of characters of item error_i of thePaths) - length_filename) of item error_i of thePaths) as string
			--> Create a colon separeted filepath 
			set saveFolder to (my makeColonpath(saveFolder)) as string
			
			--> Open InDesign
			tell application "Adobe InDesign CS2"
				--> Make a new document object, the "without showing window" will set user interaction level to never interact
				set currentDocument to open open_document without showing window
				
				--> Check the documents for missing images and fonts
				if (my checkError(currentDocument, saveFolder, true, true)) is false then
					--> Set the result of errorCheck to a bool
					set errorResult to false
				end if
				
				--> Close the document
				tell currentDocument to close
			end tell
			
			--> If there are any error in the document, we need to label it as red
			if errorResult is true then
				set contents of data cell "icon" of data row error_i of fileListSource to load image "ico_red"
			end if
			
		end repeat
		
		--> Since we are done, close the status panel
		close panel window "progressPanel"
		
	end if
end clicked toolbar item

--#### This event handler is called whenever the state of the toolbar items needs to be changed. ####--
on update toolbar item theObject
	--> We return true in order to enable the toolbar item, otherwise we would return false
	return true
end update toolbar item


--##################--
--##### UI OBJECTS #####--
--##################--

--#### This event handler is called whenever object from the UI attached to this as-file is is clicked ####--
on clicked theObject
	--> Set the name of the object thats been clicked
	set objectIdentifier to name of theObject as string
	
	--#### If the cb_baseName is clicked, we need to update the editable state of tf_baseName ####--
	if objectIdentifier is equal to "cb_baseName" then
		--> Set the value of cb_baseName as a boolean value
		set baseNameCheck to contents of button "cb_baseName" of box "options" of drawer "drawer" of window "main" as boolean
		--> With the result returned from the value of cb_baseName make the tf_baseName editable or not
		if baseNameCheck then
			set editable of text field "tf_baseName" of box "options" of drawer "drawer" of window "main" to true
		else
			set editable of text field "tf_baseName" of box "options" of drawer "drawer" of window "main" to false
		end if
		
		--#### If the cb_extractPages is clicked, we need to update the editable state of rg_extractPagesSuffix ####--
	else if objectIdentifier is equal to "cb_extractPages" then
		--> Set the value of cb_extractPages as a boolean value
		set extractPagesCheck to contents of button "cb_extractPages" of box "options" of drawer "drawer" of window "main" as boolean
		--> With the result returned from the value of cb_extractPages make the rg_extractPagesSuffix editable or not
		if extractPagesCheck then
			set enabled of matrix "rg_extractPagesSuffix" of box "options" of drawer "drawer" of window "main" to true
		else
			set enabled of matrix "rg_extractPagesSuffix" of box "options" of drawer "drawer" of window "main" to false
		end if
	end if
end clicked


--##################--
--##### MAIN MENU #####--
--##################--

--#### Actions for ALL menu items go here ####--
on choose menu item theObject
	--> Set the name of the menu object thats been selected
	set menuIdentifier to title of theObject as string
	
	if menuIdentifier is equal to "Preferences" then
		show window "preferences" in front of window "main"
		
		--#### If the Remove selected menu is selected ####--
	else if menuIdentifier is equal to "Remove" then
		--> Call function to remove selected items from the list
		my removeSelected()
		
		--#### If the Remove all menu is selected ####--
	else if menuIdentifier is equal to "Remove all" then
		--> Call function to remove all items from the list
		my removeAll()
		
		
		(*
		
		This code was excluded due to a bug when trying to re open the main window.
		*)
		--#### If the xPDF menu is selected ####--
	else if menuIdentifier is equal to "xPDF" then
		--> Because the window unloads from the memory when closed, we need to reload the nib file
		load nib "MainMenu"
		--> Now we can show the window again
		show window "main"
		
		--#### If the Online Support menu is selected ####--
	else if menuIdentifier is equal to "Online support" then
		--> Do a try statement to open Safari, if that dosent work, display a message with the webadress
		try
			tell application "Safari"
				--> Bring safari to the front
				activate
				--> Open the webpage
				open location "http://www.creatordesign.no/xpdf/"
			end tell
		on error
			--> If Safari is'nt found we need to display a message
			display alert "Sorry..." as warning message "Try visiting our webpage at" & (ASCII character 10) & "http://www.creatordesign.no/xpdf/" default button "Ok" attached to window "main"
		end try
	else
		--> It the script arrives here we check if our dropdown menu was used
		--> The scope of the list PDFpresetList set in awaken nib can't be accessed from here so we need to reset it
		tell application "Adobe InDesign CS2"
			set PDFpresetList to name of every PDF export preset as list
		end tell
		--> Loop the of presets man match against the list is in the menu 
		repeat with currentPDFpreset in PDFpresetList
			if currentPDFpreset as text is equal to menuIdentifier then
				--> Function for updateing the info in the summary box goes here
				my updatedSummary(currentPDFpreset)
			end if
		end repeat
	end if
end choose menu item


--################--
--#### FUNCTIONS ####--
--################--

--#### Create PDF of indesign document ####--
--> openDocument is a string that must be the full path to the document to open
--> saveFolder is a string to the folder the file is saved to
--> PDFExportPreset is a sting woth the name of the preset to use
--> baseNameCheck is a boolean
--> baseNameText is a string containing the basename text
--> extractPagesCheck is a boolean
--> extractPagesType is a number 1,2
--> missingImagesCheck is a boolean
--> missingFontsCheck is a boolean
--> incremental is a number

--> Returns: true | false based on the success of the creation of the files

on createPDF(openDocument, saveFolder, PDFExportPreset, baseNameCheck, baseNameText, extractPagesCheck, extractPagesType, missingImagesCheck, missingFontsCheck, incremental)
	--> Open InDesign CS2
	tell application "Adobe InDesign CS2"
		
		--> Make a new document object, the "without showing window" will set user interaction level to never interact
		set currentDocument to open openDocument without showing window
		
		--> Update the text in the status panel
		my updateStatusMessage("Exporting " & name of currentDocument)
		
		--> If any of the check error messages are true then call the checkError function
		if missingImagesCheck or missingFontsCheck is true then
			if (my checkError(currentDocument, saveFolder, missingImagesCheck, missingFontsCheck)) is true then
				--> If any errors occur, we need to close the document here, before we return the function false
				tell currentDocument to close
				return false
			end if
		end if
		
		--> The document wil take several directions based on the options from the user
		--> This is the first crossroad and is based on the extractPagesCheck
		if extractPagesCheck then
			repeat with page_i from 1 to (count pages in currentDocument)
				--> Check what kind of incremental to use
				if extractPagesType is 1 then
					--> If extractPagesType is set to 1 we use 
					--> the incremental passed allong the repeat 
					--> pluss the number of pages in the preious file.
					set incremental to (page_i + runIncremental) as number
				else
					--> If the extractPagesType is set to 2, it means we need to use the pagenumber 
					--> and not the incremental passes allong with the function
					set incremental to name of page page_i of currentDocument as number
				end if
				
				--> If the incremental is smaler than 10 we add a leading 0 to the number
				if prefLeadingZero then
					if incremental is less than 10 then
						set incremental to "0" & incremental
					end if
				end if
				
				--> Build the filename based on the value of baseNameCheck
				if baseNameCheck then
					--> Use the basenametext enterd and the incremental to build the fileName
					set fileName to baseNameText & incremental as string
				else
					--> Use the name of the current document and the incremental to build the fileName
					set fileName to name of currentDocument as string
					
					--> Remove extension from the fileName
					set length_extension to the number of characters of the fileName
					set start_extesion to (length_extension - 5) as string
					set fileName to (characters 1 thru start_extesion of the fileName) & incremental as string
				end if
				
				--> Update the text in the status message
				my updateStatusMessage("Exporting " & name of currentDocument & ", page " & page_i & " of " & (count pages in currentDocument))
				
				-->Set the range of the pages to be exported
				set page range of PDF export preferences to name of page page_i of currentDocument
				
				--> Increase the progressbar by 1 because only on pages is exported
				my increaseProgressBar(1)
				
				--> If prefReplaceFiles is set to false we're allowd  to replace files
				if (my fileExists(saveFolder, fileName, name of currentDocument as string, prefReplaceFiles)) is false then
					--> Because the default timeout of Applescript is set to timeout after one minute we need to increase this
					with timeout of (prefScriptTimeout * 60) seconds
						--> Export the page as pdf
						tell currentDocument
							export format PDF type to (saveFolder & fileName & ".pdf") using PDFExportPreset without showing options
						end tell
					end timeout
				else
					--> Close the document
					tell currentDocument to close
					return false
				end if
				
			end repeat
			
			--> Here we need to set the global runIncremental to itself + the number of pages in the current document
			set runIncremental to runIncremental + (count pages in currentDocument)
			
		else
			--> When here we do not need to extract pages
			
			--> If the incremental is smaler than 10 we add a leading 0 to the number
			--> Because we don't need to extract any pages we can use the intremental passed with the function
			if prefLeadingZero then
				if incremental is less than 10 then
					set incremental to "0" & incremental
				end if
			end if
			
			--> Build the filename based on the value of baseNameCheck
			if baseNameCheck then
				--> Use the basenametext enterd and the incremental to build the fileName
				set fileName to baseNameText & incremental as string
			else
				--> Use the name of the current document. 
				--> We don't add any incremental here, because the filenames ar likely to have uniqe names
				set fileName to name of currentDocument as string
				
				--> Remove extension from the fileName
				set length_extension to the number of characters of the fileName
				set start_extesion to (length_extension - 5) as string
				set fileName to (characters 1 thru start_extesion of the fileName) as string
			end if
			
			--> Update the text in the status message
			my updateStatusMessage("Exporting " & name of currentDocument)
			
			-->Set the range of the pages to be exported
			tell PDF export preferences
				set page range to all pages
			end tell
			
			--> Increase the progressbar by 1 because only on pages is exported
			my increaseProgressBar(count pages in currentDocument)
			
			--> If prefReplaceFiles is set to false we're allowd  to replace files
			if (my fileExists(saveFolder, fileName, name of currentDocument as string, prefReplaceFiles)) is false then
				--> Because the default timeout of Applescript is set to timeout after one minute we need to increase this
				with timeout of (prefScriptTimeout * 60) seconds
					--> Export the page as pdf
					tell currentDocument
						export format PDF type to (saveFolder & fileName & ".pdf") using PDFExportPreset without showing options
					end tell
				end timeout
			else
				--> Close the document
				tell currentDocument to close
				return false
			end if
			
		end if
		
		--> Close the document
		tell currentDocument to close
	end tell
	
	-->Return a boolean to determin if the creation of the pdf was a success or not
	return true
end createPDF

--#### Remove all items in the Tabview list ####--
--> The function takes no parameters
on removeAll()
	--> Set datasource
	set fileListSource to data source of table view "fileList" of scroll view "files" of window "main"
	set selectedDataRows to selected data rows of table view "fileList" of scroll view "files" of window "main"
	--> Get the number of items in the list
	set numOfFiles to number of data rows of fileListSource
	--> Loop the through the number of items in the list and remove each one
	repeat with n from 1 to numOfFiles
		-->Delete the item from the list
		delete (data row 1 of fileListSource)
	end repeat
end removeAll

--#### Remove selected item in the Tabview list ####--
--> The function takes no parameters
on removeSelected()
	-->Set datasource
	set fileListSource to data source of table view "fileList" of scroll view "files" of window "main"
	set selectedDataRows to selected data rows of table view "fileList" of scroll view "files" of window "main"
	--> Check it any items are selected, if not nothing happens
	if (count of selectedDataRows) > 0 then
		tell window "main"
			--> Remove the item from the list
			delete (item 1 of selectedDataRows)
		end tell
	end if
end removeSelected

--#### Count all pages inn a document ####--
--> The var open_document must be a complete path to the document to be opend
--> The returned value is a number containing the number of pages in the document
on countPages(open_document)
	tell application "Adobe InDesign CS2"
		--> Open the document
		set count_document to open open_document without showing window
		--> Count number of pages in document
		set pagesInDocument to count pages in count_document
		--> Close the document
		tell count_document to close
	end tell
	--> Retun the munber of pages
	return pagesInDocument
end countPages

--#### Check if the file exists ####--
--> This checks if a file allready exists
--> cfolder (string) must set and is the path to the folder we what to check for the file
--> cfile (string) is the filename of the file we whant to check if exists. the must be passed as only the filename without the filename extension
--> cinddfile (string) is the name of the indesign document where the error occurs. this is only used to make sense of the indesign log.
--> writeError (boolean) is used to determin wheter to write a errorlog or not
on fileExists(cfolder, cfile, cinddfile, writeError)
	tell application "Finder"
		(*
			This bit of code was removed because it caused a error when trying to 
			work with files on a remote volume. 
			
			-->set cfolder to cfolder as alias
		*)
		
		-->Get a list of all the files in the folder where the file is trying to be saved
		set cfilelist to name of every file of cfolder as list
		-->Check if our filename is in the list
		if (cfile & ".pdf") is in cfilelist then
			--> If a file with the name exists, check if we whant to write a error message
			if writeError then
				--> Set the path for the errorlog-file
				set logSavePath to (cfolder & cfile & "_log.txt") as string
				-->This creates a file if the file does not exist
				open for access logSavePath with write permission
				--> Write the opening of the file
				write "xPDF log:" & (ASCII character 10) to file logSavePath starting at eof
				write "While trying to create the file " & cfile & ".pdf from the InDesign document " & cinddfile & " the following error occurred:" & (ASCII character 10) to file logSavePath starting at eof
				write "A file with the name " & cfile & ".pdf allready exists." & (ASCII character 10) & "No PDF-file was produced." to file logSavePath starting at eof
				--> Close the file
				close access file logSavePath
				-->Return true since we now know that the file exist
				return true
			end if
			-->Although the file exists, writeError is set to false so the will be overwritten
			return false
		else
			-->Return false since we now know that the file does not exist
			return false
		end if
	end tell
end fileExists

--#### Check for document errors ####--
--> This checks for missing images and fonts
--> checkDocument must be a indesign document object
--> saveFolder is a string to the folder the file is saved to
--> missingImagesCheck is a boolean
--> missingFontsCheck is a boolean
on checkError(checkDocument, saveFolder, missingImagesCheck, missingFontsCheck)
	--> Open Indesign
	tell application "Adobe InDesign CS2"
		--> Open the document
		tell checkDocument
			--> missingImagesCheck is true then make a list of all the missing images 
			if missingImagesCheck then
				try
					--> Get a list of all missing or out of date images
					set missingImages to name of every link whose status is link missing & name of every link whose status is link out of date
					--> Because of a bug in InDesign we need to check if the reurned value is a list
					--> It is not a list if only one image is missing, so then we need to set it again.
					if class of missingImages is not list then
						set missingImages to {name of every link whose status is link missing}
					end if
				on error
					--> If there are noe images missing we still whant our var to be set
					--> because we need it further down, so we create a empty list.
					set missingImages to {}
				end try
			else
				--> If missingImagesCheck is set to false we need to create a empty list
				--> because we use the number of items in this list further down
				set missingImages to {}
			end if
			
			if missingFontsCheck then
				try
					--> Get a list of all missing fonts
					set missingFonts to name of every font whose status is not installed
					--> Because of a bug in InDesign we need to check if the reurned value is a list
					--> It is not a list if only one font is missing, so then we need to set it again.
					if class of missingFonts is not list then
						set missingFonts to {name of every font whose status is not installed}
					end if
				on error
					--> If there are noe images missing we still whant our var to be set
					--> because we need it further down, so we create a empty list.
					set missingFonts to {}
				end try
			else
				--> If there are noe images missing we still whant our var to be set
				--> because we need it further down, so we create a empty list.
				set missingFonts to {}
			end if
			
			--> Set the path for the errorlog-file
			set savePath to (saveFolder & ":" & name of checkDocument & "_log.txt") as string
			
			--> Set number of total errors
			--> We need this var to deside if we whant to make a PDF-file or not
			set totalErrors to missingImages & missingFonts
			
			--> If any errors occur create a logfile 
			if (count totalErrors) > 0 then
				-->This creates a file if the file does not exist
				open for access savePath with write permission
				--> Write the opening of the file
				write "xPDF log:" & (ASCII character 10) to file savePath starting at eof
				write "You have missing images or fonts in " & name of checkDocument & (ASCII character 10) & "No PDF-file was produced." to file savePath starting at eof
				--> Close the file
				close access file savePath
			end if
			
			--> Check for images
			if (count missingImages) > 0 then
				--> Open the logfile
				open for access savePath with write permission
				write (ASCII character 10) & "Missing images:" & (ASCII character 10) to file savePath starting at eof
				-->Write all the missing images
				repeat with n from 1 to (count missingImages)
					set w_missingImage to item n of missingImages
					write w_missingImage to file savePath starting at eof
					write (ASCII character 10) to file savePath starting at eof
				end repeat
				--> Close the file
				close access file savePath
			end if
			
			--> Check for fonts
			if (count missingFonts) > 0 then
				--> Open the logfile
				open for access savePath with write permission
				write (ASCII character 10) & "Missing fonts:" & (ASCII character 10) to file savePath starting at eof
				-->Write all the missing fonts
				repeat with n from 1 to (count missingFonts)
					set w_missingFonts to item n of missingFonts
					write w_missingFonts to file savePath starting at eof
					write (ASCII character 10) to file savePath starting at eof
				end repeat
				--> Close the file
				close access file savePath
			end if
		end tell
		
		--> Based on the result here we generate the PDF or not
		if (count totalErrors) > 0 then
			return true
		else
			return false
		end if
		
	end tell
end checkError

--#### Take a given path an return it as a colon separeted path ####--
--> changePath the string path to be changed
on makeColonpath(changePath)
	set AppleScript's text item delimiters to "/"
	set tmpPath to every text item of changePath
	set AppleScript's text item delimiters to the ":"
	set the tmpPath to tmpPath as string
	set AppleScript's text item delimiters to the ""
	return tmpPath
end makeColonpath

--#### Initiate the progressbar of the statuspanel ####--
--> maxValue is a number that is the max value for the progrescounter
on initiatePorgress(maxValue)
	tell progress indicator "progress" of window "progressPanel"
		set indeterminate to false
		set minimum value to 0
		set maximum value to maxValue
		set contents to 0
	end tell
end initiatePorgress

--#### Increase the progressbar ####--
--> incremental is a number containing the number of values to increment
on increaseProgressBar(incremental)
	--> increas the progress
	tell progress indicator "progress" of window "progressPanel" to increment by incremental
end increaseProgressBar

--#### Update the status message ####--
--> new_message is a string containing the message
on updateStatusMessage(new_message)
	--> update the statusmessage
	set contents of text field "statusMessage" of window "progressPanel" to new_message as string
end updateStatusMessage

--#### Update the text in the summaryfield ####--
--> preset is a string containing the preset to retrive
--> returns true
on updatedSummary(preset)
	--> Get the full path to the jobotions document for the preset
	tell application "Adobe InDesign CS2"
		set joboptionsPath to full name of PDF export preset preset as string
	end tell
	
	--> Open the jobotions document
	set openJoboption to open for access joboptionsPath
	
	--> Read the file into a string
	set joboptionData to read openJoboption
	
	--> Close the access to the file
	close access openJoboption
	
	--> Create a list of the the data in the jobotions file
	--> Ever line in the document is made into a item
	set AppleScript's text item delimiters to (ASCII character 10)
	set joboptionList to every text item of joboptionData as list
	set AppleScript's text item delimiters to the ""
	
	--> Loop thrugh all the lines in the file
	repeat with p from 1 to (length of joboptionList)
		--> A error is retuned if a line has less the character that we are looking for
		--> to prevet this error for occuring we check the length of the line first
		if (number of characters in item p of joboptionList) is greater than 8 then
			--> Set the first 8 characters in the line 
			set getLine to (characters 1 thru 8 of (item p of joboptionList)) as string
			--> If the chatacters in getLine is the ones we are searching for 
			if getLine is equal to "    /ENU" then
				--> Extract only the part of the line we whant
				set presetDescription to (characters 11 thru ((number of characters in item p of joboptionList) - 1) of (item p of joboptionList as string)) as string
				(* 
				There might be some bug here, because some times the above statment dosent remove the ending ")" from the text 
				To fix this we need to check if the last character is a ")"  and then remove it
				*)
				if (number of characters in presetDescription) is greater than 2 then
					set lastChar to (characters ((number of characters in presetDescription as number) - 1) thru (number of characters in presetDescription) of presetDescription) as string
					
					if lastChar is equal to ".)" then
						set presetDescription to (characters 1 thru ((number of characters in presetDescription) - 1) of presetDescription) as string
					end if
				else
					set presetDescription to "No description."
				end if
				
				--> Set the contents of the summary to the description
				set contents of text view "summary" of scroll view "summaryContainer" of window "main" to presetDescription
				exit repeat
			end if
		end if
	end repeat
	
	return true
end updatedSummary


--#### This handler is called when the prefs window is opend ####--
on will open theObject
	if (name of theObject as string) is equal to "preferences" then
		--> Set the state of the prefrences
		set contents of button "cb_LeadingZero" of window "preferences" to contents of default entry "prefLeadingZero" of user defaults
		set contents of button "cb_ReplaceFiles" of window "preferences" to contents of default entry "prefReplaceFiles" of user defaults
		set contents of text field "tf_scriptTimeout" of window "preferences" to contents of default entry "prefScriptTimeout" of user defaults
	end if
end will open

--#### This handler is called when the prefs window is closed ####--
on will close theObject
	if (name of theObject as string) is equal to "preferences" then
		--> Update the values in the plistfile based on the current stat of the UI in the pref window
		set contents of default entry "prefLeadingZero" of user defaults to contents of button "cb_LeadingZero" of window "preferences" as boolean
		set contents of default entry "prefReplaceFiles" of user defaults to contents of button "cb_ReplaceFiles" of window "preferences" as boolean
		set contents of default entry "prefScriptTimeout" of user defaults to contents of text field "tf_scriptTimeout" of window "preferences" as number
		
		-->If the prefs are changed during a session we need to update out global values
		set prefLeadingZero to contents of button "cb_LeadingZero" of window "preferences" as boolean
		set prefReplaceFiles to contents of button "cb_ReplaceFiles" of window "preferences" as boolean
		set prefScriptTimeout to contents of text field "tf_scriptTimeout" of window "preferences" as number
	end if
end will close
