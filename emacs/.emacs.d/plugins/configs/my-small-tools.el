;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-01-22 18:19:10 Tuesday by Hua Liang>

;; ====================      line number      ====================
;; 调用linum.el(line number)来显示行号：
(require 'linum)
(global-linum-mode t)
;;(require 'hlinum)

(line-number-mode -1)
;; --------------------      End         --------------------


;; ==================== fast-jump-back ====================
;(require 'fast-jump-back)
;; -------------------- fast-jump-back --------------------


;; ==================== ahei's recent-jump ====================
(setq rj-ring-length 10000)
(require 'recent-jump)
(global-set-key (kbd "C-o") 'recent-jump-backward)
(global-set-key (kbd "M-o") 'recent-jump-forward)
;; -------------------- ahei's recent-jump --------------------


;; ==================== moinmoin-mode ====================
(require 'screen-lines)
(require 'moinmoin-mode)
;; -------------------- moinmoin-mode --------------------


;; ==================== nginx-mode ====================
(require 'nginx-mode)
(add-hook 'find-file-hook '(lambda ()
                             (when (string-match
                                    "^\\(/etc/nginx\\|/home/cedricporter/my\\).*?\\.\\(com\\|org\\|net\\|conf\\)$"
                                    (buffer-file-name))
                               (nginx-mode)
                               )))
;; -------------------- nginx-mode --------------------


;(require 'ibus)
;(add-hook 'after-init-hook 'ibus-mode-on)


;; ==================== browse-kill-ring ====================
;; 方便的在 kill-ring 里寻找需要的东西。
(require 'browse-kill-ring)
(require 'second-sel)
(require 'browse-kill-ring+)
(browse-kill-ring-default-keybindings)
(global-set-key "\C-c\C-k" 'browse-kill-ring)
;; -------------------- browse-kill-ring --------------------


;; ==================== ido ====================
;; take the place of C-x C-f
;; 当你输入了一些字符后，系统会自动帮你补全；
;; C-s(next)或是C-r(previous)用来在列表中循环；
;; 按[Tab]键会自动列出可能的补全方法；
;; 用C-x C-d直接打开当前目录的Dired浏览模式；
(require 'ido)
(ido-mode t)
;(ffap-bindings)
;(global-set-key "\C-x\C-f" 'ido-dired)
(global-set-key "\C-c\C-f" 'find-file-at-point)
;; -------------------- ido --------------------


;; ==================== session ====================
;; session
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(load "desktop")
(desktop-save-mode)
;; -------------------- session --------------------


;; ==================== saveplace ====================
;; back to last position when we close the file
(require 'saveplace)
(setq-default save-place t)
;; -------------------- saveplace --------------------


;; ==================== tabbar ====================
;;tabbar
(require 'tabbar)
(tabbar-mode 1)
(global-set-key [(meta j)] 'tabbar-backward)
(global-set-key [(meta k)] 'tabbar-forward)
(global-set-key [(control meta j)] 'tabbar-backward-group)
(global-set-key [(control meta k)] 'tabbar-forward-group)
;;set group strategy
(defun tabbar-buffer-groups ()
  "tabbar group"
  (list
   (cond
    ((memq major-mode '(shell-mode sh-mode))
     "shell"
     )
    ((memq major-mode '(c-mode c++-mode))
     "cc"
     )
    ((memq major-mode '(dired-mode ibuffer-mode))
     "files"
     )
    ((eq major-mode 'python-mode)
     "python"
     )
    ((eq major-mode 'ruby-mode)
     "ruby"
     )
    ((memq major-mode
	   '(php-mode nxml-mode nxhtml-mode))
     "WebDev"
     )
    ((eq major-mode 'emacs-lisp-mode)
     "Emacs-lisp"
     )
    ((memq major-mode
	   '(tex-mode latex-mode text-mode snippet-mode org-mode moinmoin-mode markdown-mode))
     "Text"
     )
    ((string-equal "*" (substring (buffer-name) 0 1))
     "emacs"
     )
    (t
     "other"
     )
    )))
(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

;;;; 设置tabbar外观
;; 设置默认主题: 字体, 背景和前景颜色，大小
(set-face-attribute 'tabbar-default nil
                    :family "Comic Sans MS" ;"Vera Sans YuanTi Mono"
                    :background "gray30"
                    :foreground "#dcdccc"
                    :height 1.0
                    )
;; 设置左边按钮外观：外框框边大小和颜色
(set-face-attribute 'tabbar-button nil
                    :inherit 'tabbar-default
                    :box '(:line-width 2 :color "gray30")
                    )
(set-face-attribute 'tabbar-separator nil
                    :inherit 'tabbar-default
                    :foreground "blue"
                    :background "dark gray"
                    :box '(:line-width 2 :color "dark gray" :style 'released-button)
                    )
;(setq tabbar-separator-value "§")
(setq tabbar-separator (list 0.5))
;; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :foreground "orange" ;"DarkGreen"
                    :background "dark magenta" ;"LightGoldenrod"
                    :box '(:line-width 2
                                       :color "DarkGoldenrod"
                                       :style 'pressed-button)
                    :weight 'bold
                    )
;; 设置非当前tab外观：外框大小和颜色
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :box '(:line-width 2 :color "dark gray" :style 'released-button))

;; cancel grouping
;;(setq tabbar-buffer-groups-function
;;    (lambda (b) (list “All Buffers”)))
;;(setq tabbar-buffer-list-function
;;    (lambda ()
;;        (remove-if
;;          (lambda(buffer)
;;             (find (aref (buffer-name buffer) 0) ” *”))
;;          (buffer-list))))
;; -------------------- tabbar --------------------



;; ==================== ace-jump ====================
;; "C-c SPC" ==> ace-jump-word-mode : enter first character of a word, select the highlighted key to move to it.
;; "C-u C-c SPC" ==> ace-jump-char-mode : enter a character for query, select the highlighted key to move to it.
;; "C-u C-u C-c SPC" ==> ace-jump-line-mode : each non-empty line will be marked, select the highlighted key to move to it.
(add-to-list 'load-path "~/.emacs.d/plugins/ace-jump-mode")

(setq ace-jump-mode-case-fold t)

(autoload 'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(setq ace-jump-mode-scope 'window)      ; limit scope to current buffer(window)
(setq ace-jump-mode-submode-list
      '(ace-jump-word-mode              ; C-c SPC
        ace-jump-line-mode              ; C-u C-c SPC
        ace-jump-char-mode))            ; C-u C-u C-c SPC
;; you can select the key you prefer to
(global-set-key (kbd "M-l") 'ace-jump-mode)
;; -------------------- ace-jump --------------------



;;==================== undo tree ====================
(require 'undo-tree)
;;-------------------- undo tree --------------------




;; ==================== htmlize ====================
;; 1) M-x htmlize-buffer
;; 把当前的buffer转为一个html文件，并保留当前你Emacs的色彩定义。运行这个命令后，Emacs会跳转到一个新的buffer里，你把这个buffer保存下来即可。
;;
;; 2) M-x htmlize-file
;; 这个命令会在mini-buffer里提示输入你需要转换的文件，自动帮你转换好，并保存为.html。
;;
;; 3) M-x htmlize-many-files
;; 这个命令和2)差不多的功能，不过可以让你同时转一批文件。
;;
;; 4) M-x htmlize-many-files-dired
;; 这个命令可以把你标记好的目录下的所以文件都转成html。
(require 'htmlize)
;; -------------------- htmlize -----------------------------


;; ;; ==================== git emacs ====================
;; (add-to-list 'load-path "~/.emacs.d/plugins/git-emacs/")
;; (require 'git-emacs)
;; ;; -------------------- git emacs --------------------


;; ==================== magit ====================
(add-to-list 'load-path "~/.emacs.d/plugins/magit-1.2.0")
(require 'magit)
(require 'magit-svn)
(global-set-key (kbd "C-x g s") 'magit-status)
;; -------------------- magit --------------------


;; ;;==================== w3m ====================
;; (add-to-list 'load-path "~/.emacs.d/plugins/emacs-w3m-1.4.4")
;; ;(require 'w3m-load)
;; (require 'w3m-e21)
;; (provide 'w3m-e23)
;; ;;-------------------- w3m --------------------


;; ;; ==================== o-blog ====================
;; (add-to-list 'load-path "~/.emacs.d/plugins/o-blog")
;; (require 'o-blog)
;; ;; -------------------- o-blog --------------------


;; ==================== org2blog ====================
(add-to-list 'load-path "~/.emacs.d/plugins/org2blog")
(require 'org2blog-autoloads)

(setq org2blog/wp-blog-alist
      '(("EverET.org"
         :url "http://EverET.org/xmlrpc.php"
         :username "cedricporter"
         :default-title "无题")))

;; -------------------- org2blog --------------------


;; ==================== find-func in emacs lisp ====================
(require 'find-func)
(define-key emacs-lisp-mode-map (kbd "C-.") 'find-function)
(define-key emacs-lisp-mode-map (kbd "<f12>") 'find-function)
(define-key emacs-lisp-mode-map (kbd "C-c v") 'find-variable)
;; -------------------- find-func in emacs lisp --------------------


;; ==================== moinmoin2markdown ====================
(setq moinmoin2markdown-reg-pat
      '(; header
        ("^= \\(.*?\\) =" . "# \\1")
        ("^== \\(.*?\\) ==" . "## \\1")
        ("^=== \\(.*?\\) ===" . "### \\1")
        ("^==== \\(.*?\\) ====" . "#### \\1")
        ("^===== \\(.*?\\) =====" . "##### \\1")
                                        ; code block
        ("^{{{ *?\n\\([[:ascii:][:nonascii:]]*?\\)}}}"
         . "```\n\\1\n```")
        ("^{{{#!highlight \\(.*?\\)\n\\([[:ascii:][:nonascii:]]*?\\)}}}"
         . "``` \\1\n\\2\n```")
                                        ; link
        ("\\[\\[\\(.*?\\)|\\(.*?\\)\\]\\]" . "[\\2](\\1)")
        ("\\[\\[\\(.*?\\)\\]\\]" . "[](\\1)")
        ("{{\\(.*?\\)}}" . "![](\\1)")
        ("\\([^(\\[]\\)http://\\(.*?\\)\\([^[:digit:][:word:]-./%&?@]\\)" . "\\1<http://\\2>\\3")
                                        ; emphasis
        ("'''\\(.*?\\)'''" . "**\\1**")
        ))

(defun moinmoin2markdown ()
  "Convert moinmoin syntax to markdown syntax"
  (interactive)
  (let ((origin-pos (point)))
    (dolist (pattern moinmoin2markdown-reg-pat)
      (replace-regexp (car pattern) (cdr pattern))
      (goto-char 0))
    (goto-char origin-pos))
  (markdown-mode)
  )
;; -------------------- moinmoin2markdown --------------------


;; ==================== toggle-case ====================
(require 'toggle-case)
(global-set-key (kbd "M-u") 'toggle-case)
;; -------------------- toggle-case --------------------



;; ==================== helm ====================
(add-to-list 'load-path "~/.emacs.d/plugins/helm")
(require 'helm-config)
;(helm-mode 1)
(global-set-key (kbd "C-x b") 'helm-mini)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;; -------------------- helm --------------------


;; ==================== graphviz ====================
(load-file "~/.emacs.d/plugins/graphviz-dot-mode.el")
;; -------------------- graphviz --------------------


;; ==================== evil-number ====================
(add-to-list 'load-path "~/.emacs.d/plugins/evil-numbers")
(require 'evil-numbers)

(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
;; -------------------- evil-number --------------------


;; ==================== ws ====================
;; (require 'ws)
;; -------------------- ws --------------------


;; ;; ==================== ack-and-a-half ====================
;; (add-to-list 'load-path "~/.emacs.d/plugins/ack-and-a-half")
;; (require 'ack-and-a-half)
;; ;; Create shorter aliases
;; (defalias 'ack 'ack-and-a-half)
;; (defalias 'ack-same 'ack-and-a-half-same)
;; (defalias 'ack-find-file 'ack-and-a-half-find-file)
;; (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)
;; ;; -------------------- ack-and-a-half --------------------


;; ==================== full-ack ====================
;(add-to-list 'load-path "~/.emacs.d/plugins/full-ack")
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)
;; -------------------- full-ack --------------------


(provide 'my-small-tools)
