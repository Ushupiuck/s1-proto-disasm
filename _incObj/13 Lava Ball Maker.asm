; ---------------------------------------------------------------------------

ObjLavaMaker:
		moveq	#0,d0
		move.b	$24(a0),d0
		move.w	off_C1D0(pc,d0.w),d1
		jsr	off_C1D0(pc,d1.w)
		bra.w	loc_C2E6
; ---------------------------------------------------------------------------

off_C1D0:	dc.w loc_C1DA-off_C1D0, loc_C1FA-off_C1D0

byte_C1D4:	dc.b $1E, $3C, $5A, $78, $96, $B4
; ---------------------------------------------------------------------------

loc_C1DA:
		addq.b	#2,$24(a0)
		move.b	obSubtype(a0),d0
		lsr.w	#4,d0
		andi.w	#$F,d0
		move.b	byte_C1D4(pc,d0.w),$1F(a0)
		move.b	$1F(a0),$1E(a0)
		andi.b	#$F,obSubtype(a0)

loc_C1FA:
		subq.b	#1,$1E(a0)
		bne.s	locret_C22A
		move.b	$1F(a0),$1E(a0)
		bsr.w	ObjectChkOffscreen
		bne.s	locret_C22A
		bsr.w	ObjectLoad
		bne.s	locret_C22A
		move.b	#$14,0(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	obSubtype(a0),obSubtype(a1)

locret_C22A:
		rts