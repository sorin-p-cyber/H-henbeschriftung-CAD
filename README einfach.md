# Höhenbeschriftung (HOEBESCH)

AutoLISP-Tool für **BricsCAD** und **AutoCAD**: beschriftet Punkte mit ihrer Z-Höhe.

*English version below.*

## Deutsch

### Funktionen
- Beschriftet `POINT`- und `INSERT`-Objekte mit ihrer Z-Koordinate
- MText mit Textfreistellung (Hintergrundmaske)
- Führungslinie vom Punkt zum Text
- Eigener Layer `Hoehentext`
- Texthöhe aus Plot-Texthöhe und Maßstab (z. B. 2,5 mm bei 1:500 ergibt 1,25 m)
- Dezimalkomma, einstellbare Nachkommastellen

### Installation
1. Datei `hoehenbeschriftung.lsp` herunterladen.
2. In der CAD-Software `APPLOAD` eingeben, die Datei auswählen und auf *Laden* klicken.
3. Für dauerhaftes Laden die Datei in die *Startgruppe* (AutoCAD) bzw. in die Autoload-Liste (BricsCAD) aufnehmen.

### Benutzung
Befehl `HOEBESCH` eingeben. Abgefragt werden Maßstab, Texthöhe im Plot [mm] und Nachkommastellen. Danach die Punkte auswählen.

### Hinweise
- Annahme: Zeichnungseinheit = Meter.
- Die Beschriftung ist ein normaler Text und wird **nicht automatisch aktualisiert**, wenn sich die Höhe eines Punktes ändert. Dann Beschriftung löschen (Layer `Hoehentext`) und neu beschriften.
- Nicht für AutoCAD LT geeignet (kein LISP).
- Meldungen im Tool sind auf Deutsch.

### Unterstützen
Wenn dir das Tool Zeit spart, freue ich mich über eine kleine Spende: [DEIN-LINK-HIER]

---

## English

AutoLISP tool for **BricsCAD** and **AutoCAD** that labels point elevations (Z). Command prompts and messages are in German.

### Features
- Labels `POINT` and `INSERT` objects with their Z coordinate
- MText with background mask, leader line from point to text
- Dedicated layer `Hoehentext`
- Text height from plot height and scale (e.g. 2.5 mm at 1:500 gives 1.25 m)
- Decimal comma, configurable decimal places

### Installation
1. Download `hoehenbeschriftung.lsp`.
2. Run `APPLOAD`, select the file and click *Load*.
3. For permanent loading, add it to the startup suite (AutoCAD) or autoload list (BricsCAD).

### Usage
Run `HOEBESCH`. It asks for scale, plot text height [mm] and decimals, then you select the points.

### Notes
- Assumes drawing units are meters.
- Labels are plain text and are **not updated automatically** when a point's elevation changes. Delete the labels (layer `Hoehentext`) and run the command again.
- Not for AutoCAD LT (no LISP support).

### Support
If this tool saves you time, consider a small donation: [YOUR-LINK-HERE]

## Lizenz / License
MIT
