; ---------------------------------------------------------------------------
; Object 17 - helix of spikes on a pole	(GHZ)
; ---------------------------------------------------------------------------

ObjSpikeLogs:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Hel_Index(pc,d0.w),d1
		jmp	Hel_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Hel_Index:	dc.w Hel_Main-Hel_Index		; 0
		dc.w Hel_Action-Hel_Index	; 2
		dc.w Hel_Action-Hel_Index	; 4 (unused)
		dc.w Hel_Delete-Hel_Index	; 6 (unused)
		dc.w Hel_Display-Hel_Index	; 8

; hel_frame = objoff_3E		; start frame (different for each spike)

;		$29-38 are used for child object addresses
; ---------------------------------------------------------------------------

Hel_Main:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Hel,obMap(a0)
		move.w	#make_art_tile(ArtTile_GHZ_Spike_Pole,2,0),obGfx(a0)
		move.b	#7,obStatus(a0)
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#8,obActWid(a0)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		_move.b	obID(a0),d4
		lea	obSubtype(a0),a2
		moveq	#0,d1
		move.b	(a2),d1
		move.b	#0,(a2)+
		move.w	d1,d0
		lsr.w	#1,d0
		lsl.w	#4,d0
		sub.w	d0,d3
		subq.b	#2,d1
		bcs.s	Hel_Action
		moveq	#0,d6

loc_57E2:
	if FixBugs
		bsr.w	FindNextFreeObj
	else
		bsr.w	FindFreeObj
	endif
		bne.s	Hel_Action
		addq.b	#1,obSubtype(a0)
		move.w	a1,d5
		subi.w	#v_objspace,d5
		lsr.w	#object_size_bits,d5
		andi.w	#$7F,d5
		move.b	d5,(a2)+

		move.b	#8,obRoutine(a1)
		_move.b	d4,obID(a1)
		move.w	d2,obY(a1)
		move.w	d3,obX(a1)
		move.l	obMap(a0),obMap(a1)
		move.w	#make_art_tile(ArtTile_GHZ_Spike_Pole,2,0),obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#3,obPriority(a1)
		move.b	#8,obActWid(a1)
		move.b	d6,objoff_3E(a1)
		addq.b	#1,d6
		andi.b	#7,d6
		addi.w	#$10,d3
		cmp.w	obX(a0),d3
		bne.s	loc_5850
		move.b	d6,objoff_3E(a0)
		addq.b	#1,d6
		andi.b	#7,d6
		addi.w	#$10,d3
		addq.b	#1,obSubtype(a0)

loc_5850:
		dbf	d1,Hel_Build

Hel_Action:
		bsr.w	Hel_RotateSpikes
	if ~~FixBugs
		bsr.w	DisplaySprite
	endif
		bra.w	Hel_ChkDel
; ---------------------------------------------------------------------------

Hel_RotateSpikes:
		move.b	(v_ani0_frame).w,d0
		move.b	#0,obColType(a0)
		add.b	objoff_3E(a0),d0
		andi.b	#7,d0
		move.b	d0,obFrame(a0)
		bne.s	locret_587E
		move.b	#$84,obColType(a0)

locret_587E:
		rts
; ---------------------------------------------------------------------------

Hel_ChkDel:
		out_of_range.w	loc_58A0
	if FixBugs
		bra.w	DisplaySprite
	else
		rts
	endif
; ---------------------------------------------------------------------------

loc_58A0:
		moveq	#0,d2
		lea	obSubtype(a0),a2
		move.b	(a2)+,d2
		subq.b	#2,d2
		bcs.s	Hel_Delete

loc_58AC:
		moveq	#0,d0
		move.b	(a2)+,d0
		lsl.w	#object_size_bits,d0
		addi.l	#v_objspace&$FFFFFF,d0
		movea.l	d0,a1
		bsr.w	ObjectDeleteA1
		dbf	d2,loc_58AC

Hel_Delete:
		bsr.w	DeleteObject
		rts
; ---------------------------------------------------------------------------

Hel_Display:
		bsr.w	Hel_RotateSpikes
		bra.w	DisplaySprite