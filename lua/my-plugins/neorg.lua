require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {
            config = {
                icon_preset = "diamond",
            } 
        },
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/",
                    home = "~/",
                }
            }
        },
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp"
            },
        },
        ["core.keybinds"] = {
            config = {
                default_keybinds = true,
            }
        },
    }
}
