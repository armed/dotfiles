(local packer (require :packer))
(local util (require :packer.util))

(packer.init
  {:display {:open_fn #(util.float {:border :double})}})
