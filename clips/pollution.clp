;  Συστήματα Γνώσης - Εργασία 2
;  Αριστοτέλης Κασσελούρης, Μανώλης Αστραντίνης


; ---- Στατική γνώση (μετατροπή από Protégé) ----

(defclass Chemical
	(is-a USER)
	(role abstract)
	(slot formula
		(type STRING)
		(create-accessor read-write))
	(slot colour
		(type SYMBOL)
		(allowed-values red white none)
		(create-accessor read-write))
	(slot englishName
		(type STRING)
		(create-accessor read-write))
	(slot categoryPH
		(type SYMBOL)
		(allowed-values acid base oil)
		(create-accessor read-write))
	(slot strength
		(type SYMBOL)
		(allowed-values strong weak none)
		(create-accessor read-write))
	(multislot spectroscopy
		(type SYMBOL)
		(allowed-values none carbon sulphur sodium metal)
		(create-accessor read-write))
	(slot greekName
		(type STRING)
		(create-accessor read-write))
	(slot radioactive
		(type SYMBOL)
		(allowed-values FALSE TRUE)
		(create-accessor read-write))
	(slot specificGravityHint
		(type SYMBOL)
		(allowed-values lighter_than_water heavier_than_water equal_to_water)
		(create-accessor read-write))
	(slot smell
		(type SYMBOL)
		(allowed-values choking vinegar none)
		(create-accessor read-write))
	(slot solubility
		(type SYMBOL)
		(allowed-values soluble insoluble)
		(create-accessor read-write))
	(multislot hazards
		(type SYMBOL)
		(allowed-values burns_skin asphyxiation corrosive explosive highly_toxic_PCBs)
		(create-accessor read-write)))

(defclass Acid
	(is-a Chemical)
	(role abstract))

(defclass StrongAcid
	(is-a Acid)
	(role concrete))

(defclass WeakAcid
	(is-a Acid)
	(role concrete))

(defclass Base
	(is-a Chemical)
	(role abstract))

(defclass StrongBase
	(is-a Base)
	(role concrete))

(defclass WeakBase
	(is-a Base)
	(role concrete))

(defclass Oil
	(is-a Chemical)
	(role concrete))

(defclass Store
	(is-a USER)
	(role concrete)
	(slot connectedManhole
		(type INSTANCE-NAME)
(allowed-classes Manhole)
		(create-accessor read-write))
	(multislot containsChemical
		(type INSTANCE-NAME)
(allowed-classes Chemical)
		(create-accessor read-write)))

(defclass SewerNode
	(is-a USER)
	(role abstract))

(defclass Manhole
	(is-a SewerNode)
	(role concrete)
	(slot downstream
		(type INSTANCE-NAME)
(allowed-classes SewerNode)
		(create-accessor read-write)))

(defclass MonitoringStation
	(is-a SewerNode)
	(role concrete)
	(slot stationName
		(type STRING)
		(create-accessor read-write)))

