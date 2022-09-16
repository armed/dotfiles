(module config.ayu
  {autoload {nvim aniseed.nvim
             ayu ayu
             colors ayu.colors}})

(local colors {:accent "#FFCC66"
               :bg "#1F2430"
               :fg "#CBCCC6"
               :ui "#707A8C"
               :tag "#5CCFE6"
               :func "#FFD580"
               :entity "#73D0FF"
               :string "#BAE67E"
               :regexp "#95E6CB"
               :markup "#F28779"
               :keyword "#FFA759"
               :special "#FFE6B3"
               :comment "#5C6773"
               :constant "#D4BFFF"
               :operator "#F29E74"
               :error "#FF3333"
               :line "#191E2A"
               :panel_bg "#232834"
               :panel_shadow "#141925"
               :panel_border "#101521"
               :gutter_normal "#404755"
               :gutter_active "#5F687A"
               :selection_bg "#33415E"
               :selection_inactive "#323A4C"
               :selection_border "#232A4C"
               :guide_active "#576070"
               :guide_normal "#383E4C"
               :vcs_added "#A6CC70"
               :vcs_modified "#77A8D9"
               :vcs_removed "#F27983"
               :vcs_added_bg "#313D37"
               :vcs_removed_bg "#3E373A"
               :fg_idle "#607080"
               :warning "#FFA759"})
(ayu.setup 
  {:mirage true
   :overrides 
   {:NvimTreeIndentMarker {:fg (. colors :comment)}}})


(ayu.colorscheme false)	
