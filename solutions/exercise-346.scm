; Not going to do the timing diagram; pretty simple conceptually: some process
; winds up with a call to test-and-set! that is given a stale read via
; some other process setting the cell to true.