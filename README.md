# RooitExam
Rooit exam

## 注意事項

需要處理以下內容才能執行

1. 其中的 Constants.swift 已被忽略，因此無法獲取 `NEWS_API_KEY`
2. 用於 NewsAPI 的 apikey 需要至 https://newsapi.org/ 申請
3. 到 AppDelegate 的 #warning 處執行 `NewsAPI.shared.configure(apiKey: your_api_key)`
4. pod install 安裝所需第三方套件
