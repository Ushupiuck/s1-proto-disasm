RememberState:
		out_of_range_rememberstate.w	loc_B938
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_B938:
		lea	(v_regbuffer).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	loc_B94A
		bclr	#7,2(a2,d0.w)

loc_B94A:
		bra.w	DeleteObject