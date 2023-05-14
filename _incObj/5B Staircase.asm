; ---------------------------------------------------------------------------

ObjStaircasePtfm:
		moveq	#0,d0
		move.b	$24(a0),d0
		move.w	off_E358(pc,d0.w),d1
		jsr	off_E358(pc,d1.w)
		move.w	$30(a0),d0
		andi.w	#$FF80,d0
		move.w	(v_screenposx).w,d1
		subi.w	#$80,d1
		andi.w	#$FF80,d1
		sub.w	d1,d0
		cmpi.w	#$280,d0
		bhi.w	DeleteObject
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

off_E358:	dc.w loc_E35E-off_E358, loc_E3DE-off_E358, loc_E3F2-off_E358
; ---------------------------------------------------------------------------

loc_E35E:
		addq.b	#2,$24(a0)
		moveq	#$38,d3
		moveq	#1,d4
		btst	#0,$22(a0)
		beq.s	loc_E372
		moveq	#$3B,d3
		moveq	#-1,d4

loc_E372:
		move.w	8(a0),d2
		movea.l	a0,a1
		moveq	#3,d1
		bra.s	loc_E38A
; ---------------------------------------------------------------------------

loc_E37C:
		bsr.w	LoadNextObject
		bne.w	loc_E3DE
		move.b	#4,$24(a1)

loc_E38A:
		move.b	#$5B,0(a1)
		move.l	#MapStaircasePtfm,4(a1)
		move.w	#$4480,2(a1)
		move.b	#4,1(a1)
		move.b	#3,$19(a1)
		move.b	#$10,$18(a1)
		move.b	$28(a0),$28(a1)
		move.w	d2,8(a1)
		move.w	$C(a0),$C(a1)
		move.w	8(a0),$30(a1)
		move.w	$C(a1),$32(a1)
		addi.w	#$20,d2
		move.b	d3,$37(a1)
		move.l	a0,$3C(a1)
		add.b	d4,d3
		dbf	d1,loc_E37C

loc_E3DE:
		moveq	#0,d0
		move.b	$28(a0),d0
		andi.w	#7,d0
		add.w	d0,d0
		move.w	off_E43A(pc,d0.w),d1
		jsr	off_E43A(pc,d1.w)

loc_E3F2:
		movea.l	$3C(a0),a2
		moveq	#0,d0
		move.b	$37(a0),d0
		move.b	(a2,d0.w),d0
		add.w	$32(a0),d0
		move.w	d0,$C(a0)
		moveq	#0,d1
		move.b	$18(a0),d1
		addi.w	#$B,d1
		move.w	#$10,d2
		move.w	#$11,d3
		move.w	8(a0),d4
		bsr.w	SolidObject
		tst.b	d4
		bpl.s	loc_E42A
		move.b	d4,$36(a2)

loc_E42A:
		btst	#3,$22(a0)
		beq.s	locret_E438
		move.b	#1,$36(a2)

locret_E438:
		rts
; ---------------------------------------------------------------------------

off_E43A:	dc.w loc_E442-off_E43A, loc_E4A8-off_E43A, loc_E464-off_E43A, loc_E4A8-off_E43A
; ---------------------------------------------------------------------------

loc_E442:
		tst.w	$34(a0)
		bne.s	loc_E458
		cmpi.b	#1,$36(a0)
		bne.s	locret_E456
		move.w	#$1E,$34(a0)

locret_E456:
		rts
; ---------------------------------------------------------------------------

loc_E458:
		subq.w	#1,$34(a0)
		bne.s	locret_E456
		addq.b	#1,$28(a0)
		rts
; ---------------------------------------------------------------------------

loc_E464:
		tst.w	$34(a0)
		bne.s	loc_E478
		tst.b	$36(a0)
		bpl.s	locret_E476
		move.w	#$3C,$34(a0)

locret_E476:
		rts
; ---------------------------------------------------------------------------

loc_E478:
		subq.w	#1,$34(a0)
		bne.s	loc_E484
		addq.b	#1,$28(a0)
		rts
; ---------------------------------------------------------------------------

loc_E484:
		lea	$38(a0),a1
		move.w	$34(a0),d0
		lsr.b	#2,d0
		andi.b	#1,d0
		move.b	d0,(a1)+
		eori.b	#1,d0
		move.b	d0,(a1)+
		eori.b	#1,d0
		move.b	d0,(a1)+
		eori.b	#1,d0
		move.b	d0,(a1)+
		rts
; ---------------------------------------------------------------------------

loc_E4A8:
		lea	$38(a0),a1
		cmpi.b	#$80,(a1)
		beq.s	locret_E4D0
		addq.b	#1,(a1)
		moveq	#0,d1
		move.b	(a1)+,d1
		swap	d1
		lsr.l	#1,d1
		move.l	d1,d2
		lsr.l	#1,d1
		move.l	d1,d3
		add.l	d2,d3
		swap	d1
		swap	d2
		swap	d3
		move.b	d3,(a1)+
		move.b	d2,(a1)+
		move.b	d1,(a1)+

locret_E4D0:
		rts
; ---------------------------------------------------------------------------
		rts