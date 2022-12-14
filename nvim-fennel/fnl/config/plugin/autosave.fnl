(module config.plugin.autosave
  {autoload {as auto-save
             utils auto-save.utils.data}})

(as.setup
  {:execution_message {:message (fn [] "")}
   :trigger_events [:BufLeave :FocusLost]
   :condition
   (fn [buf]
     (let [vfn vim.fn]
       (and (= (vfn.getbufvar buf :&modifiable) 1)
            (utils.not_in (vfn.getbufvar buf :&filetype) [:lua]))))})
