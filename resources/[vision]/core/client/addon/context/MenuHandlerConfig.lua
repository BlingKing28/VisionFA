local menuForJob = {
	["lspd"] = {
		veh = {
			{ icon = "car", label = "Crocheter", action = "HookVehicleLSPD" }, -- TODO
			{ icon = "search", label = "Inspecter", action = "InfoVehLSPD" },
			{ icon = "plate", label = "Relever l'immatriculation", action = "GetVehiclePlate" }, -- good
			{ icon = "fourriere", label = "Mettre en fourrière", action = "SetVehicleInFourriere" },
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
		ped = {
			{ icon = "CROIX", label = "Vérifier l'identité", action = "getPatientIdentityCard" }, -- good
			{ icon = "Fouiller", label = "Fouiller", action = "StartSearchOnPlayer" }, -- good
			{ icon = "handcuff", label = "Menotter/Démenotter", action = "CuffPlayer" }, -- good
			{ icon = "mettre_voiture", label = "Sortir/Mettre dans le véhicule", action = "PlacePlayerIntoVehicle" }, -- good
			{ icon = "Carte", label = "Gérer les permis", action = "PermisPolice" }, -- TODO
			--{ icon = "Facture", label = "Faire une facture", action = "MakeBillingPolice" }, -- TODO
			{ icon = "move", label = "Déplacer", action = "MoovePlayerCuffed" }, -- good
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		}
	},
	["bp"] = {
		veh = {
			{ icon = "car", label = "Crocheter", action = "HookVehicleLSPD" }, -- TODO
			{ icon = "search", label = "Inspecter", action = "InfoVehLSPD" },
			{ icon = "plate", label = "Relever l'immatriculation", action = "GetVehiclePlate" }, -- good
			{ icon = "fourriere", label = "Mettre en fourrière", action = "SetVehicleInFourriere" },
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
		ped = {
			{ icon = "CROIX", label = "Vérifier l'identité", action = "getPatientIdentityCard" }, -- good
			{ icon = "Fouiller", label = "Fouiller", action = "StartSearchOnPlayer" }, -- good
			{ icon = "handcuff", label = "Menotter/Démenotter", action = "CuffPlayer" }, -- good
			{ icon = "mettre_voiture", label = "Sortir/Mettre dans le véhicule", action = "PlacePlayerIntoVehicle" }, -- good
			{ icon = "Carte", label = "Gérer les permis", action = "PermisPolice" }, -- TODO
			{ icon = "Facture", label = "Faire une facture", action = "MakeBillingPolice" }, -- TODO
			{ icon = "move", label = "Déplacer", action = "MoovePlayerCuffed" }, -- good
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		}
	},
	["lssd"] = {
		veh = {
			{ icon = "car", label = "Crocheter", action = "HookVehicleLSPD" }, -- TODO
			{ icon = "search", label = "Inspecter", action = "InfoVehLSPD" },
			{ icon = "plate", label = "Relever l'immatriculation", action = "GetVehiclePlate" }, -- good
			{ icon = "fourriere", label = "Mettre en fourrière", action = "SetVehicleInFourriere" },
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
		ped = {
			{ icon = "CROIX", label = "Vérifier l'identité", action = "getPatientIdentityCard" }, -- good
			{ icon = "Fouiller", label = "Fouiller", action = "StartSearchOnPlayer" }, -- good
			{ icon = "handcuff", label = "Menotter/Démenotter", action = "CuffPlayer" }, -- good
			{ icon = "mettre_voiture", label = "Sortir/Mettre dans le véhicule", action = "PlacePlayerIntoVehicle" }, -- good
			{ icon = "Carte", label = "Gérer les permis", action = "PermisPolice" }, -- TODO
			{ icon = "Facture", label = "Faire une facture", action = "MakeBillingPolice" }, -- TODO
			{ icon = "move", label = "Déplacer", action = "MoovePlayerCuffed" }, -- good
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		}
	},
	["usss"] = {
		veh = {
			{ icon = "car", label = "Crocheter", action = "HookVehicleLSPD" }, -- TODO
			{ icon = "search", label = "Inspecter", action = "InfoVehLSPD" },
			{ icon = "plate", label = "Relever l'immatriculation", action = "GetVehiclePlate" }, -- good
			{ icon = "fourriere", label = "Mettre en fourrière", action = "SetVehicleInFourriere" },
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
		ped = {
			{ icon = "CROIX", label = "Vérifier l'identité", action = "getPatientIdentityCard" }, -- good
			{ icon = "Fouiller", label = "Fouiller", action = "StartSearchOnPlayer" }, -- good
			{ icon = "handcuff", label = "Menotter/Démenotter", action = "CuffPlayer" }, -- good
			{ icon = "mettre_voiture", label = "Sortir/Mettre dans le véhicule", action = "PlacePlayerIntoVehicle" }, -- good
			{ icon = "Carte", label = "Gérer les permis", action = "PermisPolice" }, -- TODO
			{ icon = "Facture", label = "Faire une facture", action = "MakeBillingPolice" }, -- TODO
			{ icon = "move", label = "Déplacer", action = "MoovePlayerCuffed" }, -- good
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		}
	},
	["boi"] = {
		ped = {
			{ icon = "CROIX", label = "Vérifier l'identité", action = "getPatientIdentityCard" },
			{ icon = "Facture", label = "Donner une facture", action = "Factureboi" },
			{ icon = "Fouiller", label = "Fouiller", action = "StartSearchOnPlayer" },
			{ icon = "handcuff", label = "Menotter/Démenotter", action = "CuffPlayer" },
			{ icon = "mettre_voiture", label = "Sortir/Mettre dans le véhicule", action = "PlacePlayerIntoVehicle" },
			{ icon = "move", label = "Déplacer", action = "MoovePlayerCuffed" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good
		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
			{ icon = "plate", label = "Relever l'immatriculation", action = "GetVehiclePlate" }, -- good
			{ icon = "search", label = "Inspecter", action = "InfoVehLSPD" },
		},
	},
	["lsfd"] = {
		veh = {
			{ icon = "car", label = "Crocheter", action = "HookVehicleLSPD" }, -- TODO
			{ icon = "search", label = "Inspecter", action = "InfoVehLSPD" },
			{ icon = "plate", label = "Relever l'immatriculation", action = "GetVehiclePlate" }, -- good
			{ icon = "fourriere", label = "Mettre en fourrière", action = "SetVehicleInFourriere" },
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
		ped = {
			{ icon = "carteidentiteblanc", label = "Vérifier l'identité", action = "getPatientIdentityCard" }, -- TODO
			{ icon = "Soigner", label = "Soigner", action = "HealthPatient" }, -- TODO
			{ icon = "coeurblanc", label = "Réanimer", action = "revivePatient" }, -- TODO
			{ icon = "Facture", label = "Facture", action = "FactureEms" }, -- TODO
			{ icon = "Fouiller", label = "Fouiller", action = "StartSearchOnPlayer" }, -- good
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		}
	},
	["ems"] = {
		ped = { 
			{ icon = "carteidentiteblanc", label = "Vérifier l'identité", action = "getPatientIdentityCard" }, -- TODO
			{ icon = "Soigner", label = "Soigner", action = "HealthPatient" }, -- TODO
			{ icon = "coeurblanc", label = "Réanimer", action = "revivePatient" }, -- TODO
			{ icon = "Facture", label = "Facture", action = "FactureEms" }, -- TODO
			{ icon = "Fouiller", label = "Fouiller", action = "StartSearchOnPlayer" }, -- good
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["bcms"] = {
		ped = { 
			{ icon = "carteidentiteblanc", label = "Vérifier l'identité", action = "getPatientIdentityCard" }, -- TODO
			{ icon = "Soigner", label = "Soigner", action = "HealthPatient" }, -- TODO
			{ icon = "coeurblanc", label = "Réanimer", action = "revivePatient" }, -- TODO
			{ icon = "Facture", label = "Facture", action = "FactureEms" }, -- TODO
			{ icon = "Fouiller", label = "Fouiller", action = "StartSearchOnPlayer" }, -- good
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["cardealerSud"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "concessFacture" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good
		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
			{ icon = "info_veh", label = "Information véhicule", action = "showPlate" }, -- good
		},
	},
	["cardealerNord"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "concessNordFacture" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good
		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
			{ icon = "info_veh", label = "Information véhicule", action = "showPlate" }, -- good
		},
	},
	["autoecole"] = {
		ped = { { icon = "Facture", label = "Donner une facture", action = "FactureAutoEcole" }, -- TODO
			{ icon = "Carte", label = "Attribuer le permis", action = "GivePermis" }, -- TODO
			{ icon = "Carte", label = "Attribuer le permis moto", action = "GivePermisMoto" }, -- TODO
			{ icon = "Carte", label = "Attribuer le permis camion", action = "GivePermisCamion" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["bennys"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "FactureMechano" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "info_veh", label = "Information véhicule", action = "InfoVeh" }, -- good
			{ icon = "car", label = "Crocheter", action = "HookVehicleLSPD" }, -- TODO
			{ icon = "fourriere", label = "Mettre véhicule en fourrière", action = "SetVehicleInFourriere" }, -- TODO
			{ icon = "car", label = "Ouvrir les customs du véhicule", action = "OpenCustomVehMenu" }, -- TODO
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["hayes"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "FactureMechano" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "info_veh", label = "Information véhicule", action = "InfoVeh" }, -- good
			{ icon = "car", label = "Crocheter", action = "HookVehicleLSPD" }, -- TODO
			{ icon = "fourriere", label = "Mettre véhicule en fourrière", action = "SetVehicleInFourriere" }, -- TODO
			{ icon = "car", label = "Ouvrir les customs du véhicule", action = "OpenCustomVehMenu" }, -- TODO
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["beekers"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "FactureMechano" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "info_veh", label = "Information véhicule", action = "InfoVeh" }, -- good
			{ icon = "car", label = "Crocheter", action = "HookVehicleLSPD" }, -- TODO
			{ icon = "fourriere", label = "Mettre véhicule en fourrière", action = "SetVehicleInFourriere" }, -- TODO
			{ icon = "car", label = "Ouvrir les customs du véhicule", action = "OpenCustomVehMenu" }, -- TODO
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["sunshine"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "FactureMechano" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "info_veh", label = "Information véhicule", action = "InfoVeh" }, -- good
			{ icon = "car", label = "Crocheter", action = "HookVehicleLSPD" }, -- TODO
			{ icon = "fourriere", label = "Mettre le véhicule en fourrière", action = "SetVehicleInFourriere" }, -- TODO
			{ icon = "car", label = "Ouvrir les customs du véhicule", action = "OpenCustomVehMenu" }, -- TODO
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["harmony"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "FactureMechano" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "info_veh", label = "Information véhicule", action = "InfoVeh" }, -- good
			{ icon = "car", label = "Crocheter", action = "HookVehicleLSPD" }, -- TODO
			{ icon = "fourriere", label = "Mettre le véhicule en fourrière", action = "SetVehicleInFourriere" }, -- TODO
			{ icon = "car", label = "Ouvrir les customs du véhicule", action = "OpenCustomVehMenu" }, -- TODO
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["bahamas"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "bahamasFacture" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["burgershot"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "burgerFacture" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["tacosrancho"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "tacosFacture" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},

	["ltdsud"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "ltdsudFacture" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},

	["ltdmirror"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "ltdMirrorFacture" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["sushistar"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "ShushiStarFacture" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["mayansclub"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "MayansFacture" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["lucky"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "luckyFacture" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["athena"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "AthenaFacture" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["mostwanted"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "MostWantedFacture" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
			{ icon = "info_veh", label = "Information véhicule", action = "InfoVeh" }, -- good
		},
	},
	["unicorn"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "UnicornFacture" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},

	["weazelnews"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "FactureWeazelNews" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["realestateagent"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "FactureAgentImmo" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["justice"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "FactureJustice" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["pawnshop"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "FacturePawnShop" }, -- TODO
			{ icon = "Facture", label = "Envoyé de l'argent", action = "SendMoneyPawnShop" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "info_veh", label = "Changer le propriétaire", action = "ChangePropertyCar" }, -- TODO
			{ icon = "info_veh", label = "Changer le propriétaire (Crew)", action = "ChangePropertyCarCrew" }, -- TODO
			{ icon = "info_veh", label = "Ajouter un co-propriétaire", action = "AddCoOwnerCar" }, -- TODO
			{ icon = "info_veh", label = "Acheter le véhicule (entreprise)", action = "ChangePropertyCarJOb" }, -- TODO
			{ icon = "info_veh", label = "Information véhicule", action = "InfoVehPawnshop" }, -- good
			{ icon = "plate", label = "Relever l'immatriculation", action = "GetVehiclePlatePawnshop" }, -- good
			{ icon = "car", label = "Crocheter", action = "HookVehiclePawnshop" }, -- TODO
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			--{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			--{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["casse"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "FactureCasse" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good
		},
		veh = {
			{ icon = "plate", label = "Relever l'immatriculation", action = "GetVehiclePlate" },
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["tequilala"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "TequilalaFacture" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["uwu"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "UWUFacture" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good
		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["pizzeria"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "Facture" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good
		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["pearl"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "Facture" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good
		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["upnatom"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "Facture" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good
		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["hornys"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "Facture" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good
		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["tattooSud"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "FactureTattoo" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" },
		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["tattooNord"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "FactureTattoo" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" },
		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["comrades"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "ComradesFacture" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["sultan"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "sultanFacture" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["mirror"] = {
		ped = {
			{ icon = "Facture", label = "Donner une facture", action = "MirrorFacture" }, -- TODO
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good

		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
		},
	},
	["g6"] = {
		ped = {
			{ icon = "CROIX", label = "Vérifier l'identité", action = "getPatientIdentityCard" },
			{ icon = "Facture", label = "Donner une facture", action = "FactureG6" },
			{ icon = "Fouiller", label = "Fouiller", action = "StartSearchOnPlayer" },
			{ icon = "handcuff", label = "Menotter/Démenotter", action = "CuffPlayer" },
			{ icon = "mettre_voiture", label = "Sortir/Mettre dans le véhicule", action = "PlacePlayerIntoVehicleForG6" },
			{ icon = "Carte", label = "Gérer les permis", action = "PermisPolice" }, -- TODO
			{ icon = "move", label = "Déplacer", action = "MoovePlayerCuffed" },
			{ icon = "move", label = "Suivant", action = "contextMenuPage2" }, -- good
		},
		veh = {
			{ icon = "car", label = "Rentrer dans le coffre", action = "putInTrunk" },
			{ icon = "car", label = "Ouvrir le capot", action = "openHood" },
			{ icon = "car", label = "Ouvrir le coffre", action = "openTrunk" },
			{ icon = "car", label = "Verouiller / Déverouiller", action = "useKey" },
			{ icon = "plate", label = "Relever l'immatriculation", action = "GetVehiclePlate" }, -- good
			{ icon = "search", label = "Inspecter", action = "InfoVehLSPD" },
		},
	},
}


function GetContextVehActionByJob(job)
	if menuForJob[job] ~= nil then
		return menuForJob[job].veh
	else
		return {}
	end
end

function GetContextPedActionByJob(job)
	if menuForJob[job] ~= nil then
		return menuForJob[job].ped
	else
		return {}
	end
end
