@ECHO OFF
SETLOCAL EnableDelayedExpansion

echo ##############################################################################
echo                           ##### Speedy Git #####
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
color F
REM get date and time
for /f "delims=" %%a in ('date/t') do @set mydate=%%a
for /f "delims=" %%a in ('time/t') do @set mytime=%%a
set currentTime=%mydate%%mytime%
REM set timeOut time
set timeOutNum=15
REM show Git status

echo.
echo ### Choose to Push or Get ###
echo   Available commands are:
echo    1. Push with automated commit.
echo    2. Push with custom message.
echo    3. Rebuild with Jekyll and Push with auto commit.
echo    4. Pull new updates.
echo    5. Pull and Merge updates from a forked repo.
echo    6. Check your notifications at Github.
echo    7. Show me all remotes...
echo    8. Add an upstream remote from a forked repo.
echo    9. Exit.
set /p "option=### Make your choice:"
echo.
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

IF "%option%"=="1" (
	REM add all new files with auto-commit
	call cd _site
	call git add .
	call git commit -a -m "Automated commit by Speedy_Git on %currentTime%"
	call git push origin master
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
	timeout /t %timeOutNum%
	exit
) ELSE IF "%option%"=="2" (
	REM make new commit with your custom message
	call cd _site
	set /p "msgline=### Type message for your new commit:"
	call git add .
	call git commit -m "!msgline!"
	call git push origin master
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
	timeout /t %timeOutNum%
	exit
) ELSE IF "%option%"=="3" (
	call bundle exec jekyll build
	echo.
	echo ### Finished with all updates.
	echo.
	call cd _site
	call git add .
	call git commit -a -m "Automated commit by Speedy_Git on %currentTime%"
	echo. 
	echo ### Now we will make auto commit in GitHub.
	echo.
	call git push origin master
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
	timeout /t %timeOutNum%
	exit
) ELSE IF "%option%"=="4" (
    call cd _site
	call git pull origin master
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
	timeout /t %timeOutNum%
	exit
) ELSE IF "%option%"=="5" (
    call cd _site
	echo ### Processing your request.
    call git fetch upstream
    echo ### All updates are in your upstream branch. Now, press any key to trigger the merge!
    timeout /t -1
    call git merge upstream/master
	echo.
	echo ### Great, everything went well! Press any key for exit.
	timeout /t %timeOutNum%
	exit
) ELSE IF "%option%"=="6" (
	start https://github.com/notifications
	echo ### Processing your request.
	echo.
	echo ### Great, everything went well! Press any key for exit.
	timeout /t 15
	exit
) ELSE IF "%option%"=="7" (
	call cd _site
	call git remote -v
    echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
    timeout /t 30
	exit
) ELSE IF "%option%"=="8" (
    call cd _site
	set /p "myUrl=### Paste the URL from the original(forked) repo and press Enter:"
	timeout /t 7
    call git remote add upstream !myUrl!
	timeout /t 5
	call git remote -v
    echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
    timeout /t %timeOutNum%
	exit
) ELSE IF "%option%"=="9" (
	exit
) ELSE (
    exit
)