(definstances instances



([acetic_acid] of  WeakAcid

	(categoryPH acid)
	(colour none)
	(englishName "Acetic acid")
	(formula "CH3COOH")
	(greekName "Οξικό οξύ")
	(smell vinegar)
	(solubility soluble)
	(specificGravityHint equal_to_water)
	(spectroscopy none)
	(strength weak))

([aluminium_hydroxide] of  WeakBase

	(categoryPH base)
	(colour white)
	(englishName "Aluminium hydroxide")
	(formula "Al(OH)3")
	(greekName "Υδροξείδιο του Αργιλίου")
	(smell none)
	(solubility soluble)
	(specificGravityHint heavier_than_water)
	(spectroscopy metal)
	(strength weak))

([carbonic_acid] of  WeakAcid

	(categoryPH acid)
	(colour none)
	(englishName "Carbonic acid")
	(formula "H2CO3")
	(greekName "Ανθρακικό οξύ")
	(smell none)
	(solubility soluble)
	(specificGravityHint equal_to_water)
	(spectroscopy carbon)
	(strength weak))

([chromogen_23] of  WeakBase

	(categoryPH base)
	(colour red)
	(englishName "Chromogen 23")
	(formula "??")
	(greekName "Χρωμογόνο 23")
	(smell none)
	(solubility soluble)
	(specificGravityHint lighter_than_water)
	(spectroscopy none)
	(strength weak))

([hydrochloric_acid] of  StrongAcid

	(categoryPH acid)
	(colour none)
	(englishName "Hydrochloric acid")
	(formula "HCl")
	(greekName "Υδροχλωρικό οξύ")
	(hazards burns_skin asphyxiation)
	(smell choking)
	(solubility soluble)
	(specificGravityHint equal_to_water)
	(spectroscopy none)
	(strength strong))

([manhole_1] of  Manhole

	(downstream [manhole_9]))

([manhole_10] of  Manhole

	(downstream [manhole_12]))

([manhole_11] of  Manhole

	(downstream [manhole_13]))

([manhole_12] of  Manhole

	(downstream [monitoring_station]))

([manhole_13] of  Manhole

	(downstream [monitoring_station]))

([manhole_2] of  Manhole

	(downstream [manhole_9]))

([manhole_3] of  Manhole

	(downstream [manhole_9]))

([manhole_4] of  Manhole

	(downstream [manhole_10]))

([manhole_5] of  Manhole

	(downstream [manhole_10]))

([manhole_6] of  Manhole

	(downstream [manhole_11]))

([manhole_7] of  Manhole

	(downstream [manhole_11]))

([manhole_8] of  Manhole

	(downstream [manhole_13]))

([manhole_9] of  Manhole

	(downstream [manhole_12]))

([monitoring_station] of  MonitoringStation
)

([petrol] of  Oil

	(categoryPH oil)
	(colour none)
	(englishName "Petrol")
	(formula "??")
	(greekName "Βενζίνη")
	(hazards explosive)
	(smell none)
	(solubility insoluble)
	(specificGravityHint lighter_than_water)
	(spectroscopy carbon)
	(strength none))

([rubidium_hydroxide] of  WeakBase

	(categoryPH base)
	(colour none)
	(englishName "Rubidium hydroxide")
	(formula "RbOH")
	(greekName "Υδροξείδιο του Ρουβιδίου")
	(radioactive TRUE)
	(smell none)
	(solubility soluble)
	(specificGravityHint heavier_than_water)
	(spectroscopy metal)
	(strength weak))

([sodium_hydroxide] of  StrongBase

	(categoryPH base)
	(colour none)
	(englishName "Sodium hydroxide")
	(formula "NaOH")
	(greekName "Υδροξείδιο του Νατρίου")
	(hazards corrosive)
	(smell none)
	(solubility soluble)
	(specificGravityHint equal_to_water)
	(spectroscopy sodium)
	(strength strong))

([store_1] of  Store

	(connectedManhole [manhole_1])
	(containsChemical
		[sulphuric_acid]
		[petrol]))

([store_2] of  Store

	(connectedManhole [manhole_2])
	(containsChemical
		[hydrochloric_acid]
		[acetic_acid]))

([store_3] of  Store

	(connectedManhole [manhole_3])
	(containsChemical
		[rubidium_hydroxide]
		[transformer_oil]))

([store_4] of  Store

	(connectedManhole [manhole_4])
	(containsChemical
		[carbonic_acid]
		[acetic_acid]
		[petrol]))

([store_5] of  Store

	(connectedManhole [manhole_5])
	(containsChemical
		[chromogen_23]
		[sulphuric_acid]
		[petrol]))

([store_6] of  Store

	(connectedManhole [manhole_6])
	(containsChemical
		[aluminium_hydroxide]
		[transformer_oil]
		[carbonic_acid]))

([store_7] of  Store

	(connectedManhole [manhole_7])
	(containsChemical
		[hydrochloric_acid]
		[sulphuric_acid]))

([store_8] of  Store

	(connectedManhole [manhole_8])
	(containsChemical
		[acetic_acid]
		[carbonic_acid]
		[sodium_hydroxide]))

([sulphuric_acid] of  StrongAcid

	(categoryPH acid)
	(colour none)
	(englishName "Sulphuric acid")
	(formula "H2SO4")
	(greekName "Θειικό οξύ")
	(hazards burns_skin)
	(smell none)
	(solubility soluble)
	(specificGravityHint equal_to_water)
	(spectroscopy sulphur)
	(strength strong))

([transformer_oil] of  Oil

	(categoryPH oil)
	(colour none)
	(englishName "Transformer oil")
	(formula "??")
	(greekName "Πετρέλαιο μετασχηματιστή")
	(hazards highly_toxic_PCBs)
	(smell none)
	(solubility insoluble)
	(specificGravityHint equal_to_water)
	(spectroscopy carbon)
	(strength none))

)


