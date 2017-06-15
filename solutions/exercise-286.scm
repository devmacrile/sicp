; The internal procedures for the complex package will have
; to be changed to utilize the generic arithmetic functions 
; (i.e. + -> add, - -> sub, etc.)
;
; Then we'd have to define generic sine and cosine as suggested,
; which involves a package-level implementation for each
; pertinent type, and then putting each of those in the table.
; Then in the rectangular/polar packages switch the calls from
; the built-in sin/cos to our generic sine/cosine, respectively.
