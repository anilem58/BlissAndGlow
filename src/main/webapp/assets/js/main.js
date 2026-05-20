/* Bliss and Glow — main.js */
(function () {
    'use strict';

    // ── Password strength indicator ───────────────────────────────────
    const pwdField = document.getElementById('password');
    const pwdHint  = document.getElementById('passwordHint');
    if (pwdField && pwdHint) {
        pwdField.addEventListener('input', function () {
            const v = this.value;
            const strong = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$!%*?&]).{8,}$/.test(v);
            const medium = v.length >= 8;
            if (strong)  { pwdHint.textContent = '✔ Strong password'; pwdHint.style.color = '#155724'; }
            else if (medium) { pwdHint.textContent = '⚠ Add uppercase, digit & special char'; pwdHint.style.color = '#856404'; }
            else         { pwdHint.textContent = '✖ Too short (min 8 chars)'; pwdHint.style.color = '#721c24'; }
        });
    }

    // ── Confirm-password match ────────────────────────────────────────
    const confirmField = document.getElementById('confirmPassword');
    const matchHint    = document.getElementById('confirmHint');
    if (confirmField && matchHint && pwdField) {
        confirmField.addEventListener('input', function () {
            if (this.value === pwdField.value) {
                matchHint.textContent = '✔ Passwords match'; matchHint.style.color = '#155724';
            } else {
                matchHint.textContent = '✖ Passwords do not match'; matchHint.style.color = '#721c24';
            }
        });
    }

    // ── Wishlist heart toggle (visual, no page reload for UX feedback) ─
    document.querySelectorAll('.wishlist-toggle').forEach(function (btn) {
        btn.addEventListener('click', function () {
            const icon = this.querySelector('.heart-icon');
            if (icon) icon.classList.toggle('active');
        });
    });

    // ── Flash-message auto-dismiss ────────────────────────────────────
    document.querySelectorAll('.alert-auto').forEach(function (el) {
        setTimeout(function () {
            el.style.transition = 'opacity .5s';
            el.style.opacity = '0';
            setTimeout(function () { el.remove(); }, 500);
        }, 4000);
    });

    // ── Cart quantity stepper ─────────────────────────────────────────
    document.querySelectorAll('.qty-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {
            const stepper = this.closest('.qty-stepper');
            const input   = stepper ? stepper.querySelector('.qty-input') : null;
            if (!input) return;
            const delta  = this.dataset.dir === 'up' ? 1 : -1;
            const newVal = Math.max(1, (parseInt(input.value) || 1) + delta);
            input.value  = newVal;
        });
    });

    // ── Confirm before delete / cancel ───────────────────────────────
    document.querySelectorAll('.btn-confirm-delete').forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            const msg = this.dataset.confirm || 'Are you sure? This cannot be undone.';
            if (!confirm(msg)) {
                e.preventDefault();
            }
        });
    });

    // ── Mobile nav toggle ─────────────────────────────────────────────
    const navToggle = document.getElementById('navToggle');
    const siteNav   = document.getElementById('siteNavMenu');
    if (navToggle && siteNav) {
        navToggle.addEventListener('click', function () {
            siteNav.classList.toggle('open');
        });
    }

    // ── Image preview on file select ──────────────────────────────────
    const imgInput   = document.getElementById('imageInput');
    const imgPreview = document.getElementById('imagePreview');
    if (imgInput && imgPreview) {
        imgInput.addEventListener('change', function () {
            const file = this.files[0];
            if (!file) return;
            const reader = new FileReader();
            reader.onload = function (e) { imgPreview.src = e.target.result; imgPreview.style.display = 'block'; };
            reader.readAsDataURL(file);
        });
    }
})();