; ---- Δυναμική γνώση & επίλυση (CLIPS) ----

(defglobal
  ?*input-ended* = FALSE)

; ---------- Βοηθητικές συναρτήσεις εισόδου ----------

(deffunction input-ended ()
  (bind ?*input-ended* TRUE)
  (printout t crlf "Telos eisodou. H ektelesi diakoptetai." crlf)
  (return EOF))

(deffunction _print-options ($?opts)
  (foreach ?o ?opts (printout t ?o " ")))

(deffunction ask-choice (?prompt $?allowed)
  (printout t ?prompt)
  (bind ?ans (read))
  (if (eq ?ans EOF) then (return (input-ended)))
  (while (not (member$ ?ans ?allowed)) do
    (printout t "Mh egkyrh timh. Epilexe apo: ")
    (_print-options ?allowed)
    (printout t crlf)
    (printout t ?prompt)
    (bind ?ans (read))
    (if (eq ?ans EOF) then (return (input-ended))))
  (return ?ans))

(deffunction ask-yes-no (?prompt)
  (return (ask-choice ?prompt yes no)))

(deffunction ask-number (?prompt ?min ?max)
  (printout t ?prompt)
  (bind ?ans (read))
  (if (eq ?ans EOF) then (return (input-ended)))
  (while (or (not (numberp ?ans)) (< ?ans ?min) (> ?ans ?max)) do
    (printout t "Mh egkyrh timh. Dose arithmo apo " ?min " ews " ?max crlf)
    (printout t ?prompt)
    (bind ?ans (read))
    (if (eq ?ans EOF) then (return (input-ended))))
  (return ?ans))

(deffunction ask-line-tokens (?prompt)
  (printout t ?prompt)
  (bind ?line (readline))
  (if (eq ?line EOF) then (input-ended) (return (create$ EOF)))
  (bind ?tokens (explode$ ?line))
  (while (= (length$ ?tokens) 0) do
    (printout t "Dose toulaxiston mia timh." crlf)
    (printout t ?prompt)
    (bind ?line (readline))
    (if (eq ?line EOF) then (input-ended) (return (create$ EOF)))
    (bind ?tokens (explode$ ?line)))
  (return ?tokens))

; ---------- Βοηθητικές συναρτήσεις γνώσης ----------

(deffunction ph->category (?ph)
  (if (< ?ph 6.0) then (return acid))
  (if (< ?ph 8.0) then (return oil))
  (return base))

(deffunction ph->strength (?ph ?category)
  (if (eq ?category acid) then
    (if (< ?ph 3.0) then (return strong) else (return weak)))
  (if (eq ?category base) then
    (if (>= ?ph 11.0) then (return strong) else (return weak)))
  (return none))

(deffunction sg->hint (?sg)
  (if (< ?sg 1.0) then (return lighter_than_water))
  (if (> ?sg 1.0) then (return heavier_than_water))
  (return equal_to_water))

(deffunction _get (?inst ?slot ?default)
  (bind ?msg (sym-cat get- ?slot))
  (bind ?val (send ?inst ?msg))
  (if (eq ?val nil) then (return ?default))
  (return ?val))

(deffunction instance-of (?inst ?cls)
  ;; TRUE an to ?inst anhkei sthn klash ?cls (h ypoklash).
  (if (not (instance-existp ?inst)) then (return FALSE))
  (bind ?addr (instance-address ?inst))
  (bind ?c (class ?addr))
  (if (or (eq ?c ?cls) (subclassp ?c ?cls)) then (return TRUE) else (return FALSE)))

