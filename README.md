# TT-Notify
a script to change the notify system for fivem
# 🔔 TT Scripts — tt_notify (Cyber Toast Notification Suite)
### *0.00 ms Idle Resmon | Synthesized Web Audio Cues | Universal Framework Bridge*

A lightweight, modern, and beautiful toast notification replacement for FiveM servers running **QBCore, ESX Legacy, QBox, or Standalone (ox_lib)**.

---

## ✨ Features
* ⚡ **0.00 ms Idle Resmon:** Pure event-driven JavaScript/NUI with zero CPU lag.
* 🎵 **Web Audio API Sound Synthesis:** Includes 5 synthesized sound cues (Success, Info, Warning, Error, Neutral) without needing heavy external audio files.
* 🎨 **Frosted Glass Cyberpunk Styling:** Modern dark-mode UI with animated progress timers.
* 🌉 **Drop-In Replacement:** Compatible with QBCore `QBCore.Functions.Notify`, ESX `esx:showNotification`, and `ox_lib:notify`.

---

## 🛠️ Installation
1. Extract `tt_notify` into your FiveM server's `resources/` directory.
2. Add `ensure tt_notify` to your `server.cfg`.
3. Restart your server!

---

## 💻 Export Usage Example:
```lua
-- Client side:
exports['tt_notify']:Notify('Vehicle engine started successfully.', 'success', 4000)
exports['tt_notify']:Notify('Warning: Low engine oil detected.', 'warning', 5000)
exports['tt_notify']:Notify('Transaction failed: Insufficient funds.', 'error', 4000)
