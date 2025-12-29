#!/bin/bash

echo "========================================"
echo "金融市場監控系統 - 快速啟動"
echo "========================================"
echo ""

# 檢查 Python
if ! command -v python3 &> /dev/null; then
    echo "[錯誤] 未找到 Python，請先安裝 Python 3.9+"
    exit 1
fi

# 檢查 Node.js
if ! command -v node &> /dev/null; then
    echo "[錯誤] 未找到 Node.js，請先安裝 Node.js 18+"
    exit 1
fi

# 安裝後端依賴
echo "[1/4] 安裝後端依賴..."
cd backend
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi
source venv/bin/activate
pip install -r requirements.txt -q
echo "[完成] 後端依賴安裝完成"

# 安裝前端依賴
echo ""
echo "[2/4] 安裝前端依賴..."
cd ../frontend
if [ ! -d "node_modules" ]; then
    npm install
fi
echo "[完成] 前端依賴安裝完成"

# 啟動後端
echo ""
echo "[3/4] 啟動後端服務..."
cd ../backend
source venv/bin/activate
uvicorn main:app --reload --host 0.0.0.0 --port 8000 &
BACKEND_PID=$!
sleep 3

# 啟動前端
echo ""
echo "[4/4] 啟動前端服務..."
cd ../frontend
npm run dev &
FRONTEND_PID=$!

echo ""
echo "========================================"
echo "啟動完成！"
echo "後端 API: http://localhost:8000"
echo "前端介面: http://localhost:3000"
echo "API 文檔: http://localhost:8000/docs"
echo ""
echo "按 Ctrl+C 停止所有服務"
echo "========================================"

# 等待用戶中斷
trap "echo '正在停止服務...'; kill $BACKEND_PID $FRONTEND_PID; exit" INT
wait