(deffunction path-to-station (?start)
  ; Empty path means a missing node, invalid node type, or cycle.
  (bind ?path (create$))
  (bind ?curr ?start)
  (while TRUE do
    (if (not (instance-existp ?curr)) then (return (create$)))
    (bind ?curr (instance-name ?curr))
    (if (member$ ?curr ?path) then (return (create$)))
    (bind ?path (create$ ?path ?curr))
    (if (instance-of ?curr MonitoringStation) then (return ?path))
    (if (not (instance-of ?curr Manhole)) then (return (create$)))
    (bind ?curr (send ?curr get-downstream))))

(deffunction validate-knowledge ()
  ; The observation belongs to one monitoring station. All routes must reach it.
  (if (neq (length$ (find-all-instances ((?s MonitoringStation)) TRUE)) 1) then
    (printout t "Mh egkyrh gnwsh: apaiteitai enas stathmos elegxou." crlf)
    (return FALSE))
  (foreach ?m (find-all-instances ((?m Manhole)) TRUE)
    (if (= (length$ (path-to-station ?m)) 0) then
      (printout t "Mh egkyrh diadromh apo " ?m ": kyklos h elleiphs komvos." crlf)
      (return FALSE)))
  (foreach ?s (find-all-instances ((?s Store)) TRUE)
    (bind ?m (send ?s get-connectedManhole))
    (if (or (not (instance-of ?m Manhole)) (= (length$ (path-to-station ?m)) 0)) then
      (printout t "Mh egkyrh syndesh apothikis " ?s crlf)
      (return FALSE))
    (bind ?contents (send ?s get-containsChemical))
    (if (= (length$ ?contents) 0) then
      (printout t "Apothiki xwris xhmika: " ?s crlf)
      (return FALSE))
    (foreach ?c ?contents
      (if (not (instance-of ?c Chemical)) then
        (printout t "Mh egkyrh anafora xhmikou: " ?c crlf)
        (return FALSE))))
  (return TRUE))

(deffunction valid-spectrum (?tokens)
  (if (= (length$ ?tokens) 0) then (return FALSE))
  (foreach ?e ?tokens
    (if (not (member$ ?e (create$ none sulphur carbon sodium metal))) then (return FALSE)))
  ; "none" and detected elements are contradictory observations.
  (if (and (member$ none ?tokens) (> (length$ ?tokens) 1)) then (return FALSE))
  (return TRUE))

(deffunction store-path-contains (?store ?manhole)
  (bind ?start (send ?store get-connectedManhole))
  (bind ?path (path-to-station ?start))
  (if (member$ ?manhole ?path) then (return TRUE) else (return FALSE)))

(deffunction chemical-matches (?chem ?ph ?sol ?spec ?colour ?smell ?sgHint ?radio)
  ; ?ph: number or unknown
  ; ?sol: symbol or unknown
  ; ?spec: multifield or unknown
  ; ?colour/?smell: symbol or unknown
  ; ?sgHint: symbol or unknown
  ; ?radio: yes/no/unknown

  (bind ?cat (_get ?chem categoryPH unknown))
  (bind ?str (_get ?chem strength unknown))

  (if (neq ?ph unknown) then
    (bind ?ecat (ph->category ?ph))
    (if (neq ?cat ?ecat) then (return FALSE))
    (bind ?estr (ph->strength ?ph ?ecat))
    (if (neq ?str ?estr) then (return FALSE)))

  (if (neq ?sol unknown) then
    (if (neq (_get ?chem solubility unknown) ?sol) then (return FALSE)))

  (if (neq ?colour unknown) then
    (if (neq (_get ?chem colour unknown) ?colour) then (return FALSE)))

  (if (neq ?smell unknown) then
    (if (neq (_get ?chem smell unknown) ?smell) then (return FALSE)))

  (if (neq ?sgHint unknown) then
    (if (neq (_get ?chem specificGravityHint unknown) ?sgHint) then (return FALSE)))

  (if (neq ?radio unknown) then
    (bind ?r (_get ?chem radioactive FALSE))
    (if (and (eq ?radio yes) (neq ?r TRUE)) then (return FALSE))
    (if (and (eq ?radio no) (eq ?r TRUE)) then (return FALSE)))

  (if (neq ?spec unknown) then
    (bind ?chemSpec (_get ?chem spectroscopy (create$)))
    (if (and (= (length$ ?spec) 1) (eq (nth$ 1 ?spec) none)) then
      (if (or (neq (length$ ?chemSpec) 1) (neq (nth$ 1 ?chemSpec) none)) then (return FALSE))
    else
      (foreach ?e ?spec
        (if (not (member$ ?e ?chemSpec)) then (return FALSE)))))

  (return TRUE))

