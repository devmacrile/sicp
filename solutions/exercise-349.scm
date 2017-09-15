; Why does deadlock-avoidance scheme work?
;   -- Because each process knows in advance the resources it requires
; Scenario where this avoidance scheme fails?
;   -- So need a scenario where a process does not know in advance what
;      resource locks it would need, and thus they cannot be ordered.  One 
;      silly example would be a procedure that needs to look up some information
;      in some arbitrary file, use some message to fetch particular data, do some 
;      processing and write results to some other arbitrary file (and either file 
;      can serve either purpose).  Then could end up with two procedures requiring
;      each other's input files as output since they did not know ahead of time
;      which output file they would require (contrived, yes).