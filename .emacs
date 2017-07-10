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
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;; Basic Setup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; set default directory
(setq default-directory "C:/Users/wmm0017/")

(setq inhibit-startup-message t)
(tool-bar-mode -1)

;; Open in full screen mode
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; ido and smex
(ido-mode t)
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;; word wrap
(global-visual-line-mode t)
;; column and line numbers
(setq column-number-mode t)
;; Kill all Dired buffers
(defun kill-dired-buffers ()
	 (interactive)
	 (mapc (lambda (buffer) 
           (when (eq 'dired-mode (buffer-local-value 'major-mode buffer)) 
             (kill-buffer buffer))) 
         (buffer-list)))

;; window-numbering
(window-numbering-mode t)

;;; Smex
(autoload 'smex "smex"
  "Smex is a M-x enhancement for Emacs, 
   it provides a convenient interface to
your recently and most frequently used commands.")

(global-set-key (kbd "M-x") 'smex)
;; auto-hyphen
(defadvice smex (around space-inserts-hyphen activate compile)
        (let ((ido-cannot-complete-command 
               `(lambda ()
                  (interactive)
                  (if (string= " " (this-command-keys))
                      (insert ?-)
                    (funcall ,ido-cannot-complete-command)))))
          ad-do-it))

;; word wrap
(global-visual-line-mode t)
;; column and line numbers
(setq column-number-mode t)
;; Kill all Dired buffers
(defun kill-dired-buffers ()
	 (interactive)
	 (mapc (lambda (buffer) 
           (when (eq 'dired-mode (buffer-local-value 'major-mode buffer)) 
             (kill-buffer buffer))) 
	       (buffer-list)))

;; Line Numbers
;; Preset width nlinum
(global-nlinum-mode)
;(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'nlinum-mode-hook
          (lambda ()
            (unless (boundp 'nlinum--width)
              (setq nlinum--width
                (length (number-to-string
                         (count-lines (point-min) (point-max))))))))

;;;;;;;;;;;;;;;;;;;;;;;;; Package Systems ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")
	     '("marmalade" . "http://marmalade-repo.org/packages/")
)

(add-to-list 'package-archives
             '("elpy" . "https://jorgenschaefer.github.io/packages/"))

;;;;;;;;;;;;;;;;;;;;;;;;; Statistics ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; find markdown

;; ess setup
(require 'ess-site)

;; R modes
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd\\'" . markdown-mode))

(require 'poly-R)
(require 'poly-markdown)
(require 'ess-view)

;; Stata
;(setenv "PATH" (concat (getenv "PATH") ":/Program Files (x86)/Stata14"))
;(setq exec-path (append exec-path '(":/Program Files (x86)/stata14")))
;(setq inferior-STA-progam-name "StataMP-64.exe")

;; ado-mode
(add-to-list 'load-path "~/.emacs.d/ado-mode/lisp")
(require 'ado-mode)
;; SPSS
(add-to-list 'load-path (expand-file-name "~/.emacs.d/spss"))
(require 'spss)

;;;;;;;;;;;;;;;;;;;;;;;;;;; LaTeX ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq exec-path (append exec-path '("C:/Program Files/MiKTeX 2.9/tex")))

;; set up MikTex integration
(load "auctex.el" nil t t)
(require 'tex-mik)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(setq TeX-PDF-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;; Org Mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Org mode setup
;(setq org-default-notes-file (concat org-directory "~/org/notes.org"))
(setq org-default-notes-file (expand-file-name "~/org/notes.org"))
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cl" 'org-store-link)

;;;;;;;;;;;;;;;;;;;;;;;;;; Python ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; set ipython as default python interpreter
(setq python-shell-interpreter "ipython")

;; Elpy
;(elpy-enable)
;(elpy-use-ipython)
(setq elpy-rpc-backend "jedi")
;(setq jedi:complete-on-dot t)

;; company-jedi
;(add-to-list 'company-backends 'company-jedi)

;; use python 3 conda env
;(pyvenv-activate (expand-file-name "~/anaconda/envs/python3"))

;; use conda environments
;(setenv "WORKON_HOME" "/Users/wmm0017/AppData/Local/Continuum/Anaconda2/envs")
;(pyvenv-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Projectile ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'projectile)
(projectile-global-mode)


;; Aspell and ispell
(add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")

(setq ispell-program-name "aspell")
(setq ispell-personal-dictionary "C:/Program Files (x86/Aspell/dict/")

(require 'ispell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Scrum ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/scrum/")
(load "scrum")
;(add-to-list 'load-path "~/.emacs.d/melpa/gnuplot/")

;; specify the gnuplot executable (if other than /usr/bin/gnuplot)
(setq gnuplot-program "C:\\Program Files/gnuplot/bin/gnuplot")

;; automatically open files ending with .gp or .gnuplot in gnuplot mode
;(setq auto-mode-alist 
;(append '(("\\.\\(gp\\|gnuplot\\)$" . gnuplot-mode)) auto-mode-alist))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; tags ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-tag-alist '(("@teaching" . ?t) ("@research" . ?r)
		      ("@outreach" . ?o) ("@service" . ?s)))
