;;; edebug-inline-result.el --- show Edebug result inline.

;;; Time-stamp: <2019-02-25 15:33:16 stardiviner>

;;; Commentary:



;;; Code:

(defun edebug-inline-result-show ()
  "Show `edebug-previous-result' with specific popup backend."
  (interactive)
  (cond
   ((featurep 'posframe)
    (posframe-show
     " *edebug-previous-result*"
     :string (propertize edebug-previous-result) ; FIXME: did not auto wrap and fill.
     :position (point)
     :background-color (cl-case (alist-get 'background-mode (frame-parameters))
                         ('light
                          (color-darken-name (face-background 'default) 10))
                         ('dark
                          (color-lighten-name (face-background 'default) 15)))))
   ((featurep 'popup)
    (popup-tip edebug-previous-result
               :truncate t :height 20 :width 45 :nostrip t :margin 1 :nowait nil))
   ((featurep 'pos-tip)
    (pos-tip-show edebug-previous-result 'popup-face))))

;;;###autoload
(advice-add 'edebug-previous-result :override #'edebug-inline-result-show)



(provide 'edebug-inline-result)

;;; edebug-inline-result.el ends here
