; ---------------------------------------------------------------------------
; Object 1E - Ball Hog enemy
; ---------------------------------------------------------------------------

ObjBallhog:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Hog_Index(pc,d0.w),d1
		jmp	Hog_Index(pc,d1.w)
; ===========================================================================
Hog_Index:	dc.w Hog_Main-Hog_Index
		dc.w Hog_Action-Hog_Index
hog_timer =	 objoff_30	; time to idle around from left to right
hog_launchflag = objoff_32	; 0 to launch a cannonball
; ===========================================================================

Hog_Main:	; Routine 0
		move.l	#Map_BallHog,obMap(a0)
		move.w	#make_art_tile(ArtTile_Ball_Hog,1,0),obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#5,obColType(a0)
		move.b	#$C,obActWid(a0)
		move.b	#$13,obHeight(a0)
		move.b	#8,obWidth(a0)
		bsr.w	ObjectMoveAndFall
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	.floornotfound
		add.w	d1,obY(a0)
		clr.w	obVelY(a0)
		addq.b	#2,obRoutine(a0)

.floornotfound:
		rts
; ---------------------------------------------------------------------------

Hog_Action:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	.action_index(pc,d0.w),d1
		jsr	.action_index(pc,d1.w)
		lea	(Ani_Hog).l,a1
		bsr.w	AnimateSprite
		bra.w	MarkObjGone
; ===========================================================================
.action_index:	dc.w Hog_Idle-.action_index
		dc.w Hog_Move-.action_index
; ===========================================================================

Hog_Idle:
		subq.w	#1,hog_timer(a0)
		bpl.s	.fire
		addq.b	#2,ob2ndRout(a0)
		move.w	#256-1,hog_timer(a0)
		move.w	#$40,obVelX(a0)
		move.b	#1,obAnim(a0)
		bchg	#0,obStatus(a0)
		bne.s	.noflip
		neg.w	obVelX(a0)
.noflip:
		sf	hog_launchflag(a0)
		rts
; ---------------------------------------------------------------------------

.fire:
		cmpi.b	#2,obFrame(a0)
		bne.s	.abort
		tst.b	hog_launchflag(a0)
		bne.s	.abort
		st	hog_launchflag(a0)
		bsr.w	FindFreeObj
		bne.s	.abort	; if ObjectRam is full, we bail!
		_move.b	#id_Cannonball,obID(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		addi.w	#$10,obY(a1)

.abort:		;.fail in the final
		bra.w	MarkObjGone
; ---------------------------------------------------------------------------

Hog_Move:
		subq.w	#1,hog_timer(a0)
		bmi.s	loc_7032
		bsr.w	ObjectMove
		jsr	(ObjHitFloor).l
		add.w	d1,obY(a0)
		rts
; ---------------------------------------------------------------------------

loc_7032:
		subq.b	#2,ob2ndRout(a0)
		move.w	#60-1,hog_timer(a0)
		clr.w	obVelX(a0)
		sf	obAnim(a0)
		tst.b	obRender(a0)
		bpl.s	.return
		move.b	#2,obAnim(a0)

.return:
		rts