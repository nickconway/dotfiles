hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,

        border_size = 1,
        resize_on_border = true,

        col = {
            active_border = { colors = { Color2 or "#ffffff99", Color3 or "#ffffff44" }, angle = 45 },
            inactive_border = "0x00000000",
        },

        allow_tearing = true,
        layout = "dwindle",
    },

    cursor = {
        inactive_timeout = 5,
        zoom_detached_camera = true,
        no_hardware_cursors = true,
        enable_hyprcursor = true,
        sync_gsettings_theme = true,
    },

    render = {
        cm_auto_hdr = true,
    },

    opengl = {
        nvidia_anti_flicker = true,
    },

    decoration = {
        rounding = 10,
        -- screen_shader = os.getenv("HOME") .. "/.config/hypr/shaders/chromatic.frag",

        active_opacity = 1,
        inactive_opacity = 0.9,

        shadow = {
            enabled = false,
            range = 20,
            render_power = 3,
            color = Color0Alpha,
        },

        blur = {
            enabled = true,
            size = 8,
            passes = 4,
            ignore_opacity = true,
        },

        dim_special = 0,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.98,
        focus_fit_method = 0,
        direction = "right",
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        enable_swallow = true,
        swallow_regex = "^(kitty)$",
    },

    input = {
        kb_layout = "us",
        kb_variant = nil,
        kb_model = nil,
        kb_options = nil,
        kb_rules = nil,

        follow_mouse = 1,

        sensitivity = 0,
        accel_profile = "flat",

        touchpad = {
            natural_scroll = true,
        },

        float_switch_override_focus = 2,
    },

    debug = {
        disable_logs = false,
    },
})
