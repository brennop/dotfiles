;;
;; https://github.com/hoob3rt/lualine.nvim
;;

(module plugin.statusline
  {autoload {plugin lualine}})

(plugin.setup {:options 
               {:icons_enabled false
                :theme :auto
                :component_separators ["" ""]
                :section_separators ["" ""]
                :disabled_filetypes [ "NvimTree" ]}
               :sections 
               {:lualine_a ["mode"]
                :lualine_b []
                :lualine_c []
                :lualine_x []
                :lualine_y []
                :lualine_z ["location"]}
               :inactive_sections
               {:lualine_a []
                :lualine_b []
                :lualine_c []
                :lualine_x []
                :lualine_y []
                :lualine_z []}})