(deffunction stores-containing-any (?chems)
  ;; Επιστρέφει όλες τις αποθήκες που περιέχουν ΤΟΥΛΑΧΙΣΤΟΝ ΕΝΑ από τα υποψήφια χημικά.
  ;; Το ?chems είναι multifield με instance-names χημικών.
  (bind ?result (create$))
  (bind ?all (find-all-instances ((?s Store)) TRUE))
  (foreach ?sA ?all
    (bind ?s (instance-name ?sA))
    (bind ?contents (_get ?s containsChemical (create$)))
    (bind ?ok FALSE)
    (foreach ?c ?chems
      (if (member$ ?c ?contents) then (bind ?ok TRUE)))
    (if ?ok then (bind ?result (create$ ?result ?s))))
  (return ?result))


;; Απόσταση ενός φρεατίου από το σταθμό (πόσα "βήματα" downstream μέχρι MonitoringStation).
(deffunction manhole-distance-to-station (?mh)
  (bind ?p (path-to-station ?mh))
  (if (< (length$ ?p) 2) then (return 9999))
  (return (- (length$ ?p) 1)))


;; Αριθμητικός δείκτης φρεατίου από το instance-name (manhole_10 -> 10).
(deffunction manhole-id (?mh)
  ;; Αριθμητικός δείκτης φρεατίου από το instance-name (manhole_10 -> 10).
  (if (not (instance-existp ?mh)) then (return 0))
  (bind ?addr (instance-address ?mh))
  (bind ?nm (instance-name ?addr))
  (bind ?s (str-cat ?nm))
  (bind ?p (str-index "_" ?s))
  (if (eq ?p FALSE) then (return 0))
  (bind ?num (sub-string (+ ?p 1) (str-length ?s) ?s))
  (bind ?f (string-to-field ?num))
  (if (numberp ?f) then (return ?f) else (return 0)))

(deffunction best-splitting-manhole (?stores ?asked)
  ;; Επιλέγει "ενημερωτικό" φρεάτιο για ερώτηση.
  ;; Κριτήρια (ώστε να ταιριάζει με τα παραδείγματα της εκφώνησης):
  ;; 1) Πιο κοντά στο σταθμό (μικρότερη απόσταση)
  ;; 2) Καλύτερο split (μικρότερη ανισορροπία yes/no)
  ;; 3) Σε πλήρη ισοπαλία, προτιμά το φρεάτιο με "μεγαλύτερο" όνομα (π.χ. manhole_13 αντί manhole_12).

  (bind ?n (length$ ?stores))
  (if (<= ?n 1) then (return FALSE))

  (bind ?best FALSE)
  (bind ?bestDist 9999)
  (bind ?bestImbalance 9999)
  (bind ?bestId -1)

  (bind ?mhs (find-all-instances ((?m Manhole)) TRUE))
  (foreach ?mhA ?mhs
    (bind ?mh (instance-name ?mhA))
    (if (not (member$ ?mh ?asked)) then
      (bind ?yes 0)
      (foreach ?s ?stores
        (if (store-path-contains ?s ?mh) then (bind ?yes (+ ?yes 1))))

      ;; informative μόνο αν χωρίζει το σύνολο (0 < yes < n)
      (if (and (> ?yes 0) (< ?yes ?n)) then
        (bind ?no (- ?n ?yes))
        (bind ?imb (abs (- ?yes ?no)))
        (bind ?dist (manhole-distance-to-station ?mh))
        (bind ?id (manhole-id ?mh))

        (if (or (< ?dist ?bestDist)
                (and (= ?dist ?bestDist) (< ?imb ?bestImbalance))
                (and (= ?dist ?bestDist) (= ?imb ?bestImbalance) (> ?id ?bestId))) then
          (bind ?best ?mh)
          (bind ?bestDist ?dist)
          (bind ?bestImbalance ?imb)
          (bind ?bestId ?id)))))

  (return ?best))

