; Different styles of generic operations:

; Explicit dispatch
; All specific methods (getters/constructors/etc.) must be implemented,
; and each of the generic procedures must be edited to allow the new
; type to be part of the control flow.

; Data-directed programming
; All specific methods must be implemented and placed in a table
; for generic fetching on type.
; To add a new operation, we need to implement the operation and place
; it in the table for each type.

; Message-passing
; To add a new type, just implement constructor for that type (i.e. 2.75).
; To add a new operation, add implementation of operation to each type.


; Systems with frequently changing types => could be either data-directed or message-passing
;    style, depending on other specifics.  Explicit dispatch would be very cumbersome when frequently
;    adding types.
; Systems with frequently changing ops => data-directed programming would better than message-passing
;    I think as the specific implementations are more "attached" to a generic interface (i.e. easier 
;    to track/organize all the types for which the op needs to be implemented).
; Not sure there's as big a difference as it first seems for either of these scenarios??
;
