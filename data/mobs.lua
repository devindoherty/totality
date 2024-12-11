G_mobs = {
    ["yarl"] = {
        name = "Yarl",
        sprite = 128,
        description = "A tired old farmer whose friendly face still bears the bronzed blessing of the long-gone sun.",
        behavior = "friendly", 
        stats = {
            ["health"] = 100,
        },
        dialog = Dialog:new("yarl_")
    },
    ["rat"] = {
        name = "Rat",
        sprite = 416,
        hostile = true,
        description = "An enormous, black furred rat with uncannily intelligent pink eyes.",   
        behavior = "aggressive",
        stats = {
            ["health"] = 50,
        }
    },
    ["boss_rat"] = {
        name = "Boss Rat",
        sprite = 416,
        description = "This man sized rat smokes a cigar inbetween bites of expensive imported cheese.",
        stats = {
            ["health"] = 25,
        },
        dialog = Dialog:new("boss_rat_")
    },
    ["croc"] = {
        name = "Croc",
        sprite = 414,
        description = "An ancient land lizard. It's maw is filled with thousands of tiny, knife-like teeth. It looks hungry.",
        stats = {
            ["health"] = 30
        }
    }
}