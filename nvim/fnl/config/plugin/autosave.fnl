(module autosave
  {autoload {as auto-save
             utils auto-save.utils.data}})

(as.setup
  {:condition
   (fn [buf]
     (let [vfn vim.fn]
       (and (= (vfn.getbufvar buf :&modifiable) 1)
            (utils.not_in (vfn.getbufvar buf :&filetype) [:lua]))))})
