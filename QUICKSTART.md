# 🚀 金融市場監控系統 - 5分鐘快速入門

## 📦 下載後的第一步

### Windows 用戶

1. **確認已安裝 Python 和 Node.js**
   ```cmd
   python --version
   node --version
   ```
   
2. **雙擊執行啟動腳本**
   ```
   start.bat
   ```

3. **等待自動安裝和啟動**（首次需要 2-3 分鐘）

4. **打開瀏覽器訪問**
   - 前端: http://localhost:3000
   - API: http://localhost:8000/docs

---

### macOS/Linux 用戶

1. **打開終端，進入專案目錄**
   ```bash
   cd fintech-monitor
   ```

2. **賦予執行權限並啟動**
   ```bash
   chmod +x start.sh
   ./start.sh
   ```

3. **打開瀏覽器訪問**
   - 前端: http://localhost:3000
   - API: http://localhost:8000/docs

---

## 🎯 主要功能說明

### 1️⃣ 美日利差監控
- 顯示 10年期美債與日債的收益率差
- 雙 Y 軸圖表與 USD/JPY 對比
- 即時計算利差變化

### 2️⃣ 匯率追蹤
- USD/JPY 實時匯率
- 顯示最高/最低價
- 歷史走勢圖

### 3️⃣ 大宗商品
- 黃金現貨價格
- WTI 原油價格
- 價格變動追蹤

### 4️⃣ 自動刷新
- 每 60 秒自動更新數據
- 可手動點擊刷新按鈕
- 顯示最後更新時間

---

## 🔧 常見問題

### Q: 啟動失敗怎麼辦？

**A: 檢查以下項目**
1. Python 版本是否 3.9+
2. Node.js 版本是否 18+
3. 埠口 3000 和 8000 是否被占用

### Q: 數據顯示為空？

**A: 可能原因**
1. 網絡連接問題（yfinance 需要訪問 Yahoo Finance）
2. 市場休市時間（週末/節假日數據可能不更新）
3. 檢查後端 console 是否有錯誤訊息

### Q: 如何更改數據週期？

**A:** 在前端介面右上角選擇週期：
- 1天 / 5天 / 1個月 / 3個月 / 6個月

### Q: 如何部署到線上？

**A:** 詳見 `DEPLOYMENT_GUIDE.md`，推薦使用：
- 前端：Vercel / Netlify
- 後端：Railway / Render

---

## 📚 進階使用

### 修改 API 端口

**後端 (main.py)**
```python
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)  # 改這裡
```

**前端 (App.jsx)**
```javascript
const API_BASE_URL = 'http://localhost:8000';  // 改這裡
```

### 添加新的數據源

在 `backend/main.py` 的 `TICKERS` 字典中添加：
```python
TICKERS = {
    "us10y": "^TNX",
    "new_ticker": "YOUR_TICKER_CODE"  # 新增
}
```

### 自定義圖表顏色

在 `frontend/src/App.jsx` 中修改：
```javascript
<Line
  stroke="#3b82f6"  // 改成你想要的顏色
  strokeWidth={2}
/>
```

---

## 🛠️ 手動安裝指南（無啟動腳本）

### 後端手動安裝

```bash
# 1. 進入後端目錄
cd backend

# 2. 創建虛擬環境
python -m venv venv

# 3. 啟動虛擬環境
# Windows
venv\Scripts\activate
# macOS/Linux
source venv/bin/activate

# 4. 安裝依賴
pip install fastapi uvicorn yfinance pandas python-dotenv

# 5. 啟動服務
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

### 前端手動安裝

```bash
# 1. 進入前端目錄
cd frontend

# 2. 安裝依賴
npm install

# 3. 啟動開發服務器
npm run dev

# 4. 生產構建（可選）
npm run build
```

---

## 📊 API 測試

使用 curl 測試 API：

```bash
# 獲取所有數據
curl http://localhost:8000/api/all?period=5d

# 只獲取利差數據
curl http://localhost:8000/api/bond-spread?period=1mo

# 只獲取匯率數據
curl http://localhost:8000/api/fx?period=5d

# 只獲取商品數據
curl http://localhost:8000/api/commodities?period=5d
```

---

## 🎨 自定義樣式

### 修改主題色

在 `tailwind.config.js` 中：
```javascript
theme: {
  extend: {
    colors: {
      primary: {
        500: '#3b82f6',  // 改成你的主題色
      }
    }
  }
}
```

### 修改刷新頻率

在 `App.jsx` 中：
```javascript
const REFRESH_INTERVAL = 60000;  // 60秒，單位毫秒
```

---

## 📱 移動端優化

本應用已完全響應式設計，支持：
- ✅ 手機 (320px+)
- ✅ 平板 (768px+)
- ✅ 桌面 (1024px+)

建議使用 Chrome/Safari/Edge 瀏覽器以獲得最佳體驗。

---

## 🔐 安全提醒

1. **不要在公開環境暴露 API**
2. **生產環境務必配置 HTTPS**
3. **設置 CORS 白名單**
4. **定期更新依賴庫**

---

## 📞 需要幫助？

1. 查看 `README.md` 完整文檔
2. 查看 `DEPLOYMENT_GUIDE.md` 部署指南
3. 檢查 GitHub Issues
4. 聯繫開發者

---

**祝您使用愉快！** 🎉

如果這個專案對您有幫助，請給個 Star ⭐
