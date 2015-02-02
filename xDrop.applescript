on awake from nib theObject
	--#### Create a data source for the table view ####--
	set theDataSource to make new data source at end of data sources with properties {name:"icon"}
	set theDataSource to make new data source at end of data sources with properties {name:"files"}
	set theDataSource to make new data source at end of data sources with properties {name:"path"}
	
	--> Create the "files" data column
	make new data column at end of data columns of theDataSource with properties {name:"icon"}
	make new data column at end of data columns of theDataSource with properties {name:"files"}
	make new data column at end of data columns of theDataSource with properties {name:"path"}
	
	--> Assign the data source to the table view
	set data source of theObject to theDataSource
	-->
	set sorted of theDataSource to false
	--> Register for "file names" drag types
	tell theObject to register drag types {"file names"}
end awake from nib

on drop theObject drag info dragInfo
	--#### Add the files to the list ####--
	--> Get the list of data types on the pasteboard
	set dataTypes to types of pasteboard of dragInfo
	
	--> We are only interested in either "file names"
	if "file names" is in dataTypes then
		--> Initialize the list of files to an empty list
		set theFiles to {}
		
		--> We want the data as a list of file names, so set the preferred type to "file names"
		set preferred type of pasteboard of dragInfo to "file names"
		
		--> Get the list of files from the pasteboard
		set theFiles to contents of pasteboard of dragInfo
		
		set error_extension to 0
		
		--> Extension checking
		--> If the extension dosn't match, don't add it
		repeat with extensionItem in theFiles
			if extensionItem does not end with ".indd" then
				set the error_extension to error_extension + 1
			end if
		end repeat
		
		--> Make sure we have at least one item
		if (count of theFiles) > 0 and error_extension < 1 then
			--> Get the data source from the table view
			set theDataSource to data source of theObject
			
			--> Turn off the updating of the views
			set update views of theDataSource to false
			
			--> Delete all of the data rows in the data source
			--> delete every data row of theDataSource
			
			--> For every item in the list, make a new data row and set it's contents
			repeat with theItem in theFiles
				set theDataRow to make new data row at end of data rows of theDataSource
				
				--> Add the red image
				set contents of data cell "icon" of theDataRow to load image "ico_yellow"
				
				--> Drag out and add the filename
				set baby_shortFileName to theItem
				set AppleScript's text item delimiters to "/"
				set young_shortFileName to last text item of the baby_shortFileName
				set AppleScript's text item delimiters to the ":"
				set the shortFileName to young_shortFileName as string
				set AppleScript's text item delimiters to the ""
				
				set contents of data cell "files" of theDataRow to shortFileName
				
				--> Add complete filepaht
				set contents of data cell "path" of theDataRow to theItem
			end repeat
			
			--> Turn back on the updating of the views
			set update views of theDataSource to true
		end if
	end if
	
	--> Set the preferred type back to the default
	set preferred type of pasteboard of dragInfo to ""
	
	return true
end drop