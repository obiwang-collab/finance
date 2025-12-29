# 🌐 金融市場監控儀表板

即時追蹤美日利差、USD/JPY 匯率和大宗商品價格的專業級 FinTech 應用程式。

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Python](https://img.shields.io/badge/Python-3.9+-green.svg)
![React](https://img.shields.io/badge/React-18.2-blue.svg)

## ✨ 核心功能

### 📊 數據監控
- **美日利差追蹤**：實時計算 10年期美債與日債的收益率差
- **USD/JPY 匯率**：追蹤美元兌日圓匯率走勢
- **大宗商品**：黃金和 WTI 原油價格監控
- **雙 Y 軸圖表**：利差與匯率疊加對比分析

### ⚡ 技術特點
- **自動刷新**：每 60 秒自動更新數據
- **響應式設計**：完美支持手機、平板和桌面設備
- **實時圖表**：基於 Recharts 的互動式數據可視化
- **RESTful API**：FastAPI 提供高效能後端服務

---

## 🛠️ 技術棧

### 後端
- **FastAPI** - 現代高效能 Python Web 框架
- **yfinance** - Yahoo Finance 數據抓取
- **Pandas** - 數據處理和分析
- **Uvicorn** - ASGI 伺服器

### 前端
- **React 18** - UI 框架
- **Recharts** - 圖表庫
- **Tailwind CSS** - 工具優先的 CSS 框架
- **Lucide React** - 圖標庫
- **Vite** - 下一代前端構建工具

---

## 🚀 快速開始

### 方法一：使用啟動腳本（推薦）

**Windows:**
```bash
# 下載專案後，雙擊執行
start.bat
```

**macOS/Linux:**
```bash
# 賦予執行權限
chmod +x start.sh

# 執行啟動腳本
./start.sh
```

### 方法二：手動啟動

#### 1️⃣ 後端設置

```bash
# 進入後端目錄
cd backend

# 創建虛擬環境
python -m venv venv

# 啟動虛擬環境
# Windows
venv\Scripts\activate
# macOS/Linux
source venv/bin/activate

# 安裝依賴
pip install -r requirements.txt

# 啟動服務
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

#### 2️⃣ 前端設置

```bash
# 新開終端，進入前端目錄
cd frontend

# 安裝依賴
npm install

# 啟動開發伺服器
npm run dev
```

### 訪問應用

- **前端介面**: http://localhost:3000
- **API 文檔**: http://localhost:8000/docs
- **API 端點**: http://localhost:8000/api/all

---

## 📡 API 端點說明

### `GET /api/bond-spread`
獲取美日利差數據

**參數:**
- `period` (可選): 數據週期 (1d, 5d, 1mo, 3mo, 6mo)

**回應範例:**
```json
{
  "success": true,
  "data": [
    {
      "date": "2024-12-25",
      "us10y": 4.52,
      "jp10y": 0.65,
      "spread": 3.87
    }
  ]
}
```

### `GET /api/fx`
獲取 USD/JPY 匯率數據

### `GET /api/commodities`
獲取黃金和原油價格數據

### `GET /api/all`
一次性獲取所有數據（推薦）

---

## 📱 功能截圖

### 桌面版
```
┌─────────────────────────────────────────┐
│  金融市場監控儀表板            [刷新]   │
├─────────────────────────────────────────┤
│  美日利差  │ USD/JPY │  黃金   │  原油  │
│   3.87%   │  151.23 │ $2,045  │  $74.5 │
├─────────────────────────────────────────┤
│                                         │
│      [美日利差 vs USD/JPY 雙軸圖]        │
│                                         │
├─────────────────────────────────────────┤
│    [黃金走勢圖]    │    [原油走勢圖]    │
└─────────────────────────────────────────┘
```

---

## 🔧 配置選項

### 調整刷新頻率
在 `App.jsx` 中修改：
```javascript
const REFRESH_INTERVAL = 60000; // 毫秒 (60秒)
```

### 修改數據週期
前端提供下拉選單可選擇：
- 1 天
- 5 天
- 1 個月
- 3 個月
- 6 個月

### 後端 CORS 設定
在 `main.py` 中調整：
```python
allow_origins=["http://localhost:3000", "https://your-domain.com"]
```

---

## 📊 數據源

| 數據類型 | Ticker 代號 | 來源 |
|---------|------------|------|
| 美國 10年期國債 | ^TNX | Yahoo Finance |
| USD/JPY | JPY=X | Yahoo Finance |
| 黃金期貨 | GC=F | Yahoo Finance |
| WTI 原油 | CL=F | Yahoo Finance |

⚠️ **日本國債說明**: 由於 yfinance 對日債支持有限，當前使用估算值。建議整合：
- Bloomberg API (付費)
- Investing.com API (付費)
- 自建爬蟲（需遵守 ToS）

---

## 🚢 生產部署

### Vercel (前端)
```bash
cd frontend
npm run build
vercel --prod
```

### Railway (後端)
```bash
cd backend
# 創建 Procfile
echo "web: uvicorn main:app --host 0.0.0.0 --port \$PORT" > Procfile
# 推送到 Railway
railway up
```

### Docker 部署
```bash
docker-compose up -d
```

詳見 [部署指南](./DEPLOYMENT_GUIDE.md)

---

## 🛡️ 安全建議

1. **API 密鑰管理**: 使用環境變數存儲敏感信息
2. **CORS 限制**: 生產環境僅允許特定域名
3. **HTTPS**: 必須使用 SSL/TLS 加密
4. **速率限制**: 使用 slowapi 限制請求頻率

---

## 📈 未來規劃

- [ ] WebSocket 實時推送
- [ ] 技術指標 (RSI, MACD, 布林帶)
- [ ] 價格告警通知
- [ ] 歷史數據存儲 (PostgreSQL)
- [ ] 用戶自定義儀表板
- [ ] 更多貨幣對和商品
- [ ] AI 預測模型整合

---

## 🤝 貢獻指南

歡迎提交 Issue 和 Pull Request！

1. Fork 本專案
2. 創建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 開啟 Pull Request

---

## 📄 授權協議

本專案採用 MIT 授權協議 - 詳見 [LICENSE](LICENSE) 文件

---

## 👨‍💻 開發者

**James**  
Taiwan FinTech Developer  
- 網站: [台指期籌碼戰情室](https://www.twoption-ai.com)
- 專長: 金融數據分析、Web 開發

---

## 📞 支援

如有問題或建議，請：
1. 提交 [GitHub Issue](https://github.com/your-repo/issues)
2. 發送郵件至開發者信箱
3. 查閱 [部署指南](./DEPLOYMENT_GUIDE.md)

---

## ⭐ Star History

如果這個專案對你有幫助，請給一個 Star ⭐

---

**最後更新**: 2024-12-29  
**版本**: v1.0.0
