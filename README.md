[English](./README.en.md)

# Private Finance Advisory Board Suite

`private-finance-advisory-board-suite` 是一套可攜、供應商中立的私人財務決策 skill。

它不是單純把幾個理財名人塞在一起，而是把「協調器、記憶層、角色路由、決策格式、驗證與打包腳本」整成一個可以長期使用的財務顧問工作流，讓你在支出、負債、投資、現金流、保險、資產配置與收入策略上，都能用同一套方法做出更穩定的判斷。

如果你的痛點是這些：

- 遇到財務決策時，知道要考慮很多面向，但很難把不同風格的建議整合成一個結論
- 想同時兼顧保守風控、數字推演、收入成長與長期行為風險
- 每次問完 AI 都像一次性對話，沒有把關鍵背景和結論沉澱下來
- 想公開分享一套可以被別人複用的私人財務決策框架，而不是一串零散 prompt

這套 suite 就是為這種情境設計的。

它不保證幫你賺更多錢。

它做的是把財務決策拆成更清楚的角色分工，讓你更容易得到可追溯、可持續、可寫回記憶的結論。

## Release Status

`v1.0.0` 是這個 suite 的第一個公開穩定版本。

- 核心架構會維持不變：協調器、記憶層、persona bundles、腳本工具
- 後續版本如果有新增內容，會盡量保持相容，不破壞現有使用方式
- 如果你是第一次接觸這個 repo，請先讀 `GUIDE.md`

## 這套 suite 會幫你做什麼

### 1. 先分類問題，再叫對的人上場

協調器不會每次都把所有角色一起叫出來。

它會先判斷這題比較像：

- 負債與現金流壓力
- 投資、估值、資產配置
- 收入成長與系統設計
- 高不確定性與長期行為風險
- 一般例行財務問題

然後只路由到最小但足夠的角色組合。

### 2. 讓不同理財風格在同一個決策裡協作

這套系統的五人董事會由以下角色構成：

- Market Mr. Xu：量化取捨、現金流、估值、情境推演
- Dave Ramsey：債務、預算紀律、下檔保護
- Ramit Sethi：收入成長、自動化、可執行的理財系統
- Morgan Housel：長期可存活性、行為風險、留有餘地
- Chief of Staff：最後整合、仲裁衝突、決定寫回哪些記憶

其中前四位是實際打包進 repo 的 persona skill，`Chief of Staff` 則由主協調器扮演，所以整套是「一個 orchestrator + 四個 persona bundle = 五人決策董事會」。

### 3. 把重要背景寫進記憶，而不是每次重講

這套 suite 內建了可持續更新的記憶層：

- `memory/profile.md`
- `memory/preferences.md`
- `memory/financial-state.md`
- `memory/open-questions.md`
- `memory/decision-log.md`

所以它不只是回答一次問題，而是讓後續決策可以建立在先前的背景、偏好、財務狀態與決策紀錄上。

### 4. 讓輸出格式固定，方便追蹤和回寫

標準輸出會要求至少包含：

- Decision type
- Personas used
- Current state summary
- Recommendation
- Risks and tradeoffs
- Next action
- Memory writeback

這讓你更容易把一次回答變成可留存的決策紀錄，而不是一大段不容易回看的建議。

### 5. 保持模型可攜，不把 skill 鎖死在單一供應商

這套 skill 有一個很重要的設計原則：

- `SKILL.md` 不硬編碼模型品牌或版本
- 協調器只描述角色，不綁定 OpenAI、Claude、Google 的具體型號
- 真正的模型映射交給 host runtime 處理

所以當平台升級模型時，你不用重寫 skill 本身。

## 構建邏輯

這個 repo 的結構不是隨便分資料夾，而是刻意拆成五層：

| 層級 | 作用 | 代表檔案 |
|---|---|---|
| Orchestrator | 負責分類問題、讀取記憶、路由角色、整合最終結論 | `SKILL.md`, `agents/openai.yaml` |
| References | 定義路由規則、模型政策、輸出格式、記憶 schema | `references/*.md` |
| Memory | 保存穩定背景、當前財務狀態、未解問題與決策日誌 | `memory/*.md` |
| Personas | 提供四位專家 persona 的原始蒸餾能力與風格 | `personas/*/SKILL.md` |
| Scripts | 初始化記憶、記錄決策、驗證結構、打包 zip | `scripts/*.ps1` |

工作流大致如下：

```text
User question
  -> Orchestrator classifies the decision
  -> Read memory and current financial state
  -> Route to the smallest useful persona set
  -> Synthesize conflicts into one recommendation
  -> Write the conclusion back to memory
```

如果你要對外介紹這套 skill，最值得講清楚的不是「有哪些名人」，而是這個編排方式：

- persona 負責提供不同思維框架
- orchestrator 負責選人、仲裁與最後決策
- memory 讓系統越用越知道你的上下文
- references 把規則明文化，降低行為漂移
- scripts 讓這套東西可以被驗證、重建與發佈

## 建議使用方式

### 第一次使用

1. 先讀 `GUIDE.md`，再讀 `SKILL.md`。
2. 把這個資料夾放進你的 skill 或 workspace 目錄。
3. 先確認 `memory/` 內五個檔案存在。
4. 如果要重建記憶骨架，執行：

