local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local systemroot = os.getenv("SystemRoot") or "C:\\Windows"
local userprofile = os.getenv("USERPROFILE") or "C:\\Users\\Default"

config.default_prog = {
  "C:\\Program Files\\PowerShell\\7\\pwsh.exe"
}

config.default_cwd = userprofile

-- config.font = wezterm.font("MesloLGM Nerd Font")
config.font = wezterm.font_with_fallback({
  'MesloLGM Nerd Font',   -- 영문/코드/Nerd Font 아이콘 담당
  'D2CodingLigature Nerd Font',      -- 한국어 fallback
})

-- 기본 창 크기 (문자 단위)
config.initial_cols = 120 
config.initial_rows = 58 

config.color_scheme = 'One Dark (Gogh)'

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})

  local gui = window:gui_window()
  local screens = wezterm.gui.screens()
  local active = screens.active

  -- 로컬 변수로 오프셋 정의
  local OFFSET_X = 10
  local OFFSET_Y = 40

  -- 활성 모니터 좌측 상단 + 오프셋 적용
  gui:set_position(active.x + OFFSET_X, active.y + OFFSET_Y)
end)

config.keys = {
  { key = 'LeftArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left'  },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up'    },
  { key = 'DownArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down'  },
  { key = 't', mods = 'CTRL', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  -- Ctrl+W: 탭 닫기
  { key = 'w', mods = 'CTRL', action = wezterm.action.CloseCurrentTab { confirm = false } },
  -- Ctrl+Shift+W: pane 닫기
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = false } },
   -- D: 수직 분할 (좌우)
  { key = 'd', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  -- E: 수평 분할 (위아래)
  { key = 'e', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
}

-- 탭 이동 Ctrl+숫자
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

return config
