# Healthbot Lambda API 文件

## 1. API 端點

```
POST https://{api-id}.execute-api.{region}.amazonaws.com/prod/chat-history
```
> 請聯絡系統管理員取得正確的 API 端點

---

## 2. 參數說明

| 參數名稱   | 類型   | 必填 | 說明                         |
|------------|--------|------|------------------------------|
| action     | string | 是   | 操作類型："ask", "history"（查詢歷史） |
| user_id    | string | 是   | 用戶唯一識別碼，最大長度 128 個字符 |
| message    | string | ask 模式必填 | 用戶提問內容 |
| session_id | string | 是   | 對話階段 ID，用於將對話關聯在一起。 |
| topic_id   | string | 是   | 由前端回復，用於關聯主題 |
| rag_type   | string | 是   |  RAG 類型，用於指定使用哪種知識庫和模型配置。目前支援："health"（健康顧問）、"customer_service"（客服機器人）和 "training"（銷售教材）。預設為 "health" ||
| message_id    | string | feedback 模式必填 | 要評價的訊息 ID |
| rating        | number | feedback 模式必填 | 評分：1=正面評價（有幫助）, 0=負面評價（沒幫助） |
| feedback_text | string | 否   | 用戶文字反饋，最大長度 1000 個字符 |

---

## 3. 請求格式

- **HTTP 方法**：POST
- **Content-Type**：application/json
- **字符編碼**：UTF-8

### 2.1 歷史記錄查詢模式

```json
{
  "action": "history",
  "user_id": "app用戶唯一識別碼",
  "rag_type": "health"
}
```

## 3. 回應格式

### 3.1 歷史記錄查詢回應

狀態碼：200

```json
{
    "user_id": "444",
    "history": [
        {
            "user_id": "444",
            "session_id": "c5c1cc22-f149-4550-aa33-475cdb30ee69",
            "topic_id": "我的頭痛",
            "timestamp": "2025-04-30T08:13:35.159697",
            "rag_type": "health",
            "ttl": "1753776815",
            "message": "我的頭痛是怎麼了？",
            "bot_response": "根據提供的文檔資料,並沒有直接提到頭痛的相關資訊。不過,文檔5提到了心衰竭可能會導致腦部缺氧,從而影響大腦功能,造成焦慮、記憶力變差、失眠或頭暈等症狀。因此,若您同時也有心衰竭的症狀,頭痛可能與此有關。不過沒有更多個人病史細節,我無法確定您頭痛的具體原因。如果頭痛持續或加重,建議您儘快就醫,由專業醫師進行評估診斷。",
            "id": "7233dcf1-9d02-4e16-8904-c3ec0138b066"
        },
    // ... 更多歷史記錄
  ]
}
```

### 3.4 錯誤回應

#### 缺少必要參數

狀態碼：400

```json
{
  "error": "Missing required parameters"
}
```

#### 缺少用戶ID

狀態碼：400

```json
{
  "error": "Missing user_id"
}
```

#### 未知操作類型

狀態碼：400

```json
{
  "error": "Unknown action"
}
```

#### 伺服器內部錯誤

狀態碼：500

```json
{
  "error": "Internal server error: 錯誤詳情"
}
```

---

## 4. 查詢歷史記錄說明

- 系統會返回指定 user_id 最近三個月內的所有聊天記錄
- 記錄按時間戳（timestamp）排序，最新的記錄在前
- 返回的記錄數量不限，應用端可自行處理分頁等邏輯

---

## 5. 跨域支援

API 已啟用 CORS 支援，Web 應用可直接跨域呼叫，支援的 headers：
- Content-Type
- X-Amz-Date
- Authorization
- X-Api-Key

---

## 6. 串接範例

### 6.1 使用 cURL

```bash
# 查詢歷史
curl -X POST https://{api-id}.execute-api.{region}.amazonaws.com/prod/chat-history \
  -H "Content-Type: application/json" \
  -d '{"action":"history","user_id":"test123","rag_type":"health"}'
```

### 6.2 使用 JavaScript

```javascript
// 查詢歷史 - 可指定 RAG 類型
async function getHistory(userId, ragType = 'health') {
  const response = await fetch('https://{api-id}.execute-api.{region}.amazonaws.com/prod/chat-history', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      action: 'history',
      user_id: userId,
      rag_type: ragType
    })
  });
  
  return await response.json();
}
```

---

## 7. WebSocket API（串流回應）

### 7.1 WebSocket 端點

