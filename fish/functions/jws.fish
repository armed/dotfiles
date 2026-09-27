function jws
    if test -z "$argv[1]"
        echo "Usage: jws <workspace-name> [additional args for jj workspace add]"
        return 1
    end

    set -l workspace_root (jj workspace root 2>/dev/null)
    if test $status -ne 0
        echo "Error: not in a jj repo"
        return 1
    end

    set -l repo_root $workspace_root
    set -l repo_node "$workspace_root/.jj/repo"
    if test -f $repo_node
        set -l rel_path (string trim (cat $repo_node))
        set repo_root (realpath "$workspace_root/.jj/$rel_path/../..")
    end

    set -l name $argv[1]
    set -l dest_dir "$repo_root/../.workspaces"
    set -l dest "$dest_dir/$name"

    mkdir -p $dest_dir

    jj workspace add --name $name $dest $argv[2..]
end
