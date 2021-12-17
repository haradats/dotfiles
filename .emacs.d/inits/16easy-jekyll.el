;;; 16easy-jekyll.el --- 16easy-jekyll.el
;;; Commentary:
;;; Code:
;;(setq debug-on-error t)

(setq easy-jekyll-basedir "~/src/github.com/masasam/PPAP2/")
(setq easy-jekyll-url "https://easy-jekyll.firebaseapp.com")
(setq easy-jekyll-previewtime "300")
(setq easy-jekyll-default-picture-directory "~/Pictures")
;;(define-key global-map (kbd "C-c C-j") 'easy-jekyll)
(setq easy-jekyll-bloglist '(((easy-jekyll-basedir . "~/src/github.com/masasam/jekyll1/")
			      (easy-jekyll-url . "http://example1.com")
			      (easy-jekyll-sshdomain . "blogdomain")
			      (easy-jekyll-root . "/home/jekyll2")
			      (easy-jekyll-google-cloud-storage-bucket-name . "masa-storage")
			      (easy-jekyll-additional-postdir . "_pages"))
			     ((easy-jekyll-basedir . "~/src/github.com/masasam/jekyll2/")
			      (easy-jekyll-additional-postdir . "_pages")
			      (easy-jekyll-url . "http://example2.net"))))

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; 16easy-jekyll.el ends here
