;;#01
{inc (-> :Int : Int)}
(inc 10)
;; :Int

;;#02
{inc (-> :Int : Int),
 x :Str}
(inc x)
;;ERROR

;;#03
{inc (-> :Int : Int)}
(inc x)
;; :Int

;;#04
{inc (-> :Int : Int), >0 (-> :Int :Bool)}
(inc (>0 10))
;;ERROR

;;#05
{inc (-> :Int :Int)}
[(inc 1) (inc 2)]
;;(cross :Int :Int)

;;#06
{= (-> A (-> A :Bool))}
(= 1)
;; (-> :Int : Bool)

;;#07
{= (-> A (-> A :Bool))}
[(= 1) (= "str")]
;;ERROR

;;#08
{inc (-> :Int :Int)}
(inc (dec 1))
;; :Int

;;#09
{}
(dec (dec 1))
;; :Int

;;#10
{inc (-> :Int : Int)}
(lambda x (inc x))
;; (-> :Int : Int)

;;#11
{}
((lambda x x) 10)
;; (-> :Int : Int)

;;#12
{x :Str, 
 inc (-> :Int :Int),
 concat (-> :Str (-> :Str :Str))}
[(concat x) (lambda x (inc (inc x)))]
;; (cross (-> :Str :Str) (-> :Int :Int))

;;#13
{head (-> (:List A) A),
 x (:List :Int)}
(head x)
;; :Int

;; Advanced

;;#14
{x (:List :Int),
 =0 (-> :Int :Bool)}
[((map inc) x) 
 (=0 (inc 1)) 
 map]

;;#15
{* (-> :Int (-> :Int :Int)), 
 = (-> A (-> A :Bool))}
(let [fact (lambda n (((if ((= n) 1))
						1) 
						((* n) (fact (dec n)))))]
	(fact 10))

;;#16
{dec (-> :Int :Int),
 concat (-> :Str (-> :Str :Str)),
 * (-> :Int (-> :Int :Int))}
(let [times (lambda n 
				(lambda f
					(lambda x
						(f (((times (dec n)) f) x)))))]
 [(((times 2) dec) 10) 
  ((times 5) (concat "a"))
  (lambda times (* times))])
;; Note: definition for 'times' is incorrect (there is an infinite recursion) but it doesn't matter for the type inference
