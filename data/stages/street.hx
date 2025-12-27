function postCreate() {
	skywasted.visible = false;
	citywasted.visible = false;
	mountainswasted.visible = false;
    hillfrontwasted.visible = false;
	streetwasted.visible = false;
}
function stepHit(step) {
    switch (step) {
    case 1304:
        sky.destroy();
        bigcloud.destroy();
        backcity.destroy();
        city.destroy();
        backmountain.destroy();
        mountain.destroy();
        hill.destroy();
        street.destroy();

        skywasted.visible = true;
        citywasted.visible = true;
        mountainswasted.visible = true;
        hillfrontwasted.visible = true;
        streetwasted.visible = true;
    }
}
        