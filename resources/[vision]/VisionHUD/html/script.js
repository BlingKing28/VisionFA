window.addEventListener('message', function (event) {
    switch (event.data.action) {
        case 'updateStatusHud':
            $("body").css("display", event.data.show ? "block" : "none");
            $("#boxSetHealth").css("width", event.data.health + "%");
            $("#boxSetArmour").css("width", event.data.armour + "%");
            $("#boxSetOxygen").css("width", event.data.oxygen + "%");
            $(".barArmour").css("width", "100%");


            //widthHeightSplit(event.data.oxygen, $("#boxSetOxygen"));
            
            if (event.data.health <= 33) {
                $('#boxSetHealth').css('background', 'linear-gradient(180deg, rgba(224, 31, 31, 0.9) 0%, rgba(194, 26, 32, 0.9) 100%)')
                return;
            }
            if (event.data.health <= 66) {
                $('#boxSetHealth').css('background', 'linear-gradient(180deg, rgba(251, 188, 4, 0.9) 0%, rgba(248, 148, 39, 0.9) 100%)')
                return;
            }
            $('#boxSetHealth').css('background', 'linear-gradient(180deg, rgba(30, 180, 90, 0.729) 0%, rgba(49, 255, 68, 0.702) 100%)')
            if (event.data.armour <= 1) {
                $('#boxSetArmour').css('background', 'rgba(0, 0, 0, 0)')
                $('.barArmour').css('background', 'rgba(0, 0, 0, 0)')
                return;
            }
            $('#boxSetArmour').css('background', 'linear-gradient(180deg, rgba(19, 81, 117, 0.729) 0%, rgba(10, 121, 186, 0.702) 100%)')
            $('.barArmour').css('background', 'rgba(0, 0, 0, 0.4)')
            break;
        case 'updateAdminOverlay':
            updateAdminOverlay(event.data);
    }
});

function widthHeightSplit(value, ele) {
    let width = 25.0;
    let eleHeight = (value / 107) * width;

    ele.css("width", eleHeight + "px");
};

function Left(value, ele) {
    let height = 25.0;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("right", eleHeight + "px");
    ele.css("right", leftOverHeight + "px");
};

const grades = {
    1: {
        name: "Game Master",
        color: "#15803d"
    },
    2: {
        name: "Modérateur",
        color: "#C40155"
    },
    3: {
        name: "Support",
        color: "#d97706"
    },
    4: {
        name: "Développeur",
        color: "#3b82f6"
    },
    5: {
        name: "Staff",
        color: "#fb7185"
    },
}

const colors = [
    "#10b981",
    "#ca8a04",
    "#f97316",
    "#dc2626",
]

const getColor = (activeReports) => {
    if (activeReports >= 20) return colors[3];
    if (activeReports >= 10) return colors[2];
    if (activeReports >= 5) return colors[1];
    return colors[0];
}

const updateAdminOverlay = (data) => {
    const { show, activeReports } = data;

    document.querySelector(".AdminOverlay").style.display = show ? "flex" : "none";
    document.querySelector(".AdminOverlay>#activeReports>span").innerText = activeReports || 0;
    document.querySelector(".AdminOverlay>#activeReports>span").style.color = getColor(activeReports);

};