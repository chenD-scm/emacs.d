(require 'eaf)

;; browser
(setq eaf-browser-continue-where-left-off t)
(eaf-setq eaf-browser-enable-adblocker "true")
(eaf-setq eaf-browser-remember-history "false")
(setq eaf-browser-default-search-engine "duckduckgo")
(eaf-setq eaf-browse-blank-page-url "https://duckduckgo.com")
(eaf-setq eaf-browser-default-zoom "1.20")

;; Proxy
(setq eaf-proxy-type "socks5")
(setq eaf-proxy-host "127.0.0.1")
(setq eaf-proxy-port "1080")

(provide 'init-eaf)