```
wss://{api-id}.execute-api.{region}.amazonaws.com/prod
```
> 請聯絡系統管理員取得正確的 WebSocket 端點

### 7.2 連接與斷開

WebSocket API 支援標準的連接和斷開操作：
- **連接**：瀏覽器或客戶端開啟 WebSocket 連接時自動觸發
- **斷開**：瀏覽器或客戶端關閉 WebSocket 連接時自動觸發

### 7.3 發送訊息格式

所有發送到 WebSocket 的訊息必須是合法的 JSON 格式，並包含 `type` 欄位用於 API Gateway 路由。

#### 7.3.0 取得 session_id

連接完成後，請先取得 session_id，用於對話分析。
```json
{
  "type": "sendmessage",
  "action": "get_session_id",
}
```

#### 7.3.1 問答模式

```json
{
  "type": "sendmessage",
  "action": "ask",
  "user_id": "app用戶唯一識別碼",
  "message": "用戶提問內容",
  "session_id": "對話階段ID",
  "topic_id" : "聊天主題",
  "rag_type": "health"
}
```

#### 7.3.2 歷史記錄查詢

```json
{
  "type": "sendmessage",
  "action": "history",
  "user_id": "app用戶唯一識別碼",
  "rag_type": "health"
}
```

#### 7.3.3 回饋提交

```json
{
  "type": "sendmessage",
  "action": "feedback",
  "id": "要評價的訊息ID",
  "rating": 1,  // 1=正面評價(有幫助), 0=負面評價(沒幫助)
  "feedback_text": "文字回饋內容（選填）"
}
```

### 7.4 接收訊息格式

#### 7.4.1 問答回應（串流模式）

當發送問答請求後，系統會透過 WebSocket 連接發送多則回應，包含：

##### 開始回應
```json
{
  "type": "start",
  "id": "783a1e9b-1234-5678-abcd-1234567890ab",
}
```

##### 內容片段（可能有多個）
```json
{
  "type": "chunk",
  "id": "783a1e9b-1234-5678-abcd-1234567890ab",
  "text": "這是回應的一部分內容..."
}
```

##### 完成回應
```json
{
  "type": "end",
  "id": "783a1e9b-1234-5678-abcd-1234567890ab",
}
```

#### 7.4.2 歷史記錄查詢回應
```json
{
  "type": "history_result",
  "user_id": "user123",
  "history": [
    {
      "user_id": "444",
      "session_id": "c5c1cc22-f149-4550-aa33-475cdb30ee69",
      "topic_id": "我的頭痛"
      "timestamp": "2025-04-30T08:13:35.159697",
      "rag_type": "health",
      "ttl": "1753776815",
      "message": "我的頭痛是怎麼了？",
      "bot_response": "根據提供的文檔資料,並沒有直接提到頭痛的相關資訊。不過,文檔5提到了心衰竭可能會導致腦部缺氧,從而影響大腦功能,造成焦慮、記憶力變差、失眠或頭暈等症狀。因此,若您同時也有心衰竭的症狀,頭痛可能與此有關。不過沒有更多個人病史細節,我無法確定您頭痛的具體原因。如果頭痛持續或加重,建議您儘快就醫,由專業醫師進行評估診斷。",
      "id": "7233dcf1-9d02-4e16-8904-c3ec0138b066"
    },
    // ... 更多歷史記錄
  ]
}
```

#### 7.4.3 回饋提交回應
```json
{
  "type": "feedback_received",
  "success": true
}
```

#### 7.4.4 錯誤回應
```json
{
  "type": "feedback_received",
  "success": false
}
```

### 7.7 限制與注意事項

- WebSocket 連接在閒置一段時間後（約10分鐘）會自動斷開
- 每個連接的並發訊息數量有限制
- 單個訊息大小限制為 128KB
- 建議實作重連機制以處理意外斷線情況
- 所有訊息必須是有效的 JSON 格式
- 路由選擇表達式使用 `$request.body.type` 進行消息分發
- 回饋系統建議在串流回應完成後再使用，以確保評價的是完整回應

---

如需更多細節或有特殊需求，請聯絡我們的技術團隊。

## 8. 注意事項

- 所有請求和回應必須是標準 JSON 格式
- 字符編碼必須為 UTF-8
- 數值欄位在回應中可能以字符串形式返回
- 請求體大小限制為 10MB

---

## 9. 聯絡支援

如遇到技術問題，請聯絡：
- 技術支援信箱：support@futurelab.com
- 聯絡電話：02-XXXX-XXXX

---

如需更多細節或有特殊需求，請聯絡我們的技術團隊。
