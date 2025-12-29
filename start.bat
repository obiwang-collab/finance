@echo off
echo ========================================
echo 金融市場監控系統 - 快速啟動
echo ========================================
echo.

REM 檢查 Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [錯誤] 未找到 Python，請先安裝 Python 3.9+
    pause
    exit /b 1
)

REM 檢查 Node.js
node --version >nul 2>&1
if errorlevel 1 (
    echo [錯誤] 未找到 Node.js，請先安裝 Node.js 18+
    pause
    exit /b 1
)

echo [1/4] 安裝後端依賴...
cd backend
if not exist venv (
    python -m venv venv
)
call venv\Scripts\activate
pip install -r requirements.txt -q
echo [完成] 後端依賴安裝完成

echo.
echo [2/4] 安裝前端依賴...
cd ..\frontend
if not exist node_modules (
    npm install
)
echo [完成] 前端依賴安裝完成

echo.
echo [3/4] 啟動後端服務...
cd ..\backend
start cmd /k "call venv\Scripts\activate && uvicorn main:app --reload --host 0.0.0.0 --port 8000"
timeout /t 3 /nobreak >nul

echo.
echo [4/4] 啟動前端服務...
cd ..\frontend
start cmd /k "npm run dev"

echo.
echo ========================================
echo 啟動完成！
echo 後端 API: http://localhost:8000
echo 前端介面: http://localhost:3000
echo API 文檔: http://localhost:8000/docs
echo ========================================
pause
