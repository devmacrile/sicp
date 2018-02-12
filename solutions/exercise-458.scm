(rule (big-shot ?person ?division)
      (and (job ?person (?division .))
	   (supervisor ?person ?supervisor)
	   (not (job ?supervisor (?divison .)))))
