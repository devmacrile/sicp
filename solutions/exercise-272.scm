; Encoding just encodes each symbol in a pair set, so the real variable
; work happens in the encoding of a symbol in a tree.  In general, the order
; of growth depends a lot on the relative frequencies, which determines how
; balanced each node of the tree is (i.e. a Huffman tree is optimal for 
; encoding, not for lookup).
;
; For the case in 2.71, on average you will have to do a logarithmic number
; of lookups at the nodes, and at each node we have to do a set lookup,
; which with our binary search implementation is O(log n).  So encoding a
; single symbol would be O((log n) ^2).