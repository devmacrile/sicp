; This is due to the way that the parse-{noun, verb}-phrase procedures
; are define recursively with maybe-extend.  Specifically, this extension
; should parse recursively only if the noun-phrase ambs-out.
;
; Edit: 4.47 has me rethinking this... might be more to do with the global *unparsed*.
