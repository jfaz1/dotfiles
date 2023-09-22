;; Custom GC
(load (expand-file-name "gcmh.el" user-emacs-directory))
(gcmh-mode 1)

;; Misc settings
(setq initial-scratch-message "")
(menu-bar-mode -1)
(tool-bar-mode -1)
(set-face-attribute 'default nil :font "Greybeard 13px-10")
(add-to-list 'default-frame-alist '(font . "Greybeard 13px-10"))
(add-to-list 'default-frame-alist '(fullscreen . fullboth))
(setq display-line-numbers-type t)
(global-display-line-numbers-mode 1)
(setq display-time-day-and-date t)
(display-time-mode 1)
(global-display-line-numbers-mode t)
(setq-default display-line-numbers-width 4)
(setq compilation-ask-about-save nil)
(electric-pair-mode)
(setq fringe-mode 'minimal)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default x-gtk-resize-child-frames 'resize-mode)
(setq undo-limit 8000000)
(setq undo-strong-limit 12000000)
(defalias 'yes-or-no-p 'y-or-n-p)

;; Binds
(global-set-key (kbd "C-c s") 'imenu)
(global-set-key (kbd "C-c e") 'flymake-show-project-diagnostics)
(global-set-key (kbd "C-c n") 'flymake-goto-next-error)
(global-set-key (kbd "C-c p") 'flymake-goto-prev-error)

;; Initial package setup
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;(straight-use-package
;; '(gruvbox-theme :type git :host github :repo "jfaz1/emacs-theme-gruvbox"))
(use-package gruvbox-theme)
(load-theme 'gruvbox-dark-hard t)

(use-package doom-modeline
  :ensure t
  :init 
  (doom-modeline-mode 1)
  :config 
  (setq doom-modeline-lsp t)
  (setq doom-modeline-height 28))

(windmove-default-keybindings)
  
(use-package hungry-delete
  :config
  (global-hungry-delete-mode))

(use-package avy
  :bind ("C-;" . avy-goto-char-2))

(use-package vertico
  :init
  (vertico-mode))

(use-package consult)

(use-package highlight-indent-guides
  :hook ((prog-mode yaml-mode) . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
         ("C-c C-e" . markdown-do)))

(use-package eglot
  :config
  (define-key eglot-mode-map (kbd "C-c a") 'eglot-code-actions)
  (define-key eglot-mode-map (kbd "C-c r") 'eglot-rename))
(add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1)))(  setq company-tooltip-minimum-width 90)

(use-package company
  :config
  (setq company-tooltip-maximum-width 90)
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.02))
(add-hook 'after-init-hook 'global-company-mode)
(use-package company-box
  :hook (company-mode . company-box-mode))
  
(use-package eldoc-box
  :config
  (add-hook 'eglot-managed-mode-hook #'eldoc-box-hover-mode t)
  (global-set-key (kbd "C-c c") 'eldoc-box-quit-frame))

(use-package rustic
  :init
  (setq compilation-scroll-output t)
  (setq rustic-compile-display-method 'switch-to-buffer)
  (setq rustic-format-on-save t)
  (setq rustic-lsp-client 'eglot))
  
(use-package wgsl-mode)

(use-package ron-mode)

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package tree-sitter
  :config
  (global-tree-sitter-mode))
(use-package tree-sitter-langs)

(use-package magit)
(use-package forge
  :after magit)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
  
(use-package marginalia
  :config
  (marginalia-mode))
  
(use-package crdt)

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package which-key
  :config
  (which-key-mode))

(use-package dashboard
  :config
  (setq dashboard-startup-banner 3)
  (setq dashboard-center-content t)
  (setq dashboard-projects-backend 'project-el)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-items '((projects . 5)
                        (recents  . 5)
                        (agenda . 5)))
  (dashboard-setup-startup-hook))

(setq dashboard-footer-messages '("The one true editor, Emacs!"
    "Vim?"
    "Welcome to the church of Emacs!"
    "While any text editor can save your files, only Emacs can save your soul."
    "The weak should fear the strong."
    "Segmentation fault (core dumped)"))

(setq dashboard-banner-logo-title (concat
                   		  "   ⡠⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀           \n"
                   		  "   ⢸⣀⠜⢄⡀⠀⠰⣶⣤⣀⠀⠀⣠⠔⠚⢛⣛⣦⡀⠀⠀⠀⠀⠀⠀⡐⠉⠉⢶⠄    \n"
                   		  "   ⠈⢅⠀⡈⠱⣄⠀⠈⠛⠻⢷⡎⡡⣶⣿⣿⣿⢿⣿⡀⠀⠀⠀⠀⣴⣯⣝⣲⠊⠀    \n"
                   		  "   ⠀⠀⠠⢅⢀⡎⣷⣄⠀⠀⠀⢿⡰⠊⠁⠀⠸⡼⡏⣇⠀⠀⢀⣾⣿⣿⣿⡏⠀⠀    \n"
                   		  "   ⠀⠀⠀⠈⢻⣾⣿⣿⣷⣤⣀⣼⣧⡀⠀⣠⠴⣗⣳⣼⣄⣴⣿⣿⣿⣿⠟⠀      \n"
                   		  "   ⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣶⠏⢹⠁⠀⡟⢹⢿⣿⣿⣿⡟⠀⠀      \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⠦⢅⣀⣨⣤⠴⡞⣿⣿⡟⠀⠀⠀⠀     \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠘⠻⣿⣿⣿⣿⣿⠈⠲⢦⡾⣛⣾⣁⣸⠋⠀⠀⠀⠀⠀⠀    \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡍⡿⠟⢻⡔⠚⠚⣷⣼⣾⠉⢹⠃⠀⣀⠀⠀⠀⠀    \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢱⣷⠀⠀⢧⠀⠸⠋⠸⠌⠃⢸⠀⢰⣿⠃⠀⠀⠀    \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣧⠀⣸⣤⣤⣶⣶⣶⣶⣾⣤⣿⠃⠀⠀⠀⠀    \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣦⠀⠀⠀     \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠃⢸⠀⠀⠀⠀⠀⠀⠉⣿⠿⠏⠀⠀⠀⠀    \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⢹⠀⢸⠀⠀⠀⠂⠁⠀⠀⢿⠀⠀⠀⠀⠀⠀    \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣇⢸⣤⣼⣀⣄⣀⡀⡀⢀⣀⡸⠄⠀⠀⠀⠀⠀    \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀      \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⠟⠉⠙⡿⠋⢹⠇⠀⠀⠀⠀⠀⠀⠀    \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣅⣀⣀⣤⡷⠶⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀   \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⢸⠃⣸⠃⠀⠀⠀⠀⠀⠀⠀⠀    \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⠀⠀⠀⣿⢠⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡄⠀⢰⣇⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡟⠛⠛⢯⡉⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀    \n"
                   		  "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⠤⠤⠬⠏⠉⠀⠀⠀⠀⠀⠀⠀      \n"
                   		  "   ⠀⠀⠀⠀                                       "))

(provide 'init)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(hungry-delete yasnippet vertico use-package tree-sitter-langs rustic magit lsp-mode kind-icon highlight-indent-guides dashboard corfu avy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eglot-inlay-hint-face ((t (:inherit shadow :height 1.0)))))
