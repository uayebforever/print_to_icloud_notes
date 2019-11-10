on run {input, parameters}
	
	set notesAccount to "iCloud"
	set notesFolder to "Reading"
	
	try
		tell application "System Events"
			set frontmostProcess to first process where it is frontmost
			--			if frontmostProcess is "com.apple.automator.runner.xpc" then
			if background only of frontmostProcess is true then
				set visible of frontmostProcess to false
				repeat while (frontmostProcess is frontmost)
					delay 0.2
				end repeat
				set frontmostProcess to the first process where it is frontmost
				--				set frontmost of frontmostProcess to true
			end if
			set theapp to the name of frontmostProcess
		end tell
		
		if the the name of frontmostProcess is "Google Chrome" then
			tell application "Google Chrome"
				set thewindow to window 1
				set thetab to the active tab of thewindow
				set thetitle to the title of thetab
				set theurl to the URL of thetab
			end tell
		else
			tell application theapp
				set thetitle to the name of window 1
				set theurl to "from application " & theapp
			end tell
		end if
	on error the error_message number the error_number
		--		set app to current application
		--try
		--	set appname to (name of frontmost)
		set the error_text to "Error: " & the error_number & ". " & the error_message & "
		" & (theapp)
		display dialog the error_text buttons {"OK"} default button 1
		return the error_text
	end try
	
	tell application "Notes"
		tell account notesAccount
			set thebody to "<div>" & theurl & "</div>
			<div><br></div>"
			set mynote to make new note at folder notesFolder with properties {name:thetitle, body:thebody}
			make new attachment at mynote with data input
		end tell
	end tell
	return parameters
end run