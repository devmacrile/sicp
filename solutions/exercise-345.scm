; Main issue, I think, is that the same serializer is utilized on withdraw and deposit,
; so the exchange procedure itself is serialized with the same serializer as the
; respective accessor used within exchange (thus those procedures would be placed
; in the same set, and you'd have a deadlock).