(deffunction filter-stores-by-manhole (?mh ?ans ?stores)
  (bind ?result (create$))
  (foreach ?s ?stores
    (bind ?has (store-path-contains ?s ?mh))
    (if (or (and (eq ?ans yes) ?has)
            (and (eq ?ans no) (not ?has))) then
      (bind ?result (create$ ?result ?s))))
  (return ?result))


; --- Project2 helpers (dynamic reasoning) ---
(deffunction intersect$ (?a ?b)
  ; επιστρέφει τομή δύο multifields (π.χ. candidates ∩ contents)
  (bind ?out (create$))
  (foreach ?x ?a
    (if (member$ ?x ?b) then
      (bind ?out (create$ ?out ?x))))
  (return ?out))

(deffunction print-chem-results (?chems)
  ; τυπώνει τα πιθανά χημικά + κινδύνους
  (if (or (eq ?chems nil) (= (length$ ?chems) 0)) then
    (printout t "Den entopistikan pithana xhmika me ta dedomena." crlf)
    (return))
  (foreach ?c ?chems
    (printout t "To xhmiko poy prokalese th molynsh pithanon na einai to " (instance-name ?c) crlf)
    (bind ?hz (_get ?c hazards nil))
    (if (and (neq ?hz nil) (> (length$ ?hz) 0)) then
      (printout t "Pithanoi kindynoi: ")
      (foreach ?h ?hz (printout t ?h " "))
      (printout t crlf))))

; ---------- Κύρια ροή ----------

