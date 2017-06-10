; I'm a little confused on this one as to the (magnitude) definition 
; actually resides, so not sure how the puts resolve the issue by themselves?
; Seems I'm not alone: http://community.schemewiki.org/?sicp-ex-2.77
; But if those existed, the puts make those calls as part of the public interface.

; apply-generic would be called twice: once on the 'complex' number, and again when
; dispatched on 'rectangular'.