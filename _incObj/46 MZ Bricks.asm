; ---------------------------------------------------------------------------

ObjMZBlocks:
		moveq	#0,d0
		move.b	$24(a0),d0
		move.w	off_C3FC(pc,d0.w),d1
		jmp	off_C3FC(pc,d1.w)
; ---------------------------------------------------------------------------

off_C3FC:	dc.w loc_C400-off_C3FC, loc_C43C-off_C3FC
; ---------------------------------------------------------------------------

loc_C400:
		addq.b	#2,$24(a0)
		move.b	#$F,$16(a0)
		move.b	#$F,$17(a0)
		move.l	#MapMZBlocks,4(a0)
		move.w	#$4000,2(a0)
		move.b	#4,1(a0)
		move.b	#3,$19(a0)
		move.b	#$10,$18(a0)
		move.w	$C(a0),$30(a0)
		move.w	#$5C0,$32(a0)

loc_C43C:
		tst.b	1(a0)
		bpl.s	loc_C46A
		moveq	#0,d0
		move.b	$28(a0),d0
		andi.w	#7,d0
		add.w	d0,d0
		move.w	off_C48E(pc,d0.w),d1
		jsr	off_C48E(pc,d1.w)
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	#$11,d3
		move.w	8(a0),d4
		bsr.w	SolidObject

loc_C46A:
		bsr.w	DisplaySprite
		move.w	8(a0),d0
		andi.w	#$FF80,d0
		move.w	(v_screenposx).w,d1
		subi.w	#$80,d1
		andi.w	#$FF80,d1
		sub.w	d1,d0
		cmpi.w	#$280,d0
		bhi.w	DeleteObject
		rts
; ---------------------------------------------------------------------------

off_C48E:	dc.w locret_C498-off_C48E, loc_C4B2-off_C48E, loc_C49A-off_C48E, loc_C4D2-off_C48E
		dc.w loc_C50E-off_C48E
; ---------------------------------------------------------------------------

locret_C498:
		rts
; ---------------------------------------------------------------------------

loc_C49A:
		move.w	(v_objspace+8).w,d0
		sub.w	8(a0),d0
		bcc.s	loc_C4A6
		neg.w	d0

loc_C4A6:
		cmpi.w	#$90,d0
		bcc.s	loc_C4B2
		move.b	#3,$28(a0)

loc_C4B2:
		moveq	#0,d0
		move.b	(oscValues+$16).w,d0
		btst	#3,$28(a0)
		beq.s	loc_C4C6
		neg.w	d0
		addi.w	#$10,d0

loc_C4C6:
		move.w	$30(a0),d1
		sub.w	d0,d1
		move.w	d1,$C(a0)
		rts
; ---------------------------------------------------------------------------

loc_C4D2:
		bsr.w	SpeedToPos
		addi.w	#$18,$12(a0)
		bsr.w	ObjectHitFloor
		tst.w	d1
		bpl.w	locret_C50C
		add.w	d1,$C(a0)
		clr.w	$12(a0)
		move.w	$C(a0),$30(a0)
		move.b	#4,$28(a0)
		move.w	(a1),d0
		andi.w	#$3FF,d0
		cmpi.w	#$2E8,d0
		bcc.s	locret_C50C
		move.b	#0,$28(a0)

locret_C50C:
		rts
; ---------------------------------------------------------------------------

loc_C50E:
		moveq	#0,d0

loc_C510:
		move.b	(oscValues+$12).w,d0
		lsr.w	#3,d0
		move.w	$30(a0),d1
		sub.w	d0,d1
		move.w	d1,$C(a0)
		rts