//stolen_from_internet_oddities_pending_removal
var noteName_dad:FunkinText = new FunkinText(145, 687, 0, 'default', 15, false);
var noteName:FunkinText = new FunkinText(145, 687, 0, 'default', 15, false);

function create(){
    switch(PlayState.SONG.meta.displayName){
        case 'ron'|'Wasted'|'ayo'|'Bloodshed'|'trojan-virus'|'ron-classic'|'wasted-classic'|'Ayo-classic'|
        'trojan-virus-classic'|'gron'|'Bijuu'|'lights-down-remix'|'certified-champion'|'rong-aisle'|
        'cluster-funk'|'oh-my-god-hes-ballin'|'awesome-ron': noteName_dad.text = 'RON_NOTES';
        case 'Bloodshed-classic'|'Bleeding-classic'|'Bleeding': noteName_dad.text = 'ronhell';
        case 'Bloodbath'|'Bloodshed-legacy-redux': noteName_dad.text = 'demon';
        case 'difficult-powers':{
            noteName_dad.text = 'NOTEold_assets';
            noteName.text = 'demon';
        }
        case 'holy-shit-dave-fnf':{
            noteName_dad.text = 'NOTEold_assets';
            noteName.text = 'NOTEold_assets';
        }
        case 'slammed':{
            noteName_dad.text = 'NOTEold_assets';
            noteName.text = 'RON_NOTES';
        }
        case 'ron-dsides': noteName_dad.text = 'conall';
        case 'official-debate': noteName.text = 'RON_NOTES';
    }
}

function onNoteCreation(e) {if (e.strumLineID == 0) e.noteSprite = "game/notes/" + noteName_dad.text;
if (e.strumLineID == 1) e.noteSprite = "game/notes/" + noteName.text;
}

function onStrumCreation(e) {if (e.player == 0) e.sprite = "game/notes/" + noteName_dad.text;
if (e.player == 1) e.sprite = "game/notes/" + noteName.text;
}