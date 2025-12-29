# 🚀 常用指令速查表

## 📦 快速啟動

### Windows
```bash
start.bat
```

### macOS/Linux
```bash
chmod +x start.sh && ./start.sh
```

---

## 🔧 手動安裝

### 後端
```bash
cd backend
python -m venv venv
source venv/bin/activate  # macOS/Linux
venv\Scripts\activate     # Windows
pip install -r requirements.txt
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

### 前端
```bash
cd frontend
npm install
npm run dev
```

---

## 🐳 Docker 部署

### 構建並啟動
```bash
docker-compose up -d
```

### 查看日誌
```bash
docker-compose logs -f
```

### 停止服務
```bash
docker-compose down
```

### 重建容器
```bash
docker-compose up -d --build
```

---

## 🧪 測試 API

### 測試所有數據
```bash
curl http://localhost:8000/api/all?period=5d
```

### 測試利差數據
```bash
curl http://localhost:8000/api/bond-spread
```

### 測試匯率數據
```bash
curl http://localhost:8000/api/fx
```

### 測試商品數據
```bash
curl http://localhost:8000/api/commodities
```

### 訪問 API 文檔
```bash
# 瀏覽器打開
http://localhost:8000/docs
```

---

## 📦 生產構建

### 前端構建
```bash
cd frontend
npm run build
npm run preview  # 預覽構建結果
```

### 後端生產模式
```bash
cd backend
uvicorn main:app --host 0.0.0.0 --port 8000 --workers 4
```

---

## 🔍 故障排查

### 清理前端緩存
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
```

### 重建 Python 虛擬環境
```bash
cd backend
rm -rf venv
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 檢查埠口占用
```bash
# macOS/Linux
lsof -i :8000
lsof -i :3000

# Windows
netstat -ano | findstr :8000
netstat -ano | findstr :3000
```

### 強制停止進程
```bash
# macOS/Linux
kill -9 <PID>

# Windows
taskkill /PID <PID> /F
```

---

## 📝 開發工具

### 代碼格式化
```bash
# Python (需安裝 black)
pip install black
black backend/main.py

# JavaScript (需安裝 prettier)
npm install -g prettier
prettier --write frontend/src/**/*.jsx
```

### 程式碼檢查
```bash
# Python (需安裝 pylint)
pip install pylint
pylint backend/main.py

# JavaScript (需安裝 eslint)
npm install -g eslint
eslint frontend/src/
```

---

## 🌐 部署指令

### Vercel (前端)
```bash
cd frontend
npm install -g vercel
vercel
```

### Railway (後端)
```bash
cd backend
railway up
```

### Render (後端)
```bash
# 提交到 Git 倉庫後，連接 Render 自動部署
git add .
git commit -m "Deploy to Render"
git push origin main
```

---

## 🔐 環境變數設置

### 創建後端環境變數
```bash
cd backend
cp .env.example .env
# 編輯 .env 文件
```

### 創建前端環境變數
```bash
cd frontend
cp .env.example .env
# 編輯 .env 文件
```

---

## 📊 監控和日誌

### 查看後端日誌
```bash
# 開發模式自動顯示
# 生產模式需要配置日誌文件
```

### 查看前端構建日誌
```bash
npm run build -- --debug
```

---

## 🧹 清理指令

### 清理所有構建產物
```bash
# 前端
cd frontend
rm -rf dist node_modules

# 後端
cd backend
rm -rf venv __pycache__
```

### 完全重置專案
```bash
# 返回初始狀態
git clean -fdx
```

---

## 📚 常用 Git 指令

### 初始化倉庫
```bash
git init
git add .
git commit -m "Initial commit"
```

### 推送到 GitHub
```bash
git remote add origin https://github.com/your-username/fintech-monitor.git
git branch -M main
git push -u origin main
```

---

## 🎯 快捷鍵

**前端開發服務器:**
- `Ctrl + C` - 停止服務
- 瀏覽器 `Ctrl + Shift + R` - 強制刷新

**後端 API 服務器:**
- `Ctrl + C` - 停止服務
- 修改代碼自動重載（`--reload` 模式）

---

## 📞 幫助資源

- **API 文檔**: http://localhost:8000/docs
- **README**: [README.md](./README.md)
- **快速入門**: [QUICKSTART.md](./QUICKSTART.md)
- **部署指南**: [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)
- **專案結構**: [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md)

---

**提示**: 將此文件加入書籤，方便隨時查閱常用指令！
