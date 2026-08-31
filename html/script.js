const { useState, useEffect, createElement: h } = React;

class HapticAudioBus {
    constructor() { this.ctx = null; }
    init() {
        if (!this.ctx) {
            const AudioCtx = window.AudioContext || window.webkitAudioContext;
            this.ctx = new AudioCtx();
        }
        if (this.ctx.state === 'suspended') this.ctx.resume();
    }
    playTone(type) {
        if (!this.ctx) return;
        const osc = this.ctx.createOscillator();
        const gain = this.ctx.createGain();
        const now = this.ctx.currentTime;

        if (type === 'success' || type === 'bank') {
            osc.type = 'sine';
            osc.frequency.setValueAtTime(587.33, now);
            osc.frequency.setValueAtTime(880, now + 0.08);
            gain.gain.setValueAtTime(0.06, now);
            gain.gain.exponentialRampToValueAtTime(0.001, now + 0.18);
            osc.start(now); osc.stop(now + 0.18);
        } else if (type === 'error') {
            osc.type = 'sawtooth';
            osc.frequency.setValueAtTime(320, now);
            osc.frequency.setValueAtTime(200, now + 0.08);
            gain.gain.setValueAtTime(0.06, now);
            gain.gain.exponentialRampToValueAtTime(0.001, now + 0.2);
            osc.start(now); osc.stop(now + 0.2);
        } else if (type === 'warning') {
            osc.type = 'triangle';
            osc.frequency.setValueAtTime(440, now);
            osc.frequency.setValueAtTime(350, now + 0.08);
            gain.gain.setValueAtTime(0.06, now);
            gain.gain.exponentialRampToValueAtTime(0.001, now + 0.18);
            osc.start(now); osc.stop(now + 0.18);
        } else {
            osc.type = 'sine';
            osc.frequency.setValueAtTime(650, now);
            gain.gain.setValueAtTime(0.04, now);
            gain.gain.exponentialRampToValueAtTime(0.001, now + 0.1);
            osc.start(now); osc.stop(now + 0.1);
        }

        osc.connect(gain);
        gain.connect(this.ctx.destination);
    }
}
const haptics = new HapticAudioBus();

function NotifyContainer() {
    const [toasts, setToasts] = useState([]);

    useEffect(() => {
        const handleMessage = (e) => {
            const data = e.data;
            if (!data || data.action !== 'notify') return;

            haptics.init();
            haptics.playTone(data.type || 'inform');

            const duration = data.duration || 4500;
            const id = Date.now() + Math.random();
            const newToast = {
                id,
                title: data.title || 'SYSTEM',
                description: data.description || '',
                type: data.type || 'inform',
                duration: duration,
                leaving: false
            };

            setToasts(prev => [newToast, ...prev].slice(0, 5));

            // Start slide out slightly before removal
            setTimeout(() => {
                setToasts(prev => prev.map(t => t.id === id ? { ...t, leaving: true } : t));
            }, duration - 250);

            setTimeout(() => {
                setToasts(prev => prev.filter(t => t.id !== id));
            }, duration);
        };

        window.addEventListener('message', handleMessage);
        return () => window.removeEventListener('message', handleMessage);
    }, []);

    const getIcon = (type, title) => {
        if (title && (title.includes('ANNOUNCEMENT') || title.includes('BROADCAST'))) return 'fa-bullhorn';
        switch(type) {
            case 'success': return 'fa-circle-check';
            case 'error': return 'fa-circle-xmark';
            case 'warning': return 'fa-triangle-exclamation';
            case 'police': return 'fa-shield-halved';
            case 'bank': return 'fa-vault';
            case 'level_up': return 'fa-star';
            case 'announcement': return 'fa-bullhorn';
            default: return 'fa-circle-info';
        }
    };

    return h('div', { className: 'toast-container' },
        toasts.map(t => h('div', {
            key: t.id,
            className: `toast-item toast-${(t.title && (t.title.includes('ANNOUNCEMENT') || t.title.includes('BROADCAST'))) ? 'announcement' : t.type} ${t.leaving ? 'toast-leaving' : ''}`
        },
            h('div', { className: 'toast-icon-wrapper' },
                h('i', { className: `fa-solid ${getIcon(t.type, t.title)}` })
            ),
            h('div', { className: 'toast-body' },
                h('div', { className: 'toast-badge-title' }, t.title),
                h('div', { className: 'toast-desc' }, t.description)
            ),
            h('div', {
                className: 'toast-progress',
                style: { animationDuration: `${t.duration}ms` }
            })
        ))
    );
}

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(h(NotifyContainer));
