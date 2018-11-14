;;; init.el --- init.el
;;; Commentary:
;;; Code:
;;(setq debug-on-error t)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(set-frame-parameter nil 'fullscreen 'maximized)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))

(package-initialize)

;; When emacs for the first time execute only, automatic package install
(unless (file-directory-p "~/.emacs.d/elpa")
  (package-refresh-contents))

;; package
(package-install 'aggressive-indent)
(package-install 'alarm-clock)
(package-install 'auto-compile)
(package-install 'avy)
(package-install 'back-button)
(package-install 'beginend)
(package-install 'bind-key)
(package-install 'browse-at-remote)
(package-install 'coffee-mode)
(package-install 'company)
(package-install 'company-irony)
(package-install 'company-go)
(package-install 'company-php)
(package-install 'company-statistics)
(package-install 'company-tern)
(package-install 'counsel)
(package-install 'counsel-projectile)
(package-install 'counsel-tramp)
(package-install 'csv-mode)
(package-install 'dash)
(package-install 'dashboard)
(package-install 'docker)
(package-install 'docker-tramp)
(package-install 'dockerfile-mode)
(package-install 'dumb-jump)
(package-install 'easy-hugo)
(package-install 'easy-jekyll)
(package-install 'editorconfig)
(package-install 'edit-indirect)
(package-install 'elisp-slime-nav)
(package-install 'elpy)
(package-install 'enh-ruby-mode)
(package-install 'espy)
(package-install 'exec-path-from-shell)
(package-install 'expand-region)
(package-install 'f)
(package-install 'fill-column-indicator)
(package-install 'flycheck)
(package-install 'flycheck-irony)
(package-install 'flycheck-package)
(package-install 'flycheck-rust)
(package-install 'flycheck-title)
(package-install 'flyspell-correct)
(package-install 'flyspell-correct-ivy)
(package-install 'ggtags)
(package-install 'git-gutter)
(package-install 'git-timemachine)
(package-install 'go-eldoc)
(package-install 'go-impl)
(package-install 'go-mode)
(package-install 'go-projectile)
(package-install 'google-this)
(package-install 'google-translate)
(package-install 'hackernews)
(package-install 'haml-mode)
(package-install 'htmlize)
(package-install 'hydra)
(package-install 'indium)
(package-install 'inf-ruby)
(package-install 'init-loader)
(package-install 'irony)
(package-install 'irony-eldoc)
(package-install 'ivy-xref)
(package-install 'ivy-yasnippet)
(package-install 'jinja2-mode)
(package-install 'js2-mode)
(package-install 'json-mode)
(package-install 'keychain-environment)
(package-install 'key-chord)
(package-install 'lispy)
(package-install 'macrostep)
(package-install 'magit)
(package-install 'markdown-mode)
(package-install 'material-theme)
(package-install 'nginx-mode)
(package-install 'org-plus-contrib)
(package-install 'package-lint)
(package-install 'password-generator)
(package-install 'pcre2el)
(package-install 'php-mode)
(package-install 'pkgbuild-mode)
(package-install 'popwin)
(package-install 'projectile)
(package-install 'projectile-rails)
(package-install 'python-mode)
(package-install 'quickrun)
(package-install 'racer)
(package-install 'rbenv)
(package-install 'realgud)
(package-install 'realgud-byebug)
(package-install 'robe)
(package-install 'rspec-mode)
(package-install 'rust-mode)
(package-install 's)
(package-install 'slime)
(package-install 'slime-company)
(package-install 'slim-mode)
(package-install 'smartparens)
(package-install 'smex)
(package-install 'swiper)
(package-install 'tern)
(package-install 'tide)
(package-install 'toml-mode)
(package-install 'twig-mode)
(package-install 'typescript-mode)
(package-install 'visual-regexp)
(package-install 'volatile-highlights)
(package-install 'web-mode)
(package-install 'which-key)
(package-install 'xref-js2)
(package-install 'yaml-mode)
(package-install 'yasnippet)
(package-install 'yasnippet-snippets)
(package-install 'zeal-at-point)

;; auto-compile
(setq load-prefer-newer t)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

;; init-loader
(custom-set-variables
 '(init-loader-show-log-after-init 'error-only))
(init-loader-load)
(setq custom-file (locate-user-emacs-file "custom.el"))

(provide 'init)
;;; init.el ends here
