# 🔔 tt_notify — High-Performance NUI Notifications
[![FiveM](https://img.shields.io/badge/FiveM-Resource-blue.svg?style=for-the-badge)](https://fivem.net/)
[![Framework](https://img.shields.io/badge/Framework-Standalone%20%7C%20QBCore%20%7C%20ESX%20%7C%20ox__lib-success.svg?style=for-the-badge)](https://github.com/)
[![Performance](https://img.shields.io/badge/Resmon-0.00ms%20Idle-brightgreen.svg?style=for-the-badge)](https://github.com/)
[![License](https://img.shields.io/badge/License-Proprietary%20%2F%20Escrow-red.svg?style=for-the-badge)](https://github.com/)

A sleek, responsive, and lightweight toast notification system designed for FiveM. Built with pure custom CSS and vendored React 18, `tt_notify` provides **100% offline functionality**, zero external CDN dependencies, XSS sanitization, and seamless drop-in replacement for default framework notifications.

---

## 🌟 Key Features
- **0.00 ms Idle Resmon:** Event-driven architecture with zero background tick overhead.
- **100% Offline & Firewall Safe:** All FontAwesome icons and webfonts are vendored locally.
- **Built-in XSS Protection:** Escapes HTML automatically to prevent malicious injection attacks.
- **Drop-in Compatibility:** Listens for standard `ox_lib:notify` and `QBCore:Notify` events automatically.
- **Customizable Themes:** Easy customization of notification colors, durations, sounds, and icons in `config.lua`.

---

## 💻 Developer API & Usage Examples

### 1. Client-Side Usage

#### Export Call (Positional):
```lua
-- Signature: exports['tt_notify']:Notify(title, description, type, duration)
exports['tt_notify']:Notify('Transaction Approved', 'Your bank payment of $5,000 has cleared.', 'success', 5000)
```

#### Export Call (Table Format / ox_lib Style):
```lua
exports['tt_notify']:Notify({
    title = 'Security Alert',
    description = 'Your vehicle alarm has been triggered!',
    type = 'error',
    duration = 6000
})
```

#### Client Event Trigger:
```lua
TriggerEvent('tt_notify:client:SendAlert', 'Mission Complete', 'You earned 500 XP and $2,500.', 'success', 5000)
```

---

### 2. Server-Side Usage

#### Export Call:
```lua
-- Signature: exports['tt_notify']:Notify(targetSource, title, description, type, duration)
local targetSource = source
exports['tt_notify']:Notify(targetSource, 'Bank Deposit', 'Received paycheck of $1,250.', 'success', 6000)
```

#### Server Event Trigger to Client:
```lua
TriggerClientEvent('tt_notify:client:SendAlert', targetSource, 'Dispatch Alert', '10-99: Armed Robbery in Progress', 'police', 8000)
```

---

## 🎨 Available Notification Types

| Type | Default Title | Accent Color | Icon |
| :--- | :--- | :---: | :---: |
| `'success'` | SUCCESS | Emerald Green | `fa-circle-check` |
| `'error'` | ERROR | Crimson Red | `fa-circle-xmark` |
| `'warning'` | WARNING | Amber Yellow | `fa-triangle-exclamation` |
| `'inform'` | INFORMATION | Royal Blue | `fa-circle-info` |
| `'police'` / `'dispatch'` | DISPATCH | Deep Blue | `fa-shield-halved` |
| `'bank'` / `'banking'` | BANKING | Teal | `fa-building-columns` |
| `'admin'` | ADMINISTRATION | Purple | `fa-screwdriver-wrench` |

---

## 📋 Installation
1. Place the `tt_notify` folder inside your server's `resources/` directory.
2. Add `ensure tt_notify` to your `server.cfg`.
3. Customize sounds, layout position, and duration presets in `config.lua`.
