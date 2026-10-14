;;; ------------------------------------------------------------------
;;; HOEBESCH - Hoehenbeschriftung fuer Punkte (BricsCAD / AutoCAD)
;;; Beschriftet POINT- und INSERT-Objekte mit ihrer Z-Koordinate:
;;;   - MText mit Textfreistellung (Hintergrundmaske)
;;;   - Fuehrungslinie vom Punkt zum Text
;;;   - eigener Layer "Hoehentext"
;;; Annahme: Zeichnungseinheit = Meter.
;;; Texthoehe = Plot-Texthoehe [mm] / 1000 * Massstab (Vorgabe 2.5 mm,
;;; Massstab-Vorgabe aus DIMSCALE). Beispiel 1:500 -> 1.25 m Texthoehe.
;;; Laden: APPLOAD oder (load "hoehenbeschriftung.lsp"), Befehl: HOEBESCH
;;; ------------------------------------------------------------------

(defun hb-layer (name)
  (if (not (tblsearch "LAYER" name))
    (entmake
      (list '(0 . "LAYER")
            '(100 . "AcDbSymbolTableRecord")
            '(100 . "AcDbLayerTableRecord")
            (cons 2 name)
            '(70 . 0)
            '(62 . 7)))))

(defun c:HOEBESCH ( / ss i en ed p1 p2 p3 z h txt lay sty cnt in)
  ;; Voreinstellungen merken
  ;; Massstab-Vorgabe: DIMSCALE der Zeichnung (falls > 1), sonst 1000
  (if (not *hb-mst*)
    (setq *hb-mst* (if (> (getvar "DIMSCALE") 1.0)
                     (fix (+ 0.5 (getvar "DIMSCALE")))
                     1000)))
  (if (not *hb-dec*) (setq *hb-dec* 2))
  (if (not *hb-hmm*) (setq *hb-hmm* 2.5))

  (initget 6)
  (setq in (getint (strcat "\nMassstab 1:<" (itoa *hb-mst*) ">: ")))
  (if in (setq *hb-mst* in))

  (initget 6)
  (setq in (getreal (strcat "\nTexthoehe im Plot [mm] <" (rtos *hb-hmm* 2 1) ">: ")))
  (if in (setq *hb-hmm* in))

  (initget 4)
  (setq in (getint (strcat "\nNachkommastellen <" (itoa *hb-dec*) ">: ")))
  (if in (setq *hb-dec* in))

  (prompt "\nPunkte waehlen: ")
  (setq ss (ssget '((0 . "POINT,INSERT"))))

  (if ss
    (progn
      (setq lay "Hoehentext"
            sty (getvar "TEXTSTYLE")
            h   (* (/ *hb-hmm* 1000.0) *hb-mst*)   ; Plot-mm * Massstab, in Metern
            cnt 0
            i   0)
      (hb-layer lay)

      (while (< i (sslength ss))
        (setq en (ssname ss i)
              ed (entget en)
              p1 (cdr (assoc 10 ed))
              z  (caddr p1))

        ;; Hoehe als Text, Dezimalkomma
        (setq txt (vl-string-subst "," "." (rtos z 2 *hb-dec*)))

        ;; Fuehrungslinie: Punkt -> Knickpunkt oben rechts
        (setq p2 (list (+ (car p1) (* 2.0 h))
                       (+ (cadr p1) (* 1.5 h))
                       0.0)
              p3 (list (+ (car p2) (* 0.2 h))
                       (cadr p2)
                       0.0))

        (entmake
          (list '(0 . "LINE")
                (cons 8 lay)
                (list 10 (car p1) (cadr p1) 0.0)
                (cons 11 p2)))

        ;; MText mit Hintergrundmaske (Textfreistellung)
        (entmake
          (list '(0 . "MTEXT")
                '(100 . "AcDbEntity")
                (cons 8 lay)
                '(100 . "AcDbMText")
                (cons 10 p3)
                (cons 40 h)
                (cons 41 0.0)
                '(71 . 4)          ; Anker: mitte links
                '(72 . 1)
                (cons 1 txt)
                (cons 7 sty)
                '(90 . 2)          ; Hintergrund = Zeichnungsfarbe
                '(45 . 1.2)))      ; Maskenrand-Faktor

        (setq cnt (1+ cnt)
              i   (1+ i)))

      (prompt (strcat "\n" (itoa cnt) " Hoehe(n) beschriftet.")))
    (prompt "\nKeine Punkte gewaehlt."))
  (princ))

(prompt "\nHOEBESCH geladen.")
(princ)