```powershell
.\scripts\initialize-memory.ps1
```

5. 用一個具體財務問題啟動它，例如：

```text
Use $private-finance-advisory-board to analyze this financial decision with the five-person team and write the conclusion back to memory.
```

### 平常提問時

你可以一次只問一個決策，效果通常最好，例如：

- 我應該先提前還清信用卡債，還是保留更多現金當緊急預備金？
- 我現在的現金流適不適合開始定期投入 ETF？
- 我該不該為了更高薪資換工作，如果代價是不穩定和搬家？
- 我想替家庭補保險，應該先補哪一塊？

### 系統回覆後

建議你檢查三件事：

- 這次用了哪些 persona，是否符合問題性質
- 關鍵假設有沒有缺資料
- Memory writeback 是否值得寫入長期紀錄

如果資料不足，這套 skill 應該先向你追問最小必要資訊，而不是直接給高信心結論。

## 推薦工作流

### 工作流 A：單次財務決策

1. 丟出具體問題
2. 讓系統讀取 `profile`、`preferences`、`financial-state`
3. 由協調器路由到最小角色集合
4. 收到結論後，把重要決策寫回 `decision-log`

### 工作流 B：更新財務快照後再決策

1. 先更新 `memory/financial-state.md`
2. 再問這次的決策問題
3. 對照新的現金流、負債、目標與時限重新評估

### 工作流 C：把未解問題留給下次續跑

1. 遇到缺資料的決策
2. 讓系統回覆 `needs_more_data`
3. 把缺口與 follow-up 寫進 `memory/open-questions.md`
4. 下次補齊資料後接續

## 內建腳本

### 初始化與記錄

- `scripts/initialize-memory.ps1`
  - 建立或補齊五個記憶檔案
- `scripts/log-decision.ps1`
  - 追加一筆決策到 `memory/decision-log.md`
  - 當 recommendation 是 `needs_more_data` 時，也會同步寫入 `memory/open-questions.md`

### 驗證

- `scripts/validate-package.ps1`
  - 檢查核心 skill 套件是否完整
- `scripts/validate-suite.ps1`
  - 檢查完整 suite 是否包含 orchestrator、memory、references 與四個 persona bundle

### 打包

- `scripts/package-skill.ps1`
  - 打包不含 persona bundle 的核心 skill
- `scripts/package-suite.ps1`
  - 打包完整 suite，輸出到 `dist/private-finance-advisory-board-suite.zip`

## 安裝

### 方式 1：直接作為 repo 使用

```bash
git clone <your-repo-url>
```

接著把 `private-finance-advisory-board-suite` 放進你的 skill/workspace 目錄，讓 host 可以讀到 `SKILL.md` 與 `agents/openai.yaml`。

### 方式 2：打包後分享

先驗證：

```powershell
.\scripts\validate-suite.ps1
```

再打包：

```powershell
.\scripts\package-suite.ps1
```

如果你只想分享核心 orchestrator skill，而不是完整 persona bundle，可以改用：

```powershell
.\scripts\validate-package.ps1
.\scripts\package-skill.ps1
```

### Versioning

- `v1.0.0` is the first public stable release
- Future versions may add material, but the core architecture should stay compatible
- If you are new to the project, read `GUIDE.md` before running the suite

## 目錄結構

```text
private-finance-advisory-board-suite/
|- SKILL.md
|- GUIDE.md
|- README.md
|- README.en.md
|- agents/
|  |- openai.yaml
|- memory/
|  |- profile.md
|  |- preferences.md
|  |- financial-state.md
|  |- open-questions.md
|  |- decision-log.md
|- references/
|  |- decision-format.md
|  |- memory-schema.md
|  |- model-policy.md
|  |- orchestration.md
|  |- personas.md
|  |- suite-index.md
|- personas/
|  |- market-mr-xu-jiyuan/
|  |- dave-ramsey/
|  |- ramit-sethi/
|  |- morgan-housel/
|- scripts/
|  |- initialize-memory.ps1
|  |- log-decision.ps1
|  |- package-skill.ps1
|  |- package-suite.ps1
|  |- validate-package.ps1
|  |- validate-suite.ps1
|- dist/
```

## 適合誰

這套 suite 特別適合：

- 想把理財提問從單次聊天變成長期決策系統的人
- 想同時吸收不同理財流派，但最後仍需要一個清楚結論的人
- 想公開分享一套可重用的財務 decision board 結構的人
- 想把 persona、memory、routing、packaging 都整理成可發佈 repo 的人

如果你只想快速問一句「這檔股票能不能買」，它也能回答。

但這套系統真正的價值，是在你反覆使用、持續累積記憶、讓決策越來越貼近你真實財務狀態的時候。

## 相關文件

- `GUIDE.md`
- `references/memory-schema.md`
- `references/orchestration.md`
- `references/model-policy.md`
- `references/personas.md`
- `references/decision-format.md`
- `references/suite-index.md`

## Disclaimer

這是一套私人財務決策輔助 skill，不是持牌的投資、稅務或法律意見。任何高風險、高金額或涉法規的決策，都應搭配合格專業人士共同確認。
