; (a)
(meeting ?division (Friday . ?time))

; (b)
(rule (meeting-time ?person ?day-and-time)
      (or (meeting whole-company ?day-and-time)
	  (and (job ?person (?division . ?title))
	       (meeting ?division ?day-and-time))))

; (c)
(meeting-time (Hacker Alyssa P) (Wednesday . ?time))

