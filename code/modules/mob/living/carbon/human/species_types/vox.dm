/datum/species/vox
	// Base vox. Shouldn't be used. Look at the subspecies for the ones you should be using.
	name = "Vox Outcast"
	id = "vox"
	say_mod = "shrieks"
	species_traits = list(RESISTPRESSURE,RESISTHOT,RESISTCOLD, NOSCAN, NO_UNDERWEAR) // Robust, but cannot be cloned.
	damage_overlay_type = "vox"
	mutant_bodyparts = list("vox_quills", "vox_body_markings",  "vox_facial_quills", "vox_tail", "vox_body", "vox_eyes")
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	male_scream_sound = 'sound/voice/shriek1.ogg'
	female_scream_sound = 'sound/voice/shriek1.ogg'
	male_cough_sound = 'sound/voice/shriekcough.ogg'
	female_cough_sound = 'sound/voice/shriekcough.ogg'
	male_sneeze_sound = 'sound/voice/shrieksneeze.ogg'
	female_sneeze_sound = 'sound/voice/shrieksneeze.ogg'
	mutanttongue = /obj/item/organ/tongue/vox
	mutantlungs = /obj/item/organ/lungs/vox
	mutant_brain = /obj/item/organ/brain/cybernetic/vox
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/vox
	skinned_type = /obj/item/stack/sheet/animalhide/vox
	toxmod = 2 // Weak immune systems. Removing their masks completely skreks them.
	stunmod = 1.2 // Take a bit longer to get up than other species.
	breathid = "n2" // O2 is for dustlungs
	examine_text = "A vox outcast"

/datum/species/vox/on_species_gain(mob/living/carbon/C)
	. = ..()
	var/vox_body = C.dna.features["vox_body"]
	var/datum/sprite_accessory/vox_bodies/vox_body_of_choice = GLOB.vox_bodies_list[vox_body]
	C.dna.species.limbs_id = vox_body_of_choice.limbs_id
	var/vox_tail = C.dna.features["vox_tail"]
	var/datum/sprite_accessory/vox_tails/vox_tail_input = GLOB.vox_tails_list[vox_tail]
	vox_tail_input = vox_body_of_choice.limbs_id
	var/vox_eyes = C.dna.features["vox_eyes"]
	var/datum/sprite_accessory/vox_eyes/vox_eyes_input = GLOB.vox_eyes_list[vox_eyes]
	vox_eyes_input = vox_body_of_choice.eye_type


/datum/species/vox/after_equip_job(datum/job/J, mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/breath/vox(H), slot_wear_mask)
	H.put_in_l_hand(new /obj/item/tank/internals/emergency_oxygen/vox(H))
	to_chat(H, "<span class='notice'>You are now running on nitrogen internals from the emergency tank in your hand. Your species finds oxygen toxic, so you must breathe nitrogen only.</span>")
	H.internal = H.get_item_for_held_index(1)
	H.update_internals_hud_icon(1)