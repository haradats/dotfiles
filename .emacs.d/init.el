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


;; A workaround for a bug that occurs with gnutls 3.6 and emacs 26.1 emacs 26.2
(when (and (= emacs-major-version 26) (or (= emacs-minor-version 1) (= emacs-minor-version 2)))
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))


;; When emacs for the first time execute only, automatic package install
(unless (file-directory-p "~/.emacs.d/elpa")
  (package-refresh-contents)
  (package-install 'ace-window)
  (package-install 'add-node-modules-path)
  (package-install 'ag)
  (package-install 'aggressive-indent)
  (package-install 'alarm-clock)
  (package-install 'async)
  (package-install 'auto-compile)
  (package-install 'avy)
  (package-install 'back-button)
  (package-install 'beginend)
  (package-install 'bind-key)
  (package-install 'browse-at-remote)
  (package-install 'closql)
  (package-install 'color-identifiers-mode)
  (package-install 'company)
  (package-install 'company-prescient)
  (package-install 'company-quickhelp)
  (package-install 'company-restclient)
  (package-install 'counsel)
  (package-install 'counsel-css)
  (package-install 'counsel-projectile)
  (package-install 'counsel-tramp)
  (package-install 'csv-mode)
  (package-install 'daemons)
  (package-install 'dart-mode)
  (package-install 'dash)
  (package-install 'dashboard)
  (package-install 'deadgrep)
  (package-install 'diff-hl)
  (package-install 'docker)
  (package-install 'docker-tramp)
  (package-install 'dockerfile-mode)
  (package-install 'dumb-jump)
  (package-install 'eacl)
  (package-install 'easy-escape)
  (package-install 'easy-hugo)
  (package-install 'easy-jekyll)
  (package-install 'edit-indirect)
  (package-install 'editorconfig)
  (package-install 'editorconfig-generate)
  (package-install 'eglot)
  (package-install 'eldoc-box)
  (package-install 'elisp-slime-nav)
  (package-install 'elixir-mode)
  (package-install 'emacsql)
  (package-install 'emacsql-sqlite)
  (package-install 'espy)
  (package-install 'exec-path-from-shell)
  (package-install 'expand-region)
  (package-install 'f)
  (package-install 'fill-column-indicator)
  (package-install 'find-file-in-project)
  (package-install 'flymake)
  (package-install 'flymake-diagnostic-at-point)
  (package-install 'flyspell-correct)
  (package-install 'flyspell-correct-ivy)
  (package-install 'forge)
  (package-install 'fullframe)
  (package-install 'ggtags)
  (package-install 'ghub)
  (package-install 'git-commit)
  (package-install 'git-timemachine)
  (package-install 'github-explorer)
  (package-install 'go-mode)
  (package-install 'google-c-style)
  (package-install 'google-this)
  (package-install 'google-translate)
  (package-install 'haml-mode)
  (package-install 'hcl-mode)
  (package-install 'hierarchy)
  (package-install 'htmlize)
  (package-install 'hydra)
  (package-install 'iedit)
  (package-install 'imenu-anywhere)
  (package-install 'inf-ruby)
  (package-install 'inflections)
  (package-install 'init-loader)
  (package-install 'ivy)
  (package-install 'ivy-prescient)
  (package-install 'ivy-xref)
  (package-install 'ivy-yasnippet)
  (package-install 'js2-mode)
  (package-install 'json-mode)
  (package-install 'json-navigator)
  (package-install 'json-reformat)
  (package-install 'json-snatcher)
  (package-install 'jsonrpc)
  (package-install 'key-chord)
  (package-install 'keycast)
  (package-install 'keychain-environment)
  (package-install 'know-your-http-well)
  (package-install 'kubernetes)
  (package-install 'let-alist)
  (package-install 'lispy)
  (package-install 'list-utils)
  (package-install 'load-relative)
  (package-install 'loc-changes)
  (package-install 'lv)
  (package-install 'macrostep)
  (package-install 'magit)
  (package-install 'magit-popup)
  (package-install 'markdown-mode)
  (package-install 'markdown-toc)
  (package-install 'material-theme)
  (package-install 'minions)
  (package-install 'nav-flash)
  (package-install 'nginx-mode)
  (package-install 'nodejs-repl)
  (package-install 'openwith)
  (package-install 'org-plus-contrib)
  (package-install 'package-lint)
  (package-install 'package-lint-flymake)
  (package-install 'packed)
  (package-install 'page-break-lines)
  (package-install 'password-generator)
  (package-install 'pcache)
  (package-install 'pcre2el)
  (package-install 'persistent-soft)
  (package-install 'pkg-info)
  (package-install 'pkgbuild-mode)
  (package-install 'popup)
  (package-install 'popwin)
  (package-install 'pos-tip)
  (package-install 'posframe)
  (package-install 'prescient)
  (package-install 'projectile)
  (package-install 'projectile-rails)
  (package-install 'python-mode)
  (package-install 'quickrun)
  (package-install 'rake)
  (package-install 'realgud)
  (package-install 'realgud-byebug)
  (package-install 'reformatter)
  (package-install 'repl-toggle)
  (package-install 'request)
  (package-install 'restclient)
  (package-install 'restclient-test)
  (package-install 'rg)
  (package-install 'rjsx-mode)
  (package-install 'rspec-mode)
  (package-install 'rust-mode)
  (package-install 's)
  (package-install 'scss-mode)
  (package-install 'slim-mode)
  (package-install 'sly)
  (package-install 'sly-macrostep)
  (package-install 'smart-jump)
  (package-install 'smartparens)
  (package-install 'smartrep)
  (package-install 'spinner)
  (package-install 'swiper)
  (package-install 'symbol-overlay)
  (package-install 'tablist)
  (package-install 'terraform-mode)
  (package-install 'test-simple)
  (package-install 'tldr)
  (package-install 'toml-mode)
  (package-install 'transient)
  (package-install 'tree-mode)
  (package-install 'treepy)
  (package-install 'typescript-mode)
  (package-install 'ucs-utils)
  (package-install 'visual-regexp)
  (package-install 'volatile-highlights)
  (package-install 'web-mode)
  (package-install 'wgrep)
  (package-install 'wgrep-ag)
  (package-install 'which-key)
  (package-install 'with-editor)
  (package-install 'yaml-mode)
  (package-install 'yasnippet)
  (package-install 'yasnippet-snippets)
  (package-install 'zeal-at-point)
  (package-install 'zoutline))

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
