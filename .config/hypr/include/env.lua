hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_STYLE_OVERRIDE", "kvantum")

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

hl.env("PATH", os.getenv("HOME") .. "/.local/bin:" .. os.getenv("HOME") .. "/.cargo/bin:" .. os.getenv("PATH"))

hl.env("TESSDATA_PREFIX", os.getenv("HOME") .. "/.local/share/tessdata")

hl.env("BITWARDEN_SSH_AUTH_SOCK", os.getenv("XDG_RUNTIME_DIR") .. "/bitwarden.sock")

hl.env("XCURSOR_SIZE", "18")
hl.env("HYPRCURSOR_SIZE", "18")
hl.env("HYPRCURSOR_THEME", "BreezeX-Dark-hyprcursor")

hl.env("GTK2_RC_FILES", "~/.config/gtk-2.0/gtkrc-2.0")

local file = io.popen("lspci | grep -i 'vga.*nvidia'")
NVIDIA = file and file:read("*a") ~= "" or false

local colors_file_path = os.getenv("HOME") .. "/.config/hypr/include/colors.lua"
file = io.open(colors_file_path, "r")

if file == nil then
    file = io.open(colors_file_path, "w")
    if file ~= nil then
        file:write('Color0Alpha = ""', "\n", 'Color2 = ""', "\n", 'Color3 = ""', "\n", 'BackgroundRed = ""')
        file:close()
    end
else
    file:close()
end

if NVIDIA then
    hl.env("LIBVA_DRIVER_NAME", "nvidia")
    hl.env("GBM_BACKEND", "nvidia-drm")
    hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
    hl.env("NVD_BACKEND", "direct")
end
