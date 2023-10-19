; ---------------------------------------------------------------------------

Obj10:
		moveq	#0,d0
		move.b	objRoutine(a0),d0
		move.w	off_111D0(pc,d0.w),d1
		jmp	off_111D0(pc,d1.w)
; ---------------------------------------------------------------------------

off_111D0:	dc.w Obj10_Init-off_111D0, loc_11202-off_111D0, loc_11286-off_111D0, loc_11286-off_111D0
; ---------------------------------------------------------------------------

Obj10_Init:
		addq.b	#2,objRoutine(a0)
		move.b	#$12,objHeight(a0)
		move.b	#9,objWidth(a0)
		move.l	#Map_Sonic,objMap(a0)
		move.w	#$780,objGfx(a0)
		move.b	#4,objRender(a0)
		move.b	#2,objPriority(a0)

loc_11202:
		bsr.w	sub_11210
		bsr.w	Sonic_DynTiles
		jmp	(DisplaySprite).l
; ---------------------------------------------------------------------------

sub_11210:
		move.b	(v_jpadhold2).w,d4
		move.w	objY(a0),d2
		move.w	objX(a0),d3
		moveq	#1,d1
		btst	#bitUp,d4
		beq.s	loc_11226
		sub.w	d1,d2

loc_11226:
		btst	#bitDn,d4
		beq.s	loc_1122E
		add.w	d1,d2

loc_1122E:
		btst	#bitL,d4
		beq.s	loc_11236
		sub.w	d1,d3

loc_11236:
		btst	#bitR,d4
		beq.s	loc_1123E
		add.w	d1,d3

loc_1123E:
		move.w	d2,objY(a0)
		move.w	d3,objX(a0)
		btst	#bitB,(v_jpadpress2).w
		beq.s	loc_11264
		move.b	objRender(a0),d0
		move.b	d0,d1
		addq.b	#1,d0
		andi.b	#3,d0
		andi.b	#$FC,d1
		or.b	d1,d0
		move.b	d0,objRender(a0)

loc_11264:
		btst	#bitC,(v_jpadpress2).w
		beq.s	loc_1127E
		addq.b	#1,objAnim(a0)
		cmpi.b	#$19,objAnim(a0)
		bcs.s	loc_1127E
		move.b	#0,objAnim(a0)

loc_1127E:
		jsr	(Sonic_Animate).l
		rts
; ---------------------------------------------------------------------------

loc_11286:
		jmp	(DeleteObject).l
