/obj/effect/decal/cleanable/blood
	name = "blood"
	desc = "It's gooey. Perhaps it's the chef's cooking?"
	icon = 'icons/effects/blood.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")
	blood_DNA = list()
	blood_state = BLOOD_STATE_HUMAN
	bloodiness = MAX_SHOE_BLOODINESS
	use_fade = FALSE

/obj/effect/cleanable/blood/Initialize()
	. = ..()
	update_icon()

/obj/effect/decal/cleanable/blood/replace_decal(obj/effect/decal/cleanable/blood/C)
	if (C.blood_DNA)
		blood_DNA |= C.blood_DNA.Copy()
	update_icon()
	..()

/obj/effect/decal/cleanable/blood/transfer_blood_dna()
	..()
	update_icon()

/obj/effect/decal/cleanable/blood/transfer_mob_blood_dna()
	. = ..()
	update_icon()

/obj/effect/decal/cleanable/blood/update_icon()
	color = blood_DNA_to_color()

/obj/effect/decal/cleanable/blood/old
	name = "dried blood"
	desc = "Looks like it's been here a while. Eew."
	bloodiness = 0

/obj/effect/decal/cleanable/blood/old/Initialize()
	. = ..()
	icon_state += "-old" //This IS necessary because the parent /blood type uses icon randomization.
	add_blood(list(blood_DNA["Non-human DNA"] = "A+"))

/obj/effect/decal/cleanable/blood/splatter
	random_icon_states = list("gibbl1", "gibbl2", "gibbl3", "gibbl4", "gibbl5")

/obj/effect/decal/cleanable/blood/tracks
	icon_state = "tracks"
	desc = "They look like tracks left by wheels."
	random_icon_states = null

/obj/effect/decal/cleanable/trail_holder //not a child of blood on purpose
	name = "blood"
	icon_state = "ltrails_1"
	desc = "Your instincts say you shouldn't be following these."
	random_icon_states = null
	var/list/existing_dirs = list()
	blood_DNA = list()
	use_fade = FALSE

/obj/effect/decal/cleanable/trail_holder/update_icon()
	color = blood_DNA_to_color()

/obj/effect/cleanable/trail_holder/Initialize()
	. = ..()
	update_icon()

/obj/effect/decal/cleanable/trail_holder/can_bloodcrawl_in()
	return 1

/obj/effect/decal/cleanable/trail_holder/transfer_blood_dna()
	..()
	update_icon()

/obj/effect/decal/cleanable/trail_holder/transfer_mob_blood_dna()
	. = ..()
	update_icon()


/obj/effect/decal/cleanable/blood/gibs
	name = "gibs"
	desc = "They look bloody and gruesome."
	icon = 'icons/effects/blood.dmi'
	icon_state = "gibbl5"
	layer = LOW_OBJ_LAYER
	random_icon_states = list("gib1", "gib2", "gib3", "gib4", "gib5", "gib6")
	mergeable_decal = 0
	var/gib_overlay = FALSE

/obj/effect/decal/cleanable/blood/gibs/Initialize()
	. = ..()
	if(gib_overlay)
		var/icon/gibz = new(icon, icon_state + "-overlay")
		add_overlay(gibz)

/obj/effect/decal/cleanable/blood/gibs/Initialize()
	. = ..()
	reagents.add_reagent("liquidgibs", 5)

/obj/effect/decal/cleanable/blood/gibs/ex_act(severity, target)
	return

/obj/effect/decal/cleanable/blood/gibs/proc/streak(list/directions)
	set waitfor = 0
	var/direction = pick(directions)
	for(var/i = 0, i < pick(1, 200; 2, 150; 3, 50), i++)
		sleep(2)
		if(i > 0)
			var/obj/effect/decal/cleanable/blood/splatter/splat = new(loc)
			splat.transfer_blood_dna(blood_DNA)
		if(!step_to(src, get_step(src, direction), 0))
			break

/obj/effect/decal/cleanable/blood/gibs/up
	random_icon_states = list("gib1", "gib2", "gib3", "gib4", "gib5", "gib6","gibup1","gibup1","gibup1")
	gib_overlay = TRUE

/obj/effect/decal/cleanable/blood/gibs/down
	random_icon_states = list("gib1", "gib2", "gib3", "gib4", "gib5", "gib6","gibdown1","gibdown1","gibdown1")
	gib_overlay = TRUE

/obj/effect/decal/cleanable/blood/gibs/body
	random_icon_states = list("gibhead", "gibtorso")
	gib_overlay = TRUE

/obj/effect/decal/cleanable/blood/gibs/torso
	random_icon_states = list("gibtorso")
	gib_overlay = TRUE

/obj/effect/decal/cleanable/blood/gibs/limb
	random_icon_states = list("gibleg", "gibarm")
	gib_overlay = TRUE

