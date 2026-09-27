complete -c jwf -f -a "(
    set -l root (jj workspace root 2>/dev/null)
    if test $status -ne 0
        return
    end
    set -l repo_node \"$root/.jj/repo\"
    if test -f $repo_node
        set -l rel_path (string trim (cat $repo_node))
        set root (realpath \"$root/.jj/$rel_path/../..\")
    end
    set -l ws_dir \"$root/../.workspaces\"
    if test -d $ws_dir
        path basename $ws_dir/*
    end
)"
