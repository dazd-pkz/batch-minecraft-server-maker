@echo off

title Batch Minecraft Server Maker by github.com/Dazd-Pkz
if exist server-base.jar (
echo ^(%time:~0,2%:%time:~3,2%:%time:~6,2%^) [40;33m[LOGS] The server base is already downloaded![40;37m
goto :downloaded
) else (
goto :aaa
)

:aaa
set /p version=In which version do you want the server ? (support: 1.11 -^> 1.16.5) : 
echo Downloading the server...
powershell -Command "Invoke-WebRequest https://cdn.getbukkit.org/spigot/spigot-%version%.jar -OutFile server-base.jar"
echo ^(%time:~0,2%:%time:~3,2%:%time:~6,2%^) [40;33m[LOGS] Server Base Downloaded![40;37m
goto :downloaded


:downloaded
if exist eula.txt (
echo ^(%time:~0,2%:%time:~3,2%:%time:~6,2%^) [40;33m[LOGS] Eula already accepted![40;37m
goto :euladownloaded
) else (
powershell -Command "Invoke-WebRequest https://cdn.discordapp.com/attachments/859547801083707445/869902748907352105/eula.txt -OutFile eula.txt"
echo ^(%time:~0,2%:%time:~3,2%:%time:~6,2%^) [40;33m[LOGS] Eula accepted![40;37m
goto :euladownloaded
)
:euladownloaded
if exist server.properties (
echo ^(%time:~0,2%:%time:~3,2%:%time:~6,2%^) [40;33m[LOGS] Properties already configured![40;37m
goto :propertiesdownloaded
) else (
powershell -Command "Invoke-WebRequest https://cdn.discordapp.com/attachments/859547801083707445/869909301114843136/server.properties -OutFile server.properties"
echo ^(%time:~0,2%:%time:~3,2%:%time:~6,2%^) [40;33m[LOGS] Server properties configured![40;37m
goto :propertiesdownloaded
)
:propertiesdownloaded
if exist start.bat (
goto :x
) else (
echo.
goto :startbat
)
:startbat
set /p xms=[40;32m[SETUP] Minimum Ram in GB ^(example: 1^): [40;37m
set /p xmx=[40;32m[SETUP] Maximum Ram in GB ^(example: 5^): [40;37m

:q1
set /p ngrok=[40;32m[SETUP] Do you wan't Ngrok System ? y/n : [40;37m
if %ngrok% == y (
goto :yesngrok
) else if %ngrok% == n (
goto :q
) else (
echo.
echo ^> Wrong Result!
echo.
goto :q1
)

:yesngrok
echo ^(%time:~0,2%:%time:~3,2%:%time:~6,2%^) [40;33m[LOGS] Downloading Ngrok...[40;37m
powershell -Command "Invoke-WebRequest https://cdn.discordapp.com/attachments/859547801083707445/870604713475837972/ngrok.exe -OutFile ngrok.exe"
echo  ^(%time:~0,2%:%time:~3,2%:%time:~6,2%^) [40;33m[LOGS] Ngrok Downloaded![40;37m
set /p token=[40;35m[NGROK] Enter your Ngrok AuthToken : [40;37m
:q3
set /p region=[40;35m[NGROK] eu / us : [40;37m
echo ngrok.exe authtoken %token% > networkservice.bat
if %region% == eu (
echo ngrok.exe tcp 25565 -region eu >> networkservice.bat
) else if %region% == us (
echo ngrok.exe tcp 25565 -region us >> networkservice.bat
) else (
echo.
echo ^> Wrong Result!
echo.
goto :q3
)

goto :q

:q
set /p restart=[40;32m[SETUP] Auto-restart ? y/n : [40;37m
if %restart% == y (
goto :yesrestart
) else if %restart% == n (
goto :norestart
) else (
echo.
echo ^> Wrong Result!
echo.
goto :q
)
:yesrestart
echo @echo off > start.bat
if %ngrok% == y (
echo start networkservice.bat >> start.bat
)
echo :restart >> start.bat
echo java -Xms%xms%G -Xmx%xmx%G -jar server-base.jar >> start.bat
echo goto :restart >> start.bat
echo [40;32m[SETUP] Setup Finished![40;37m
echo.
echo ^(%time:~0,2%:%time:~3,2%:%time:~6,2%^) [40;33m[LOGS] Server Created![40;37m
goto :x
:norestart
echo @echo off > start.bat
echo java -Xms%xms%G -Xmx%xmx%G -jar server-base.jar >> start.bat
echo [40;32m[SETUP] Setup Finished![40;37m
echo.
echo ^(%time:~0,2%:%time:~3,2%:%time:~6,2%^) [40;33m[LOGS] Server Created![40;37m
goto :x
:x
echo ^(%time:~0,2%:%time:~3,2%:%time:~6,2%^) [40;36m[INFO] To start the server: Run ^"start.bat^" ![40;37m
echo.
pause