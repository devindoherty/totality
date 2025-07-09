-- Dialog lines for conversation interacts, keyword links by key

G_dialogs = { 
    -- NARRATOR
    ["narrator_root"] = {
        line = "You followed your parents' advice and took the starry pass into the midnight lands. \n\nBut in the darkness of the eternal eclipse, you stumbled and fell into darkness. You've awakened in an old farmhouse. \n\nPress ENTER to continue...",
        bye = true,
    },
    
    -- YARL
    ["yarl_root"] = {
        line = {"You're awake! Sit a while, if ya like. Took a nasty fall there. I'm ", GREEN, "Yarl, ", WHITE, "this is my ", GREEN, "farm", WHITE, "."},
    },
    ["yarl_yarl"] = {
        line = {"That's my name, don't wear it thin. Been living on this ", GREEN, "farm ", WHITE, "since ", GREEN, "sundown."}
    },
    ["yarl_sundown"] = {
        line = {"How long's it been since the ", GREEN, "eclipse ", WHITE, "going on a decade now?"}
    },
    ["yarl_eclipse"] = {
        line = {"You must've really hit your head in that ", GREEN ,"fall", WHITE, ". The eclipse darkened the sun some ten years ago, and never ended. Some say the ", GREEN, "gods ", WHITE, "cursed us. What for, I couldn't tell ya."}
    },
    ["yarl_gods"] = {
        line = {"I'm not a superstitious man, but finding you alive in that crater the same night as that ", GREEN , "comet", WHITE, "? Gives me pause."}
    },
    ["yarl_comet"] = {
        line = {"There was a shooting star same night I found you. Bright as, well, the sun. Lit up the whole ", GREEN, "farm", WHITE, "."}
    },
    ["yarl_farm"] = {
        line = {"My little homestead. Sometimes I miss the daylight crops, but niteberries taste good enough. If you want to try your hand at farm life, I gotta ", GREEN, "task ", WHITE, "for ya."}
    },
    ["yarl_fall"] = { 
        line= {"I wasn't so sure if ya were ever going to wake up or not. It's a miracle you didn't break anything, you must've fallen clear off the mountain. It's ", GREEN, "dangerous ", WHITE, "enough out there without a splinted leg."}
    },
    ["yarl_dangerous"] = {
        line = {"Aye, the eclipsed lands aren't all smiles and rainbows. Since the ", GREEN, "eclipse", WHITE, ", dark things have crawled into the fields and forests."}
    },
    ["yarl_task"] = {
        line = {"While I was out tending to your wounds, a bunch of ", GREEN, "rats ", WHITE, "snuck into my larder. If you could ask em to ", GREEN, "leave, ", WHITE, "I'd ", GREEN, "pay ", WHITE, "you for your trouble."}
    },
    ["yarl_rats"] = {
        line = {"Nasty vermin. Don't let 'em give you mouth. Just make them ", GREEN, "leave", WHITE, "."}
    },
    ["yarl_leave"] = {
        line = {"I don't care where they go, as long as it ain't here. You can be ", GREEN, "nice ", WHITE, "or ", GREEN, "mean ", WHITE, "about it."}
    },
    ["yarl_nice"] = {
        line = {"Don't figure rats much for diplomacy, but I've seen stranger things yet."}
    },
    ["yarl_mean"] = {
        line = {"You look like you can fight."}
    },
    ["yarl_pay"] = {
        line = {"How about 100 lunes?"}
    },
    ["yarl_reward"] = {
        prerequisite = "rats_dead" or "rats_moved",
        line = "I don't care how you did it, but those rats are gone. Good work. Here's 100 lunes.",
        on_current = function(map, player) player:give_coins(100) end
    },
    ["rat_root"] = {
        line={"SQUEEEK!"}
    },

    -- BOSS RAT
    ["boss_rat_root"] = {
        line = "Listen, pal, if yous got a problem with me an' my boys squatting and squeaking here, then I got a proposition for yous."
    },
}