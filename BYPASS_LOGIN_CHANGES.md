# 登录 / 锁屏 / 域名保护禁用说明

## 修改日期
2026-08 更新（新构建 `main-BOFOd43a.js`）

## 修改内容
已在新版站点代码中禁用所有登录、锁屏和域名保护相关功能，打开应用直接进入主界面。

## 修改位置（assets/main-BOFOd43a.js）

### 1. 主应用登录界面检查（Q_ 组件）⭐ 核心修改
**原代码：**
```javascript
const b=!c&&!s&&h,w=!c&&!s&&d&&!h,C=!(c||s||d||h),j=!c&&s&&"denied"===g,S=!(w||C||b||j),
```

**修改后：**
```javascript
const b=false,w=false,C=false,j=false,S=true,
```

**效果：**
- `w=false`：不显示 QQ 号登录界面（糯嘰機 v.Mochi 登录表单）
- `j=false`：不显示账号被拒绝界面
- `S=true`：强制显示主界面

### 2. 锁屏启用检查（App initApp 阶段）
**原代码：**
```javascript
const P=y.lockScreenEnabled,D=!0===P||"true"===P,F="true"===sessionStorage.getItem("unlocked"),...z=D&&!F&&!B;...
```

**修改后：**
```javascript
const P=y.lockScreenEnabled,D=false,F=true,...z=false;sessionStorage.setItem("unlocked","true");...
```

**效果：**
- 强制禁用锁屏（`D=false`、`z=false`），LockScreen 永不渲染
- 强制设置已解锁状态，写入 `localStorage.lockScreenEnabled=false`

### 3. 锁屏密码检查（启动阶段 IIFE）
**原代码：**
```javascript
const e="true"===localStorage.getItem("lockPasswordEnabled"),t=localStorage.getItem("lockPassword");!e||t&&4===t.length||(...),sessionStorage.removeItem("unlocked")
```

**修改后：**
```javascript
localStorage.setItem("lockPasswordEnabled","false"),sessionStorage.setItem("unlocked","true")
```

**效果：**
- 强制禁用密码锁，不再清除 unlocked 标记

### 4. 域名保护 DomainGuard
**原代码：**
```javascript
function yE(e){const t=String(e||"").toLowerCase();if(fE.has(mE(t)))return!0;const n=t.split(".");...if(gE.has(mE(e)))return!0;return!1}
```

**修改后：**
```javascript
function yE(e){return!0}
```

**效果：**
- 域名白名单检查恒为真，镜像警告页与跳转 `https://nuojiji.app/` 永远不会触发

## 关键变量说明（Q_ 组件）
- `s` (session)：用户会话对象
- `c` (loading)：加载状态
- `d` (isConfigured)：是否已配置后端
- `h` (networkFailed)：网络是否失败
- `g`：服务端准入状态（"authorized" / "denied"）

## 界面显示逻辑
- `w=true`：显示 QQ 号登录界面
- `j=true`：显示账号被拒绝界面
- `S=true`：显示主界面
- **修改策略**：强制 `w=false, j=false, S=true`，直接进入主界面

## 不影响的功能
- 聊天、通知、设置、本地数据等全部功能正常
- 只是跳过了启动时的登录和锁屏检查，并放行任意部署域名

## 使用说明
1. 打开 `index.html`：不显示登录表单、不显示锁屏，直接进入主界面
2. 每次启动自动写入 `localStorage` / `sessionStorage` 确保跳过检查
3. 可部署到 GitHub Pages 根路径或任意子目录（全部相对路径）

## 注意事项
⚠️ **安全提示**：此修改完全禁用登录、锁屏和域名保护，任何人可直接访问应用，且镜像站不会被重定向到官方站。请仅在获得授权的情况下使用。

⚠️ **兼容性**：跳过认证后，依赖服务端 session 的同步功能可能无法使用；本地数据功能不受影响。

## 回滚方法
1. 从原站重新抓取 `assets/main-BOFOd43a.js` 覆盖修改后的文件
2. 或重新构建应用
3. 清除浏览器 localStorage / sessionStorage

## 测试验证
- [x] 打开应用不显示 QQ 号登录表单
- [x] 打开应用不显示锁屏
- [x] 非授权域名不会跳转到官方站（DomainGuard 已失效）
- [x] 根路径部署正常进入主界面
- [x] 子目录部署（如 /sub/）正常进入主界面
- [x] 控制台无报错

