; ---------------------------------------------------------------------------

ObjLavaHurt:
		moveq	#0,d0
		move.b	objRoutine(a0),d0
		move.w	off_CD2E(pc,d0.w),d1
		jmp	off_CD2E(pc,d1.w)
; ---------------------------------------------------------------------------

off_CD2E:	dc.w loc_CD36-off_CD2E, loc_CD6C-off_CD2E

byte_CD32:	dc.b $96, $94, $95, 0
; ---------------------------------------------------------------------------

loc_CD36:
		addq.b	#2,objRoutine(a0)
		moveq	#0,d0
		move.b	objSubtype(a0),d0
		move.b	byte_CD32(pc,d0.w),objColType(a0)
		move.l	#Map_LTag,objMap(a0)
		move.w	#$8680,objGfx(a0)
		move.b	#4,objRender(a0)
		move.b	#$80,objActWid(a0)
		move.b	#4,objPriority(a0)
		move.b	objSubtype(a0),objFrame(a0)

loc_CD6C:
		tst.w	(v_debuguse).w
		beq.s	loc_CD76
		bsr.w	DisplaySprite

loc_CD76:
		cmpi.b	#6,(v_player+objRoutine).w
		bcc.s	loc_CD84
		bset	#7,objRender(a0)

loc_CD84:
		move.w	objX(a0),d0
		andi.w	#$FF80,d0
		move.w	(v_screenposx).w,d1
		subi.w	#$80,d1
		andi.w	#$FF80,d1
		sub.w	d1,d0
		bmi.w	DeleteObject
		cmpi.w	#$280,d0
		bhi.w	DeleteObject
		rts