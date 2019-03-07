;;; edebug-inline-result.el --- show Edebug result inline.

;;; Time-stamp: <2019-02-25 15:33:16 stardiviner>

;;; Commentary:



;;; Code:

(defun edebug-inline-result-show ()
  "Show `edebug-previous-result' with specific popup backend."
  (interactive)
  (cond
   ((featurep 'posframe)
    (posframe-show " *edebug-previous-result*"
                   :string (substring-no-properties edebug-previous-result)
                   :position (point)
                   :width (window-width)
                   :background-color "DarkCyan"
                   :foreground-color "white"
                   :width 50))
   ((featurep 'popup)
    (popup-tip edebug-previous-result
               :truncate t :height 20 :width 45 :nostrip t :margin 1 :nowait nil))
   ((featurep 'quick-peek)
    (quick-peek-show edebug-previous-result))
   ((featurep 'inline-docs)
    (inline-docs edebug-previous-result))
   ((featurep 'pos-tip)
    (pos-tip-show edebug-previous-result 'popup-face))))

(defun edebug-inline-result-delete-frame ()
  "Kill edebug result child-frame."
  (posframe-hide " *edebug-previous-result*"))

;;;###autoload
(advice-add 'edebug-previous-result :override #'edebug-inline-result-show)
;;;###autoload
(advice-add 'top-level :after #'edebug-inline-result-delete-frame)



(provide 'edebug-inline-result)

;;; edebug-inline-result.el ends here
