/obj/item/reagent_containers/plastic
	icon = 'icons/obj/chemical.dmi'
	materials = list()
	flags_1 = OPENCONTAINER_1

/obj/item/reagent_containers/plastic/jug
	name = "plastic jug"
	desc = "A plastic jug. It can hold up to 100 units."
	volume = 100
	icon_state = "smalljug"
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100)

/obj/item/reagent_containers/plastic/jug/large
	name = "large plastic jug"
	desc = "A large plastic jug. It can hold up to 150 units."
	volume = 150
	icon_state = "largejug"
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100,150)

/obj/item/reagent_containers/plastic/jug/large/cleaner
	name = "space cleaner jug"
	icon_state = "largejug-labelled"
	list_reagents = list("cleaner" = 150)

/obj/item/reagent_containers/metal
	icon = 'icons/obj/chemical.dmi'
	materials = list()
	flags_1 = OPENCONTAINER_1

/obj/item/reagent_containers/metal/can
	name = "metal can"
	desc = "A metal can. It can hold up to 100 units."
	volume = 100
	icon_state = "liquidcan"
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100)

/obj/item/reagent_containers/metal/can/acetone
	name = "acetone can"
	desc = "An acetone can. It can hold up to 100 units."
	list_reagents = list("acetone" = 100)

/obj/item/reagent_containers/metal/can/oil
	name = "oil can"
	desc = "An oil can. It can hold up to 100 units."
	list_reagents = list("oil" = 100)
