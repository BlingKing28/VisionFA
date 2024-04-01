resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

ui_page "ui/index.html"

files {
	"ui/index.html",
	"ui/assets/clignotant-droite.svg",
	"ui/assets/clignotant-gauche.svg",
	"ui/assets/feu-position.svg",
	"ui/assets/feu-route.svg",
	"ui/assets/fuel.svg",
	"ui/assets/engine.svg",
	--"ui/fonts/fonts/Roboto-Bold.ttf",
	--"ui/fonts/fonts/Roboto-Regular.ttf",
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js"
}

client_scripts {
	"client.lua",
}

shared_script {
	'@SunWise/shared/shared_global.lua',
}