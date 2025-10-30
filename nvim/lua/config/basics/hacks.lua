vim.api.nvim_create_autocmd("SourcePost", {
  pattern = "*/autoload/zip.vim",
  callback = function()
    vim.cmd([[
        function! s:ZipReadPS(zipfile, fname, tempfile)
          let cmds = [
                \ '$zip = [System.IO.Compression.ZipFile]::OpenRead(' . shellescape(a:zipfile) . ');',
                \ '$fileEntry = $zip.Entries | Where-Object { $_.FullName -eq ' . shellescape(a:fname) . ' };',
                \ '$stream = $fileEntry.Open();',
                \ '$fileStream = [System.IO.File]::Create(' . shellescape(a:tempfile) . ');',
                \ '$stream.CopyTo($fileStream);',
                \ '$fileStream.Close();',
                \ '$stream.Close();',
                \ '$zip.Dispose()'
                \ ]
          return 'pwsh -NoProfile -Command ' . shellescape(join(cmds, ' '))
        endfunction
      ]])
  end,
})