/obj/effect/decal/cleanable/blood/gibs/core
	random_icon_states = list("gibmid1", "gibmid2", "gibmid3")
	gib_overlay = TRUE

/obj/effect/decal/cleanable/blood/gibs/old
	name = "old rotting gibs"
	desc = "Space Jesus, why didn't anyone clean this up?  It smells terrible."
	bloodiness = 0

/obj/effect/decal/cleanable/blood/gibs/old/Initialize()
	. = ..()
	setDir(pick(1,2,4,8))
	icon_state += "-old"
	add_blood(list(blood_DNA["Non-human DNA"] = "A+"))

/obj/effect/decal/cleanable/blood/drip
	name = "drips of blood"
	desc = "It's sticky."
	icon_state = "1"
	random_icon_states = list("drip1","drip2","drip3","drip4","drip5")
	bloodiness = 0
	var/drips = 1

/obj/effect/decal/cleanable/blood/drip/can_bloodcrawl_in()
	return 1


//BLOODY FOOTPRINTS
/obj/effect/decal/cleanable/blood/footprints
	name = "footprints"
	icon = 'icons/effects/footprints.dmi'
	icon_state = "nothingwhatsoever"
	desc = "WHOSE FOOTPRINTS ARE THESE?"
	random_icon_states = null
	var/entered_dirs = 0
	var/exited_dirs = 0
	blood_state = BLOOD_STATE_HUMAN //the icon state to load images from
	var/list/shoe_types = list()

/obj/effect/decal/cleanable/blood/footprints/Crossed(atom/movable/O)
	if(ishuman(O))
		var/mob/living/carbon/human/H = O
		var/obj/item/clothing/shoes/S = H.shoes
		if(S && S.bloody_shoes[blood_state])
			if(color != bloodtype_to_color(S.last_bloodtype))
				return
			S.bloody_shoes[blood_state] = max(S.bloody_shoes[blood_state] - BLOOD_LOSS_PER_STEP, 0)
			shoe_types |= S.type
			if (!(entered_dirs & H.dir))
				entered_dirs |= H.dir
				update_icon()

/obj/effect/decal/cleanable/blood/footprints/Uncrossed(atom/movable/O)
	if(ishuman(O))
		var/mob/living/carbon/human/H = O
		var/obj/item/clothing/shoes/S = H.shoes
		if(S && S.bloody_shoes[blood_state])
			if(color != bloodtype_to_color(S.last_bloodtype))//last entry - we check its color
				return
			S.bloody_shoes[blood_state] = max(S.bloody_shoes[blood_state] - BLOOD_LOSS_PER_STEP, 0)
			shoe_types  |= S.type
			if (!(exited_dirs & H.dir))
				exited_dirs |= H.dir
				update_icon()

/obj/effect/decal/cleanable/blood/footprints/update_icon()
	..()
	cut_overlays()

	for(var/Ddir in GLOB.cardinals)
		if(entered_dirs & Ddir)
			var/image/bloodstep_overlay = GLOB.bloody_footprints_cache["entered-[blood_state]-[Ddir]"]
			if(!bloodstep_overlay)
				GLOB.bloody_footprints_cache["entered-[blood_state]-[Ddir]"] = bloodstep_overlay = image(icon, "[blood_state]1", dir = Ddir)
			add_overlay(bloodstep_overlay)
		if(exited_dirs & Ddir)
			var/image/bloodstep_overlay = GLOB.bloody_footprints_cache["exited-[blood_state]-[Ddir]"]
			if(!bloodstep_overlay)
				GLOB.bloody_footprints_cache["exited-[blood_state]-[Ddir]"] = bloodstep_overlay = image(icon, "[blood_state]2", dir = Ddir)
			add_overlay(bloodstep_overlay)

	alpha = BLOODY_FOOTPRINT_BASE_ALPHA + bloodiness


/obj/effect/decal/cleanable/blood/footprints/examine(mob/user)
	. = ..()
	if(shoe_types.len)
		. += "You recognise the footprints as belonging to:\n"
		for(var/shoe in shoe_types)
			var/obj/item/clothing/shoes/S = shoe
			. += "some <B>[initial(S.name)]</B> [icon2html(initial(S.icon), user)]\n"

	to_chat(user, .)

/obj/effect/decal/cleanable/blood/footprints/replace_decal(obj/effect/decal/cleanable/C)
	if(blood_state != C.blood_state) //We only replace footprints of the same type as us
		return
	if(color != C.color)
		return
	..()

/obj/effect/decal/cleanable/blood/footprints/can_bloodcrawl_in()
	if((blood_state != BLOOD_STATE_OIL) && (blood_state != BLOOD_STATE_NOT_BLOODY))
		return 1
	return 0
