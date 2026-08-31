;; -*- lexical-binding: t; -*-

;; QML
(add-to-list 'treesit-language-source-alist
  '(qmljs "https://github.com/yuja/tree-sitter-qmljs"))
(comment
  (package-vc-install "https://github.com/xhcoding/qml-ts-mode")
  (treesit-ensure-installed 'qmljs))

(with-load 'eglot
  (add-to-list 'eglot-server-programs
    '(qml-ts-mode . ("/usr/lib/qt6/bin/qmlls"))))

(with-package 'qml-ts-mode
  (add-hook 'qml-ts-mode-hook #'eglot-ensure))
