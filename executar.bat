@echo off
chcp 65001 >nul
title Edugestao - Executar Flutter
setlocal enabledelayedexpansion

set "RUN_ARGS="
set "TARGET_LABEL="

echo.
echo ============================================
echo   Edugestao - Flutter Launcher
echo ============================================
echo.
echo Selecione a plataforma para executar:
echo   [1] Web (Chrome)
echo   [2] Windows
echo   [3] Android
echo   [4] Outros (device id manual)
echo.
set /p CHOICE=Opcao ^(1-4^): 

if "%CHOICE%"=="1" goto web
if "%CHOICE%"=="2" goto windows
if "%CHOICE%"=="3" goto android
if "%CHOICE%"=="4" goto outros

echo.
echo Opcao invalida.
goto fim

:web
set "RUN_ARGS=-d chrome"
set "TARGET_LABEL=Web (Chrome)"
goto executar

:windows
set "RUN_ARGS=-d windows"
set "TARGET_LABEL=Windows"
goto executar

:android
set "RUN_ARGS=-d android"
set "TARGET_LABEL=Android"
goto executar

:outros
echo.
echo Dispositivos disponiveis:
call flutter devices
echo.
set /p DEVICE_ID=Informe o device id (ex: edge, web-server, emulator-5554): 
if "%DEVICE_ID%"=="" (
  echo Device id vazio.
  goto fim
)
set "RUN_ARGS=-d %DEVICE_ID%"
set "TARGET_LABEL=%DEVICE_ID%"
goto executar

:executar
echo.
echo [1/3] Limpando artefatos anteriores...
call flutter clean
if errorlevel 1 goto erro

echo.
echo [2/3] Instalando dependencias...
call flutter pub get
if errorlevel 1 goto erro

echo.
echo [3/3] Iniciando app em !TARGET_LABEL!...
call flutter run !RUN_ARGS!
if errorlevel 1 goto erro
goto fim

:erro
echo.
echo ERRO: O comando anterior falhou. Verifique o log acima.
pause
goto fim

:fim
echo.
pause
endlocal
