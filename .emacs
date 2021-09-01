en
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(display-battery-mode t)
 '(display-line-numbers t)
 '(display-line-numbers-current-absolute t)
 '(display-line-numbers-type t)
 '(display-time-mode t)
 '(enable-local-eval t)
 '(indent-tabs-mode nil)
 '(indicate-buffer-boundaries (quote left))
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(initial-frame-alist
   (quote
    ((menu-bar-lines . 1)
     (tool-bar-lines . 0)
     (width . 106)
     (hight . 60))))
 '(line-number-display-limit nil)
 '(line-number-mode t)
 '(package-selected-packages (quote (magit)))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tab-always-indent nil)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(verilog-auto-indent-on-newline nil)
 '(verilog-auto-newline nil)
 '(verilog-case-indent 4)
 '(verilog-cexp-indent 4)
 '(verilog-highlight-grouping-keywords t)
 '(verilog-indent-level 4)
 '(verilog-indent-level-behavioral 4)
 '(verilog-indent-level-declaration 4)
 '(verilog-indent-level-module 4)
 '(verilog-minimum-comment-distance 5)
 '(verilog-tab-always-indent nil))
;; '(tool-bar-mode))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#292929" :foreground "#d3d3d3" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 87 :width normal :foundry "bitstream" :family "Courier 10 Pitch"))))
 '(line-number-current-line ((t (:inherit line-number :inverse-video t))))
 '(my-long-line-face ((((class color)) (:background "gray10"))) t)
 '(my-tab-face ((((class color)) (:background "grey10"))) t)
 '(my-trailing-space-face ((((class color)) (:background "gray10"))) t))
 (setq auto-mode-alist (cons  '("\\.v\\'" . verilog-mode) auto-mode-alist))
 (setq auto-mode-alist (cons  '("\\.vo\\'" . verilog-mode) auto-mode-alist))
 ;;highlight brackets
 (require 'paren)
 (show-paren-mode 1)

(setq mode-line-inverse-video t)
(setq inverse-video nil)
(setq-default require-final-newline t) ; Ask user; t will add it silently
;;(setq auto-save-interval 5000)  ; How many keystrokes between auto-saves
(setq gc-cons-threshold 250000) ; Time between garbage-collects -- default=100000
(setq search-slow-speed 2400)
(setq search-slow-window-lines 4)
(setq next-screen-context-lines 4)
(setq scroll-step 4)
(setq-default fill-column 180)
(setq sentence-end "[.;?!][]\")]*[ \t\n]+")
(setq dired-listing-switches "-la") ; Switches to 'ls' must have -l, and must NOT have -F
(setq display-time-day-and-date t)
(display-time)

(setq verilog-linter "qncsim -r+ RAM/2000 -i irun -sv ")

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


 (defvar untabify-this-buffer)
 (defun untabify-all ()
   "Untabify the current buffer, unless `untabify-this-buffer' is nil."
   (and untabify-this-buffer (untabify (point-min) (point-max))))
 (define-minor-mode untabify-mode
   "Untabify buffer on save." nil " untab" nil
   (make-variable-buffer-local 'untabify-this-buffer)
   (setq untabify-this-buffer (not (derived-mode-p 'makefile-mode)))
   (add-hook 'before-save-hook #'untabify-all))
 (add-hook 'prog-mode-hook 'untabify-mode)

 (setq untabify-mode t)


;; set f keys
;;

(global-set-key [f1]     'find-file-at-point)
;;(global-set-key [f2]   'query-replace)
(global-set-key [f2]     'untabify-mode)
(global-set-key [M-f2]   'follow-mode)
(global-set-key [f3]     'compile)
(global-set-key [M-f3]   '"qncsim -r+ RAM/2000 -i irun -sv -incdir ./../include -f ./../include/he_top_files.v")
(global-set-key [f4]     'split-window-horizontally)
(global-set-key [f5]     'revert-buffer )
(global-set-key [M-f5]   'auto-revert-mode )
(global-set-key [M-S-f5] 'global-auto-revert-mode )
(global-set-key [f6]     'other-window)
(global-set-key [f7]     'delete-other-windows)
(global-set-key [f8]     'split-window-vertically)
(global-set-key [f9]     'buffer-menu)
(global-set-key [C-f9]   'bs-show)
(global-set-key [f10]    'orgtbl-mode)
(global-set-key [f11]    'shell)
(global-set-key [f12]    'toggle-truncate-lines)

;;(global-set-key [M-s h .]  'highlight-symbol-at-point)



 (require 'whitespace)
 (setq whitespace-style '(face empty tabs lines-tail trailing))
 (global-whitespace-mode t)

;;;  (require 'auto-complete-verilog)

   (add-hook 'font-lock-mode-hook
            (function
             (lambda ()
               (setq font-lock-keywords
                     (append font-lock-keywords
                             '(("\t+" (0 'my-tab-face t))
                               ("^.\\{100,\\}$" (0 'my-long-line-face t))
                               ("[ \t]+$"      (0 'my-trailing-space-face t))))))))


   (add-hook 'before-save-hook 'delete-trailing-whitespace)

(autoload 'artist-mode "artist" "Enter artist-mode" t)


(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
