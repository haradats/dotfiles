;;; 09misc.el --- 09misc.el
;;; Commentary:
;;; Code:
;;(setq debug-on-error t)

(minions-mode 1)

(eval-after-load "calendar"
  '(progn
     (require 'japanese-holidays)
     (setq calendar-holidays ; 他の国の祝日も表示させたい場合は適当に調整
           (append japanese-holidays holiday-local-holidays holiday-other-holidays))
     (setq calendar-mark-holidays-flag t) ; 祝日をカレンダーに表示
     ;; 土曜日・日曜日を祝日として表示する場合、以下の設定を追加します。
     ;; 変数はデフォルトで設定済み
     (setq japanese-holiday-weekend '(0 6)     ; 土日を祝日として表示
           japanese-holiday-weekend-marker     ; 土曜日を水色で表示
           '(holiday nil nil nil nil nil japanese-holiday-saturday))
     (add-hook 'calendar-today-visible-hook 'japanese-holiday-mark-weekend)
     (add-hook 'calendar-today-invisible-hook 'japanese-holiday-mark-weekend)
     ;; “きょう”をマークするには以下の設定を追加します。
     (add-hook 'calendar-today-visible-hook 'calendar-mark-today)))

;; tldr
(with-eval-after-load 'tldr
  (bind-key "." 'help-go-forward tldr-mode-map)
  (bind-key "," 'help-go-back tldr-mode-map)
  (bind-key "n" 'forward-line tldr-mode-map)
  (bind-key "p" 'previous-line tldr-mode-map))


;; prescient
(ivy-prescient-mode 1)
(company-prescient-mode 1)
(prescient-persist-mode 1)


;; expand-region
(require 'expand-region)
(push 'er/mark-outside-pairs er/try-expand-list)
(bind-key "C-M-SPC" 'er/expand-region)


;; begin-end
(beginend-global-mode)


;; restclient-test
(add-hook 'restclient-mode-hook #'restclient-test-mode)


;; editorconfig
(editorconfig-mode 1)
(setq editorconfig-get-properties-function
      'editorconfig-core-get-properties-hash)


;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain
      ediff-split-window-function 'split-window-horizontally
      ediff-diff-options "-twB")


;; volatile-highlights
(require 'volatile-highlights)
(volatile-highlights-mode t)


;; quickrun
(bind-key "<f5>" 'quickrun)


;; pcre
(require 'pcre2el)
(add-hook 'prog-mode-hook 'rxt-mode)
(setq reb-re-syntax 'pcre)


;; dumb-jump
(dumb-jump-mode)
(setq dumb-jump-selector 'ivy)


;; smart-jump
(smart-jump-setup-default-registers)


;; yesnippet
(require 'yasnippet)
(yas-global-mode 1)


;; projectile
(projectile-mode)
(counsel-projectile-mode)

;; How to clear cache (M-x projectile-invalidate-cache)
(setq projectile-enable-caching t)
;; require ggtags
(setq projectile-tags-file-name "GTAGS")
(setq projectile-tags-command "gtags")


;; ggtags
;; (add-hook 'php-mode-hook 'ggtag-setting)
;; ;;(add-hook 'enh-ruby-mode-hook 'ggtag-setting)
;; (add-hook 'c-mode-common-hook 'ggtag-setting)
;; (add-hook 'js2-mode-hook 'ggtag-setting)
;; (add-hook 'js2-jsx-mode-hook 'ggtag-setting)
(defun ggtag-setting ()
  "Setup ggtag."
  (ggtags-mode 1))


;; Fill-Column-Indicator
(setq fci-rule-column 100)


;; alarm-clock
(setq alarm-clock-sound-file "~/backup/emacs/alarm.mp3")


;; color-identifiers-mode
(add-hook 'after-init-hook 'global-color-identifiers-mode)


;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; 09misc.el ends here
