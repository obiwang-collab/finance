# 金融市場監控系統 - 部署指南

## 📋 系統需求

- Python 3.9+
- Node.js 18+
- npm 或 yarn

---

## 🚀 快速開始

### 第一步：後端部署

#### 1. 創建虛擬環境（推薦）

```bash
# Windows
python -m venv venv
venv\Scripts\activate

# macOS/Linux
python3 -m venv venv
source venv/bin/activate
```

#### 2. 安裝依賴

```bash
pip install fastapi uvicorn[standard] yfinance pandas python-dotenv
```

或使用 requirements.txt：

```bash
pip install -r requirements.txt
```

#### 3. 啟動後端服務

```bash
# 開發模式（自動重載）
uvicorn main:app --reload --host 0.0.0.0 --port 8000

# 生產模式
uvicorn main:app --host 0.0.0.0 --port 8000 --workers 4
```

後端 API 將運行在 `http://localhost:8000`

#### 4. 測試 API

在瀏覽器訪問：
- API 文檔：`http://localhost:8000/docs`
- 測試端點：`http://localhost:8000/api/all?period=5d`

---

### 第二步：前端部署

#### 1. 安裝依賴

```bash
cd frontend
npm install

# 或使用 yarn
yarn install
```

#### 2. 配置 Vite 和 Tailwind

**vite.config.js**
```javascript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: 'http://localhost:8000',
        changeOrigin: true
      }
    }
  }
})
```

**tailwind.config.js**
```javascript
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

**index.css**
```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

#### 3. 啟動開發伺服器

```bash
npm run dev

# 或
yarn dev
```

前端將運行在 `http://localhost:3000`

#### 4. 生產構建

```bash
npm run build

# 預覽構建結果
npm run preview
```

構建文件將位於 `dist/` 目錄

---

## 🔧 配置說明

### API Base URL 配置

在 `App.jsx` 中修改：

```javascript
// 開發環境
const API_BASE_URL = 'http://localhost:8000';

// 生產環境（使用環境變量）
const API_BASE_URL = import.meta.env.VITE_API_URL || 'https://your-api.com';
```

### 環境變數

創建 `.env` 文件：

```env
# 後端
PORT=8000
CORS_ORIGINS=http://localhost:3000,https://your-domain.com

# 前端
VITE_API_URL=http://localhost:8000
```

---

## 📊 數據源說明

### yfinance Ticker 代號

| 資產 | Ticker | 說明 |
|------|--------|------|
| 美國 10年期國債 | ^TNX | Treasury Yield 10 Years |
| USD/JPY | JPY=X | 美元兌日圓匯率 |
| 黃金期貨 | GC=F | Gold Futures |
| WTI 原油 | CL=F | Crude Oil WTI |

### 日本國債說明

⚠️ **重要提醒**：yfinance 對日本國債的支持有限，建議使用以下替代方案：

1. **Investing.com API** (需付費)
2. **自建爬蟲**：抓取財務部官網數據
3. **Bloomberg API** (需訂閱)
4. **使用固定假設值**（當前代碼採用此方法）

---

## 🐳 Docker 部署（進階）

### Dockerfile (後端)

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### Docker Compose

```yaml
version: '3.8'

services:
  backend:
    build: ./backend
    ports:
      - "8000:8000"
    environment:
      - CORS_ORIGINS=http://localhost:3000
    restart: unless-stopped

  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    depends_on:
      - backend
    restart: unless-stopped
```

啟動：
```bash
docker-compose up -d
```

---

## 🌐 生產部署建議

### 後端部署選項

1. **Railway / Render**
   - 支持 Python
   - 自動 HTTPS
   - 簡單部署

2. **AWS EC2 / DigitalOcean**
   - 使用 Nginx + Gunicorn/Uvicorn
   - 配置 SSL 證書

3. **Google Cloud Run / Azure App Service**
   - 容器化部署
   - 自動擴展

### 前端部署選項

1. **Vercel / Netlify**
   - 一鍵部署
   - 自動 CI/CD
   - 免費 SSL

2. **Cloudflare Pages**
   - 全球 CDN
   - 免費方案

3. **Nginx 靜態托管**
   - 自建伺服器
   - 完全控制

---

## 🔒 安全建議

1. **CORS 配置**
   ```python
   # 生產環境只允許特定域名
   allow_origins=["https://your-domain.com"]
   ```

2. **API 速率限制**
   ```bash
   pip install slowapi
   ```

3. **環境變數**
   - 不要提交 `.env` 到 Git
   - 使用密鑰管理服務

4. **HTTPS**
   - 生產環境必須使用 HTTPS
   - 使用 Let's Encrypt 免費證書

---

## 📞 故障排除

### 常見問題

**Q: CORS 錯誤**
```
Access to fetch at 'http://localhost:8000' from origin 'http://localhost:3000' 
has been blocked by CORS policy
```

A: 檢查後端 CORS 設定：
```python
allow_origins=["http://localhost:3000"]
```

**Q: yfinance 數據為空**

A: 檢查：
1. Ticker 代號是否正確
2. 市場是否開盤
3. 網絡連接是否正常

**Q: 日債數據無法獲取**

A: 當前使用模擬數據，建議：
1. 整合付費 API（Bloomberg/Refinitiv）
2. 自建爬蟲（需遵守網站 ToS）

---

## 📈 未來優化方向

1. **數據緩存**：使用 Redis 減少 API 調用
2. **WebSocket**：實時數據推送
3. **歷史數據庫**：PostgreSQL 存儲歷史數據
4. **技術指標**：添加 RSI、MACD 等技術分析
5. **告警系統**：價格/利差突破時發送通知

---

## 📝 授權

MIT License - 請參考 LICENSE 文件

---

## 🤝 貢獻

歡迎提交 Issue 和 Pull Request！

---

**開發者**: James  
**版本**: 1.0.0  
**最後更新**: 2024
