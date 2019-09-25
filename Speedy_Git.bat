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
echo ### Choose option for both repos ###
echo   Available commands are:
echo    1. Rebuild with Jekyll and Push with AUTO commit!
echo    2. Rebuild with Jekyll and Push with custom message.
echo    3. Sync both repos with original repos.
echo ### Choose option for the main repo ###
echo   Available commands are:
echo    4. Pull new updates from github.com...
echo    5. Add an upstream remote from a forked repo.
echo    6. Show me all remotes...
echo ### Choose option for the second repo - folder site ###
echo   Available commands are:
echo    7. Pull new updates from github.com...
echo    8. Add an upstream remote from a forked repo.
echo    9. Show me all remotes...
echo ### Exit ###
echo    10. Exit.
set /p "option=### Make your choice:"
echo.
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

IF "%option%"=="1" (
    REM add all new files with auto-commit
	call bundle exec jekyll build
	echo.
	echo ### Finished with the build process.
	echo ### Now we run push from root directory.
	echo.
	call git add .
	call git commit -a -m "Auto commit from base repo by Speedy_Git on %currentTime%"
	call git push origin master
	echo.
	echo ### Finished with the push operation.
	echo ### Now we run push from folder - site.
	echo.
	call cd _site
	call git add .
	call git commit -a -m "Auto commit (folder site) by Speedy_Git on %currentTime%"
	call git push origin master
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
	timeout /t %timeOutNum%
	exit
) ELSE IF "%option%"=="2" (
    REM make new commit with your custom message
    call bundle exec jekyll build
	echo.
	echo ### Finished with the build process.
	echo ### Now we run push from root directory.
	echo.
	set /p "msglineone=### Type message for your first commit:"
	call git add .
	call git commit -m "!msglineone!"
	call git push origin master
	echo.
	echo ### Finished with the push operation.
	echo ### Now we run push from folder - site.
	echo.
	call cd _site
	set /p "msglinetwo=### Type message for your second commit:"
	call git add .
	call git commit -m "!msglinetwo!"
	call git push origin master
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
	timeout /t %timeOutNum%
	exit
) ELSE IF "%option%"=="3" (
    REM sync both repos with original repos
	call git fetch upstream
	echo ### All updates are in your upstream branch. Now, press any key to trigger the merge!
    timeout /t -1
    call git merge upstream/master
	echo.
	echo ### Finished with the main folder.
	echo ### Now we will sync the second folder - site.
	echo.
	call cd _site
	call git fetch upstream
	echo ### All updates are in your upstream branch. Now, press any key to trigger the merge!
    timeout /t -1
    call git merge upstream/master
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
	timeout /t %timeOutNum%
	exit
) ELSE IF "%option%"=="4" (
	REM pull updates from root repo
	call git pull origin master
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
	timeout /t %timeOutNum%
	exit
) ELSE IF "%option%"=="5" (
	REM set upstream link for the root repo
	set /p "myUrlOne=### Paste the URL from the original(forked) repo and press Enter:"
	timeout /t 5
    call git remote add upstream !myUrlOne!
	timeout /t 5
	call git remote -v
    echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
    timeout /t %timeOutNum%
	exit
) ELSE IF "%option%"=="6" (
	REM show all remote links for the root repo
	call git remote -v
    echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
    timeout /t 30
	exit
) ELSE IF "%option%"=="7" (
    REM pull updates from site repo
	call cd _site
	call git pull origin master
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
	timeout /t %timeOutNum%
	exit
) ELSE IF "%option%"=="8" (
    REM set upstream link for the site repo
	call cd _site
	set /p "myUrlTwo=### Paste the URL from the original(forked) repo and press Enter:"
	timeout /t 5
    call git remote add upstream !myUrlTwo!
	timeout /t 5
	call git remote -v
    echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
    timeout /t %timeOutNum%
	exit
) ELSE IF "%option%"=="9" (
	REM show all remote links for the site repo
	call cd _site
	call git remote -v
    echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
    timeout /t 30
	exit
) ELSE IF "%option%"=="10" (
	exit
) ELSE (
    exit
)
