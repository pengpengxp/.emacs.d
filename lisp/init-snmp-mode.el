(require 'snmp-mode)

(add-hook 'snmp-common-mode-hook #'(lambda ()
                                     (interactive)
                                     (peng-local-set-key (kbd "<C-return>") 'tempo-template-snmpv2-object-type)
                                     (peng-local-set-key (kbd "<M-return>") 'tempo-template-snmpv2-table-type)
                                     (peng-local-set-key (kbd "<C-M-return>") 'tempo-template-snmpv2-textual-convention)

                                     (peng-local-set-key (kbd "<C-down>") 'tempo-forward-mark)
                                     (peng-local-set-key (kbd "<C-right>") 'tempo-forward-mark)
                                     (peng-local-set-key (kbd "<C-up>") 'tempo-backward-mark)
                                     (peng-local-set-key (kbd "<C-left>") 'tempo-backward-mark)

                                     ))
(add-to-list 'auto-mode-alist '("\\.mib\\'" . snmpv2-mode))

(provide 'init-snmp-mode)