(deffunction main ()
  (bind ?*input-ended* FALSE)
  (if (not (validate-knowledge)) then (return))
  (printout t crlf "--- Entopismos xhmikhs molynshs ---" crlf)

  (bind ?allowedMeasures (create$ pH solubility spectrometry colour smell specific_gravity radioactivity spectroscopy))
  (bind ?wanted (create$))

  (while (= (length$ ?wanted) 0) do
    (bind ?raw (ask-line-tokens "Gia poies metriseis tha dothoyn times? (pH solubility spectrometry colour smell specific_gravity radioactivity) "))
    (if ?*input-ended* then (return))
    (bind ?valid TRUE)
    (bind ?pending (create$))
    (foreach ?m ?raw
      (bind ?mm ?m)
      (if (eq ?mm spectroscopy) then (bind ?mm spectrometry))
      (if (not (member$ ?mm ?allowedMeasures)) then
        (bind ?valid FALSE)
      else
        (if (not (member$ ?mm ?pending)) then
          (bind ?pending (create$ ?pending ?mm)))))
    (if ?valid then
      (bind ?wanted ?pending)
    else
      (printout t "Mh egkyrh metrisi. Dose xana olh th lista." crlf)))

  ; Παρατηρήσεις (ό,τι δεν δόθηκε παραμένει 'unknown')
  (bind ?ph unknown)
  (bind ?sol unknown)
  (bind ?spec unknown)
  (bind ?colour unknown)
  (bind ?smell unknown)
  (bind ?sgHint unknown)
  (bind ?radio unknown)

  (foreach ?m ?wanted
    (if (eq ?m pH) then
      (bind ?ph (ask-number "Poio einai to pH ths molinsis? (0 - 14) " 0 14)))

    (if (eq ?m solubility) then
      (bind ?sol (ask-choice "Poia einai h dialytothta ths molinsis? (soluble, insoluble) " soluble insoluble)))

    (if (eq ?m colour) then
      (bind ?colour (ask-choice "Poio einai to xrwma ths molinsis? (red, white, none) " red white none)))

    (if (eq ?m smell) then
      (bind ?smell (ask-choice "Poia einai h osmh ths molinsis? (choking, vinegar, none) " choking vinegar none)))

    (if (eq ?m specific_gravity) then
      (bind ?sg (ask-number "Poio einai to eidiko baros ths molinsis? (0.9 - 1.1) " 0.9 1.1))
      (if ?*input-ended* then (return))
      (bind ?sgHint (sg->hint ?sg)))

    (if (eq ?m radioactivity) then
      (bind ?radio (ask-yes-no "Einai radienergos h molinsh? (yes, no) ")))

    (if (eq ?m spectrometry) then
      (bind ?tmp (ask-line-tokens "Ti deixnei h fasmatoskopia gia th molinsh? (none sulphur carbon sodium metal) "))
      (if ?*input-ended* then (return))
      (while (not (valid-spectrum ?tmp)) do
        (printout t "Mh egkyrh timh. To none den syndyazetai me stoixeia. Dose none sulphur carbon sodium metal." crlf)
        (bind ?tmp (ask-line-tokens "Ti deixnei h fasmatoskopia gia th molinsh? (none sulphur carbon sodium metal) "))
        (if ?*input-ended* then (return)))
      (bind ?spec ?tmp))

    (if ?*input-ended* then (return)))

  ; 1) Υποψήφια χημικά με βάση τις μετρήσεις
  (bind ?allChems (find-all-instances ((?c Chemical)) TRUE))
  (bind ?cands (create$))
  (foreach ?c ?allChems
    (if (chemical-matches ?c ?ph ?sol ?spec ?colour ?smell ?sgHint ?radio) then
      (bind ?cands (create$ ?cands ?c))))

  (if (= (length$ ?cands) 0) then
    (printout t crlf "Den vrethike xhmiko pou na ejhgei oles tis metriseis." crlf)
    (return))

  ; 2) Υποψήφιες αποθήκες: όσες περιέχουν έστω ένα από τα υποψήφια χημικά
  (printout t crlf "--- Entopismos phghs (apothikis) ---" crlf)
  (bind ?stores (stores-containing-any ?cands))

  (if (= (length$ ?stores) 0) then
    (printout t "Den vrethike apothiki me ta ypopsifia xhmika." crlf)
    (return))

  ; Ερωτήσεις σε φρεάτια μέχρι να μείνει 1 αποθήκη
  (bind ?asked (create$))
  (while (> (length$ ?stores) 1) do
    (bind ?mh (best-splitting-manhole ?stores ?asked))
    (if (eq ?mh FALSE) then
      ; Shared routes can make sources indistinguishable; do not repeat questions.
      (printout t "Den yparxei allo enhmerwtiko freatio. H phgh paramenei asafhs: " ?stores crlf)
      (print-chem-results ?cands)
      (return))

    (bind ?ans (ask-yes-no (str-cat "Yparxei molynsh sto freatio " (instance-name ?mh) "? (yes/no) ")))
    (if ?*input-ended* then (return))
    (bind ?asked (create$ ?asked ?mh))
    (bind ?newStores (filter-stores-by-manhole ?mh ?ans ?stores))

    (if (= (length$ ?newStores) 0) then
      (printout t "Oi apantiseis odhgoun se adynamh katastash (kamia apothiki). Elegxe tis apantiseis." crlf)
      (return))

    (bind ?stores ?newStores))

  (bind ?source (nth$ 1 ?stores))

  ; 3) Τελικό αποτέλεσμα: φίλτρο των υποψήφιων χημικών με βάση την τελική αποθήκη
  (bind ?storeChems (_get ?source containsChemical (create$)))
  (bind ?finalChems (intersect$ ?cands ?storeChems))

  (printout t crlf)
  (print-chem-results ?finalChems)
  (printout t "H phgh ths molynshs einai h apothiki " (instance-name ?source) crlf))

(deffacts startup
  (go))

(defrule run-system
  ?f <- (go)
  =>
  (retract ?f)
  (main))

