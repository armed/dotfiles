# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_k42_global_optspecs
	string join \n log-level= o/output= h/help
end

function __fish_k42_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_k42_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_k42_using_subcommand
	set -l cmd (__fish_k42_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c k42 -n "__fish_k42_needs_command" -l log-level -r
complete -c k42 -n "__fish_k42_needs_command" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_needs_command" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_needs_command" -f -a "context" -d 'Manage contexts'
complete -c k42 -n "__fish_k42_needs_command" -f -a "platform" -d 'Platform API commands'
complete -c k42 -n "__fish_k42_needs_command" -f -a "publisher" -d 'Publisher/ad-server API commands'
complete -c k42 -n "__fish_k42_needs_command" -f -a "ros" -d 'ROS API commands'
complete -c k42 -n "__fish_k42_needs_command" -f -a "init" -d 'Seed init operations for local development'
complete -c k42 -n "__fish_k42_needs_command" -f -a "payment-gateway" -d 'Payment gateway simulator'
complete -c k42 -n "__fish_k42_needs_command" -f -a "completions" -d 'Generate shell completions'
complete -c k42 -n "__fish_k42_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand context; and not __fish_seen_subcommand_from list show use create patch delete help" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand context; and not __fish_seen_subcommand_from list show use create patch delete help" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand context; and not __fish_seen_subcommand_from list show use create patch delete help" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand context; and not __fish_seen_subcommand_from list show use create patch delete help" -f -a "list" -d 'List all contexts'
complete -c k42 -n "__fish_k42_using_subcommand context; and not __fish_seen_subcommand_from list show use create patch delete help" -f -a "show" -d 'Show the active context'
complete -c k42 -n "__fish_k42_using_subcommand context; and not __fish_seen_subcommand_from list show use create patch delete help" -f -a "use" -d 'Set the active context'
complete -c k42 -n "__fish_k42_using_subcommand context; and not __fish_seen_subcommand_from list show use create patch delete help" -f -a "create" -d 'Create a new context'
complete -c k42 -n "__fish_k42_using_subcommand context; and not __fish_seen_subcommand_from list show use create patch delete help" -f -a "patch" -d 'Update an existing context'
complete -c k42 -n "__fish_k42_using_subcommand context; and not __fish_seen_subcommand_from list show use create patch delete help" -f -a "delete" -d 'Delete a context'
complete -c k42 -n "__fish_k42_using_subcommand context; and not __fish_seen_subcommand_from list show use create patch delete help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from list" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from list" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from show" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from show" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from show" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from use" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from use" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from use" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from create" -l name -r
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from create" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from create" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from patch" -l name -r
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from patch" -l service -r
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from patch" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from patch" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from patch" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from delete" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from delete" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from help" -f -a "list" -d 'List all contexts'
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from help" -f -a "show" -d 'Show the active context'
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from help" -f -a "use" -d 'Set the active context'
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a new context'
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from help" -f -a "patch" -d 'Update an existing context'
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a context'
complete -c k42 -n "__fish_k42_using_subcommand context; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "auth" -d 'Authentication and authorization'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "role" -d 'Manage roles and permissions'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "organization" -d 'Manage organizations'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "workspace" -d 'Manage workspaces'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "user" -d 'Manage users'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "platform-user" -d 'Manage platform users'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "auth-token" -d 'Manage auth tokens'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "service-account" -d 'Manage service accounts'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "client-credentials" -d 'Manage client credentials'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "campaign" -d 'Manage campaigns'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "deal" -d 'Manage deals'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "deal-variant" -d 'Manage deal variants'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "deal-clip" -d 'Manage deal clips'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "airdrop" -d 'Manage airdrops'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "airdrop-variant" -d 'Manage airdrop variants'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "asset-collection" -d 'Manage asset collections'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "asset" -d 'Manage assets'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "loyalty-program" -d 'Manage loyalty programs'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "payment-method" -d 'Manage payment methods'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "publisher" -d 'Manage publishers'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "ros-instance" -d 'Manage ROS instances'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "payout-account" -d 'Manage payout accounts'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "effect-intent" -d 'Manage effect intents'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "transaction" -d 'Manage transactions'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "image" -d 'Manage images'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "generate" -d 'AI generation tools'
complete -c k42 -n "__fish_k42_using_subcommand platform; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials campaign deal deal-variant deal-clip airdrop airdrop-variant asset-collection asset loyalty-program payment-method publisher ros-instance payout-account effect-intent transaction image generate help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth" -f -a "whoami" -d 'Show the authenticated account'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth" -f -a "check-permission" -d 'Check a single permission'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth" -f -a "bulk-check-permission" -d 'Check multiple permissions in bulk'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth" -f -a "list-resource-ids" -d 'List resource IDs a subject has access to'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth" -f -a "list-subject-ids" -d 'List subject IDs that have access to a resource'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth" -f -a "provision-jwt" -d 'Provision a JWT for an account'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from role" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from role" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from role" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from role" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from role" -f -a "list-definitions" -d 'List all role definitions'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from role" -f -a "assign" -d 'Assign roles to an account on a resource'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from role" -f -a "unassign" -d 'Unassign roles from an account on a resource'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from role" -f -a "list-assigned-resources" -d 'List resources assigned to an account'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from role" -f -a "list-assigned-subjects" -d 'List subjects assigned to a resource'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from role" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from organization" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from organization" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from organization" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from organization" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from organization" -f -a "list" -d 'List organizations'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from organization" -f -a "get" -d 'Get an organization by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from organization" -f -a "create" -d 'Create a new organization'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from organization" -f -a "patch" -d 'Patch an existing organization'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from organization" -f -a "features" -d 'Manage organization features'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from organization" -f -a "customer" -d 'Manage organization customer'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from organization" -f -a "financial-accounts" -d 'Manage organization financial accounts'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from organization" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from workspace" -l org-id -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from workspace" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from workspace" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from workspace" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from workspace" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from workspace" -f -a "list" -d 'List workspaces for an organization'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from workspace" -f -a "get" -d 'Get a workspace by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from workspace" -f -a "create" -d 'Create a new workspace'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from workspace" -f -a "patch" -d 'Patch an existing workspace'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from workspace" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from user" -l org-id -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from user" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from user" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from user" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from user" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from user" -f -a "list" -d 'List users for an organization'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from user" -f -a "get" -d 'Get a user by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from user" -f -a "create" -d 'Create a new user'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from user" -f -a "delete" -d 'Delete a user'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from user" -f -a "patch" -d 'Patch an existing user'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from user" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from platform-user" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from platform-user" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from platform-user" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from platform-user" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from platform-user" -f -a "list" -d 'List platform users'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from platform-user" -f -a "get" -d 'Get a platform user by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from platform-user" -f -a "create" -d 'Create a new platform user'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from platform-user" -f -a "delete" -d 'Delete a platform user'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from platform-user" -f -a "patch" -d 'Patch an existing platform user'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from platform-user" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth-token" -l account-id -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth-token" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth-token" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth-token" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth-token" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth-token" -f -a "list" -d 'List auth tokens for an account'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth-token" -f -a "get" -d 'Get an auth token by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth-token" -f -a "create" -d 'Create a new auth token'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth-token" -f -a "patch" -d 'Patch an existing auth token'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth-token" -f -a "revoke" -d 'Revoke an auth token'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from auth-token" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from service-account" -l org-id -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from service-account" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from service-account" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from service-account" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from service-account" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from service-account" -f -a "list" -d 'List service accounts for an organization'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from service-account" -f -a "get" -d 'Get a service account by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from service-account" -f -a "create" -d 'Create a new service account'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from service-account" -f -a "delete" -d 'Delete a service account'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from service-account" -f -a "patch" -d 'Patch an existing service account'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from service-account" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from client-credentials" -l account-id -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from client-credentials" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from client-credentials" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from client-credentials" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from client-credentials" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from client-credentials" -f -a "list" -d 'List client credentials for an account'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from client-credentials" -f -a "create" -d 'Create new client credentials'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from client-credentials" -f -a "revoke" -d 'Revoke client credentials'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from client-credentials" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from campaign" -l workspace-id -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from campaign" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from campaign" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from campaign" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from campaign" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from campaign" -f -a "list" -d 'List campaigns for a workspace'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from campaign" -f -a "get" -d 'Get a campaign by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from campaign" -f -a "create" -d 'Create a new campaign'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from campaign" -f -a "patch" -d 'Patch an existing campaign'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from campaign" -f -a "delete" -d 'Delete a campaign'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from campaign" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal" -l campaign-id -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal" -f -a "list" -d 'List deals for a campaign'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal" -f -a "get" -d 'Get a deal by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal" -f -a "create" -d 'Create a new deal'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal" -f -a "patch" -d 'Patch an existing deal'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal" -f -a "delete" -d 'Delete a deal'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-variant" -l deal-id -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-variant" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-variant" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-variant" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-variant" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-variant" -f -a "list" -d 'List deal variants for a deal'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-variant" -f -a "get" -d 'Get a deal variant by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-variant" -f -a "create" -d 'Create a new deal variant'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-variant" -f -a "bulk-create" -d 'Bulk create deal variants'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-variant" -f -a "patch" -d 'Patch an existing deal variant'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-variant" -f -a "delete" -d 'Delete a deal variant'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-variant" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-clip" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-clip" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-clip" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-clip" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-clip" -f -a "list" -d 'List deal clips'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-clip" -f -a "get" -d 'Get a deal clip by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-clip" -f -a "create" -d 'Create a new deal clip'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-clip" -f -a "delete" -d 'Delete a deal clip'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from deal-clip" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop" -l campaign-id -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop" -f -a "list" -d 'List airdrops for a campaign'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop" -f -a "get" -d 'Get an airdrop by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop" -f -a "create" -d 'Create a new airdrop'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop" -f -a "patch" -d 'Patch an existing airdrop'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop-variant" -l airdrop-id -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop-variant" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop-variant" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop-variant" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop-variant" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop-variant" -f -a "list" -d 'List airdrop variants for an airdrop'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop-variant" -f -a "get" -d 'Get an airdrop variant by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop-variant" -f -a "create" -d 'Create a new airdrop variant'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop-variant" -f -a "bulk-create" -d 'Bulk create airdrop variants'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop-variant" -f -a "patch" -d 'Patch an existing airdrop variant'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop-variant" -f -a "delete" -d 'Delete an airdrop variant'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from airdrop-variant" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset-collection" -l workspace-id -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset-collection" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset-collection" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset-collection" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset-collection" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset-collection" -f -a "list" -d 'List asset collections for a workspace'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset-collection" -f -a "get" -d 'Get an asset collection by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset-collection" -f -a "create" -d 'Create a new asset collection'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset-collection" -f -a "patch" -d 'Patch an existing asset collection'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset-collection" -f -a "delete" -d 'Delete an asset collection'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset-collection" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset" -l collection-id -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset" -f -a "list" -d 'List assets for a collection'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset" -f -a "create" -d 'Create new assets'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset" -f -a "delete" -d 'Delete an asset'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from asset" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from loyalty-program" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from loyalty-program" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from loyalty-program" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from loyalty-program" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from loyalty-program" -f -a "list" -d 'List loyalty programs'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from loyalty-program" -f -a "get" -d 'Get a loyalty program by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from loyalty-program" -f -a "create" -d 'Create a new loyalty program'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from loyalty-program" -f -a "patch" -d 'Patch an existing loyalty program'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from loyalty-program" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payment-method" -l customer-id -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payment-method" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payment-method" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payment-method" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payment-method" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payment-method" -f -a "list" -d 'List payment methods for a customer'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payment-method" -f -a "create" -d 'Create a new payment method'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payment-method" -f -a "delete" -d 'Delete a payment method'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payment-method" -f -a "set-default" -d 'Set a payment method as the default'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payment-method" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from publisher" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from publisher" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from publisher" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from publisher" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from publisher" -f -a "list" -d 'List publishers'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from publisher" -f -a "get" -d 'Get a publisher by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from publisher" -f -a "create" -d 'Create a new publisher'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from publisher" -f -a "key" -d 'Manage publisher keys'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from publisher" -f -a "webhook" -d 'Manage publisher webhooks'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from publisher" -f -a "event" -d 'Manage publisher events'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from publisher" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from ros-instance" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from ros-instance" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from ros-instance" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from ros-instance" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from ros-instance" -f -a "list" -d 'List ROS instances'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from ros-instance" -f -a "get" -d 'Get a ROS instance by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from ros-instance" -f -a "create" -d 'Create a new ROS instance'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from ros-instance" -f -a "key" -d 'Manage ROS instance keys'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from ros-instance" -f -a "merchant-mapping" -d 'Manage ROS merchant mappings'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from ros-instance" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payout-account" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payout-account" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payout-account" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payout-account" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payout-account" -f -a "get" -d 'Get a payout account by organization ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payout-account" -f -a "create" -d 'Create a new payout account'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payout-account" -f -a "create-link" -d 'Create an account link for onboarding'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payout-account" -f -a "withdraw" -d 'Withdraw from a payout account'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from payout-account" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from effect-intent" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from effect-intent" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from effect-intent" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from effect-intent" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from effect-intent" -f -a "get" -d 'Get an effect intent by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from effect-intent" -f -a "list" -d 'List effect intents'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from effect-intent" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from transaction" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from transaction" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from transaction" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from transaction" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from transaction" -f -a "ingest" -d 'Ingest a transaction'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from transaction" -f -a "get" -d 'Get a transaction by ID'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from transaction" -f -a "list" -d 'List publisher transactions'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from transaction" -f -a "poll" -d 'Poll publisher transactions'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from transaction" -f -a "publish-effects" -d 'Publish transaction effects'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from transaction" -f -a "resolve-rule" -d 'Resolve a processing rule'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from transaction" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from image" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from image" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from image" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from image" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from image" -f -a "upload" -d 'Upload an image (multipart)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from image" -f -a "get" -d 'Get an image by CAS address'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from image" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from generate" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from generate" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from generate" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from generate" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from generate" -f -a "deal-variant-banner" -d 'Generate a banner for a deal variant'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from generate" -f -a "deal-variants" -d 'Generate deal variants for a deal'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from generate" -f -a "redo-deal-variants" -d 'Redo deal variant generation'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from generate" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "auth" -d 'Authentication and authorization'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "role" -d 'Manage roles and permissions'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "organization" -d 'Manage organizations'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "workspace" -d 'Manage workspaces'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "user" -d 'Manage users'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "platform-user" -d 'Manage platform users'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "auth-token" -d 'Manage auth tokens'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "service-account" -d 'Manage service accounts'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "client-credentials" -d 'Manage client credentials'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "campaign" -d 'Manage campaigns'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "deal" -d 'Manage deals'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "deal-variant" -d 'Manage deal variants'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "deal-clip" -d 'Manage deal clips'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "airdrop" -d 'Manage airdrops'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "airdrop-variant" -d 'Manage airdrop variants'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "asset-collection" -d 'Manage asset collections'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "asset" -d 'Manage assets'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "loyalty-program" -d 'Manage loyalty programs'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "payment-method" -d 'Manage payment methods'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "publisher" -d 'Manage publishers'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "ros-instance" -d 'Manage ROS instances'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "payout-account" -d 'Manage payout accounts'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "effect-intent" -d 'Manage effect intents'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "transaction" -d 'Manage transactions'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "image" -d 'Manage images'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "generate" -d 'AI generation tools'
complete -c k42 -n "__fish_k42_using_subcommand platform; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "member-base" -d 'Manage member bases'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "member" -d 'Manage members'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "wallet" -d 'Manage wallets'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "clip" -d 'Manage clips'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "stamp-collection" -d 'Manage stamp collections'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "loyalty-program" -d 'View loyalty programs'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "card" -d 'Manage cards'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "ad-unit" -d 'Manage ad units'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "attribute-schema" -d 'Manage attribute schemas'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "member-attributes" -d 'Manage member attributes'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "delivery" -d 'Delivery operations'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "impression" -d 'Manage impressions'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "placement-configuration" -d 'View placement configurations'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "transaction" -d 'Manage transactions'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and not __fish_seen_subcommand_from member-base member wallet clip stamp-collection loyalty-program card ad-unit attribute-schema member-attributes delivery impression placement-configuration transaction help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-base" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-base" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-base" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-base" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-base" -f -a "list" -d 'List member bases'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-base" -f -a "get" -d 'Get a member base by ID'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-base" -f -a "create" -d 'Create a new member base'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-base" -f -a "delete" -d 'Delete a member base'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-base" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member" -l member-base-id -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member" -f -a "list" -d 'List members in a member base'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member" -f -a "get" -d 'Get a member by ID or ref'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member" -f -a "upsert" -d 'Bulk upsert members'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member" -f -a "delete" -d 'Bulk delete members'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from wallet" -l member-id -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from wallet" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from wallet" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from wallet" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from wallet" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from wallet" -f -a "list" -d 'List wallets for a member'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from wallet" -f -a "list-transactions" -d 'List wallet transactions'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from wallet" -f -a "list-cashbacks" -d 'List wallet cashbacks for a transaction'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from wallet" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from clip" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from clip" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from clip" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from clip" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from clip" -f -a "get" -d 'Get a clip by ID'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from clip" -f -a "save" -d 'Save (create) a clip'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from clip" -f -a "delete" -d 'Delete a clip'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from clip" -f -a "list" -d 'List clips with variant info for a member'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from clip" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from stamp-collection" -l member-id -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from stamp-collection" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from stamp-collection" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from stamp-collection" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from stamp-collection" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from stamp-collection" -f -a "get" -d 'Get a stamp collection by ID'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from stamp-collection" -f -a "create" -d 'Create a new stamp collection'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from stamp-collection" -f -a "list" -d 'List stamp collections for a member'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from stamp-collection" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from loyalty-program" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from loyalty-program" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from loyalty-program" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from loyalty-program" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from loyalty-program" -f -a "list" -d 'List loyalty programs'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from loyalty-program" -f -a "get" -d 'Get a loyalty program by ID'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from loyalty-program" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from card" -l member-id -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from card" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from card" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from card" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from card" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from card" -f -a "list" -d 'List cards for a member'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from card" -f -a "create" -d 'Bulk create cards'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from card" -f -a "delete" -d 'Bulk delete cards'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from card" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from ad-unit" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from ad-unit" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from ad-unit" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from ad-unit" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from ad-unit" -f -a "list" -d 'List ad units'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from ad-unit" -f -a "get" -d 'Get an ad unit by ID'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from ad-unit" -f -a "create" -d 'Create a new ad unit'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from ad-unit" -f -a "delete" -d 'Delete an ad unit'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from ad-unit" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from attribute-schema" -l member-base-id -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from attribute-schema" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from attribute-schema" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from attribute-schema" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from attribute-schema" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from attribute-schema" -f -a "get" -d 'Get the attribute schema for a member base'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from attribute-schema" -f -a "set" -d 'Set the attribute schema for a member base'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from attribute-schema" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-attributes" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-attributes" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-attributes" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-attributes" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-attributes" -f -a "list" -d 'List attributes for a member'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-attributes" -f -a "set" -d 'Set member attributes'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-attributes" -f -a "delete" -d 'Delete member attributes'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from member-attributes" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from delivery" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from delivery" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from delivery" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from delivery" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from delivery" -f -a "list-eligible" -d 'List eligible deals for a member and ad unit'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from delivery" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from impression" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from impression" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from impression" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from impression" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from impression" -f -a "list" -d 'List impressions'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from impression" -f -a "record" -d 'Record impressions'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from impression" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from placement-configuration" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from placement-configuration" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from placement-configuration" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from placement-configuration" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from placement-configuration" -f -a "list" -d 'List placement configurations'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from placement-configuration" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from transaction" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from transaction" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from transaction" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from transaction" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from transaction" -f -a "list" -d 'List transactions'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from transaction" -f -a "ingest" -d 'Ingest transaction events'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from transaction" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "member-base" -d 'Manage member bases'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "member" -d 'Manage members'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "wallet" -d 'Manage wallets'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "clip" -d 'Manage clips'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "stamp-collection" -d 'Manage stamp collections'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "loyalty-program" -d 'View loyalty programs'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "card" -d 'Manage cards'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "ad-unit" -d 'Manage ad units'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "attribute-schema" -d 'Manage attribute schemas'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "member-attributes" -d 'Manage member attributes'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "delivery" -d 'Delivery operations'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "impression" -d 'Manage impressions'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "placement-configuration" -d 'View placement configurations'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "transaction" -d 'Manage transactions'
complete -c k42 -n "__fish_k42_using_subcommand publisher; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -f -a "auth" -d 'Authentication and authorization'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -f -a "role" -d 'Manage roles and permissions'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -f -a "organization" -d 'Manage organizations'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -f -a "workspace" -d 'Manage workspaces'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -f -a "user" -d 'Manage users'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -f -a "platform-user" -d 'Manage platform users'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -f -a "auth-token" -d 'Manage auth tokens'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -f -a "service-account" -d 'Manage service accounts'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -f -a "client-credentials" -d 'Manage client credentials'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -f -a "store" -d 'Manage stores'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -f -a "order" -d 'Manage orders'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -f -a "login" -d 'Login and session management'
complete -c k42 -n "__fish_k42_using_subcommand ros; and not __fish_seen_subcommand_from auth role organization workspace user platform-user auth-token service-account client-credentials store order login help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth" -f -a "whoami" -d 'Show the authenticated account'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth" -f -a "check-permission" -d 'Check a single permission'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth" -f -a "bulk-check-permission" -d 'Check multiple permissions in bulk'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth" -f -a "list-resource-ids" -d 'List resource IDs a subject has access to'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth" -f -a "list-subject-ids" -d 'List subject IDs that have access to a resource'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth" -f -a "provision-jwt" -d 'Provision a JWT for an account'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from role" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from role" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from role" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from role" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from role" -f -a "list-definitions" -d 'List all role definitions'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from role" -f -a "assign" -d 'Assign roles to an account on a resource'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from role" -f -a "unassign" -d 'Unassign roles from an account on a resource'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from role" -f -a "list-assigned-resources" -d 'List resources assigned to an account'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from role" -f -a "list-assigned-subjects" -d 'List subjects assigned to a resource'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from role" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from organization" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from organization" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from organization" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from organization" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from organization" -f -a "list" -d 'List organizations'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from organization" -f -a "get" -d 'Get an organization by ID'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from organization" -f -a "create" -d 'Create a new organization'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from organization" -f -a "patch" -d 'Patch an existing organization'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from organization" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from workspace" -l org-id -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from workspace" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from workspace" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from workspace" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from workspace" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from workspace" -f -a "list" -d 'List workspaces for an organization'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from workspace" -f -a "get" -d 'Get a workspace by ID'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from workspace" -f -a "create" -d 'Create a new workspace'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from workspace" -f -a "patch" -d 'Patch an existing workspace'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from workspace" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from user" -l org-id -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from user" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from user" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from user" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from user" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from user" -f -a "list" -d 'List users for an organization'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from user" -f -a "get" -d 'Get a user by ID'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from user" -f -a "create" -d 'Create a new user'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from user" -f -a "delete" -d 'Delete a user'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from user" -f -a "patch" -d 'Patch an existing user'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from user" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from platform-user" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from platform-user" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from platform-user" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from platform-user" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from platform-user" -f -a "list" -d 'List platform users'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from platform-user" -f -a "get" -d 'Get a platform user by ID'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from platform-user" -f -a "create" -d 'Create a new platform user'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from platform-user" -f -a "delete" -d 'Delete a platform user'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from platform-user" -f -a "patch" -d 'Patch an existing platform user'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from platform-user" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth-token" -l account-id -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth-token" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth-token" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth-token" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth-token" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth-token" -f -a "list" -d 'List auth tokens for an account'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth-token" -f -a "get" -d 'Get an auth token by ID'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth-token" -f -a "create" -d 'Create a new auth token'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth-token" -f -a "patch" -d 'Patch an existing auth token'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth-token" -f -a "revoke" -d 'Revoke an auth token'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from auth-token" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from service-account" -l org-id -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from service-account" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from service-account" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from service-account" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from service-account" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from service-account" -f -a "list" -d 'List service accounts for an organization'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from service-account" -f -a "get" -d 'Get a service account by ID'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from service-account" -f -a "create" -d 'Create a new service account'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from service-account" -f -a "delete" -d 'Delete a service account'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from service-account" -f -a "patch" -d 'Patch an existing service account'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from service-account" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from client-credentials" -l account-id -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from client-credentials" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from client-credentials" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from client-credentials" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from client-credentials" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from client-credentials" -f -a "list" -d 'List client credentials for an account'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from client-credentials" -f -a "create" -d 'Create new client credentials'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from client-credentials" -f -a "exchange" -d 'Exchange client credentials for a JWT'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from client-credentials" -f -a "exchange-platform" -d 'Exchange client credentials for a platform JWT'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from client-credentials" -f -a "revoke" -d 'Revoke client credentials'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from client-credentials" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from store" -l workspace-id -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from store" -l org-id -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from store" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from store" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from store" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from store" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from store" -f -a "create" -d 'Create a new store'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from store" -f -a "get" -d 'Get a store by ID'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from store" -f -a "list" -d 'List stores for a workspace'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from store" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from order" -l workspace-id -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from order" -l org-id -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from order" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from order" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from order" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from order" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from order" -f -a "create" -d 'Bulk upsert orders (via JSON body)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from order" -f -a "get-details" -d 'Get order details'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from order" -f -a "list" -d 'List orders for a workspace'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from order" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from login" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from login" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from login" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from login" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from login" -f -a "get-login-method" -d 'Get the login method for an organization'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from login" -f -a "get-sso-url" -d 'Get an SSO URL'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from login" -f -a "request-otp" -d 'Request a login OTP'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from login" -f -a "login-with-otp" -d 'Login with an OTP'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from login" -f -a "logout" -d 'Logout the current session'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from login" -f -a "refresh-session" -d 'Refresh the current session'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from login" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from help" -f -a "auth" -d 'Authentication and authorization'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from help" -f -a "role" -d 'Manage roles and permissions'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from help" -f -a "organization" -d 'Manage organizations'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from help" -f -a "workspace" -d 'Manage workspaces'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from help" -f -a "user" -d 'Manage users'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from help" -f -a "platform-user" -d 'Manage platform users'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from help" -f -a "auth-token" -d 'Manage auth tokens'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from help" -f -a "service-account" -d 'Manage service accounts'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from help" -f -a "client-credentials" -d 'Manage client credentials'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from help" -f -a "store" -d 'Manage stores'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from help" -f -a "order" -d 'Manage orders'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from help" -f -a "login" -d 'Login and session management'
complete -c k42 -n "__fish_k42_using_subcommand ros; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand init; and not __fish_seen_subcommand_from all platform publisher ros help" -s c -l context -r
complete -c k42 -n "__fish_k42_using_subcommand init; and not __fish_seen_subcommand_from all platform publisher ros help" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand init; and not __fish_seen_subcommand_from all platform publisher ros help" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand init; and not __fish_seen_subcommand_from all platform publisher ros help" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand init; and not __fish_seen_subcommand_from all platform publisher ros help" -f -a "all" -d 'Run all seed steps (platform, publisher, ros)'
complete -c k42 -n "__fish_k42_using_subcommand init; and not __fish_seen_subcommand_from all platform publisher ros help" -f -a "platform" -d 'Create or select an organization and workspace'
complete -c k42 -n "__fish_k42_using_subcommand init; and not __fish_seen_subcommand_from all platform publisher ros help" -f -a "publisher" -d 'Create a publisher, fetch JWKS and register keys'
complete -c k42 -n "__fish_k42_using_subcommand init; and not __fish_seen_subcommand_from all platform publisher ros help" -f -a "ros" -d 'Create a ROS instance, fetch JWKS and register keys'
complete -c k42 -n "__fish_k42_using_subcommand init; and not __fish_seen_subcommand_from all platform publisher ros help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l org-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l org-alias -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l org-name -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l workspace-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l workspace-name -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l publisher-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l publisher-name -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l publisher-jwks-url -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l webhook-callback-url -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l ros-instance-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l ros-name -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l ros-base-url -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l ros-jwks-url -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l ros-organization-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l ros-workspace-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -s c -l context -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from all" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from platform" -l org-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from platform" -l org-alias -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from platform" -l org-name -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from platform" -l workspace-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from platform" -l workspace-name -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from platform" -s c -l context -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from platform" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from platform" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from platform" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from publisher" -l org-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from publisher" -l workspace-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from publisher" -l publisher-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from publisher" -l name -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from publisher" -l jwks-url -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from publisher" -l webhook-callback-url -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from publisher" -s c -l context -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from publisher" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from publisher" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from publisher" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from ros" -l ros-instance-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from ros" -l ros-name -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from ros" -l ros-base-url -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from ros" -l ros-jwks-url -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from ros" -l ros-organization-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from ros" -l ros-workspace-id -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from ros" -s c -l context -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from ros" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from ros" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from ros" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from help" -f -a "all" -d 'Run all seed steps (platform, publisher, ros)'
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from help" -f -a "platform" -d 'Create or select an organization and workspace'
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from help" -f -a "publisher" -d 'Create a publisher, fetch JWKS and register keys'
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from help" -f -a "ros" -d 'Create a ROS instance, fetch JWKS and register keys'
complete -c k42 -n "__fish_k42_using_subcommand init; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand payment-gateway" -s c -l context -d 'Use a specific context instead of the active one' -r
complete -c k42 -n "__fish_k42_using_subcommand payment-gateway" -l channel-id -d 'Broadcast channel id (persisted under XDG data)' -r
complete -c k42 -n "__fish_k42_using_subcommand payment-gateway" -s m -l member-id -d 'The member ID to use (skips interactive selection)' -r
complete -c k42 -n "__fish_k42_using_subcommand payment-gateway" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand payment-gateway" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand payment-gateway" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand completions" -l log-level -r
complete -c k42 -n "__fish_k42_using_subcommand completions" -s o -l output -r -f -a "table\t''
json\t''"
complete -c k42 -n "__fish_k42_using_subcommand completions" -s h -l help -d 'Print help'
complete -c k42 -n "__fish_k42_using_subcommand help; and not __fish_seen_subcommand_from context platform publisher ros init payment-gateway completions help" -f -a "context" -d 'Manage contexts'
complete -c k42 -n "__fish_k42_using_subcommand help; and not __fish_seen_subcommand_from context platform publisher ros init payment-gateway completions help" -f -a "platform" -d 'Platform API commands'
complete -c k42 -n "__fish_k42_using_subcommand help; and not __fish_seen_subcommand_from context platform publisher ros init payment-gateway completions help" -f -a "publisher" -d 'Publisher/ad-server API commands'
complete -c k42 -n "__fish_k42_using_subcommand help; and not __fish_seen_subcommand_from context platform publisher ros init payment-gateway completions help" -f -a "ros" -d 'ROS API commands'
complete -c k42 -n "__fish_k42_using_subcommand help; and not __fish_seen_subcommand_from context platform publisher ros init payment-gateway completions help" -f -a "init" -d 'Seed init operations for local development'
complete -c k42 -n "__fish_k42_using_subcommand help; and not __fish_seen_subcommand_from context platform publisher ros init payment-gateway completions help" -f -a "payment-gateway" -d 'Payment gateway simulator'
complete -c k42 -n "__fish_k42_using_subcommand help; and not __fish_seen_subcommand_from context platform publisher ros init payment-gateway completions help" -f -a "completions" -d 'Generate shell completions'
complete -c k42 -n "__fish_k42_using_subcommand help; and not __fish_seen_subcommand_from context platform publisher ros init payment-gateway completions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from context" -f -a "list" -d 'List all contexts'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from context" -f -a "show" -d 'Show the active context'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from context" -f -a "use" -d 'Set the active context'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from context" -f -a "create" -d 'Create a new context'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from context" -f -a "patch" -d 'Update an existing context'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from context" -f -a "delete" -d 'Delete a context'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "auth" -d 'Authentication and authorization'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "role" -d 'Manage roles and permissions'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "organization" -d 'Manage organizations'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "workspace" -d 'Manage workspaces'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "user" -d 'Manage users'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "platform-user" -d 'Manage platform users'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "auth-token" -d 'Manage auth tokens'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "service-account" -d 'Manage service accounts'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "client-credentials" -d 'Manage client credentials'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "campaign" -d 'Manage campaigns'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "deal" -d 'Manage deals'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "deal-variant" -d 'Manage deal variants'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "deal-clip" -d 'Manage deal clips'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "airdrop" -d 'Manage airdrops'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "airdrop-variant" -d 'Manage airdrop variants'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "asset-collection" -d 'Manage asset collections'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "asset" -d 'Manage assets'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "loyalty-program" -d 'Manage loyalty programs'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "payment-method" -d 'Manage payment methods'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "publisher" -d 'Manage publishers'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "ros-instance" -d 'Manage ROS instances'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "payout-account" -d 'Manage payout accounts'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "effect-intent" -d 'Manage effect intents'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "transaction" -d 'Manage transactions'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "image" -d 'Manage images'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from platform" -f -a "generate" -d 'AI generation tools'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "member-base" -d 'Manage member bases'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "member" -d 'Manage members'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "wallet" -d 'Manage wallets'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "clip" -d 'Manage clips'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "stamp-collection" -d 'Manage stamp collections'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "loyalty-program" -d 'View loyalty programs'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "card" -d 'Manage cards'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "ad-unit" -d 'Manage ad units'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "attribute-schema" -d 'Manage attribute schemas'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "member-attributes" -d 'Manage member attributes'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "delivery" -d 'Delivery operations'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "impression" -d 'Manage impressions'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "placement-configuration" -d 'View placement configurations'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from publisher" -f -a "transaction" -d 'Manage transactions'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from ros" -f -a "auth" -d 'Authentication and authorization'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from ros" -f -a "role" -d 'Manage roles and permissions'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from ros" -f -a "organization" -d 'Manage organizations'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from ros" -f -a "workspace" -d 'Manage workspaces'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from ros" -f -a "user" -d 'Manage users'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from ros" -f -a "platform-user" -d 'Manage platform users'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from ros" -f -a "auth-token" -d 'Manage auth tokens'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from ros" -f -a "service-account" -d 'Manage service accounts'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from ros" -f -a "client-credentials" -d 'Manage client credentials'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from ros" -f -a "store" -d 'Manage stores'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from ros" -f -a "order" -d 'Manage orders'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from ros" -f -a "login" -d 'Login and session management'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from init" -f -a "all" -d 'Run all seed steps (platform, publisher, ros)'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from init" -f -a "platform" -d 'Create or select an organization and workspace'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from init" -f -a "publisher" -d 'Create a publisher, fetch JWKS and register keys'
complete -c k42 -n "__fish_k42_using_subcommand help; and __fish_seen_subcommand_from init" -f -a "ros" -d 'Create a ROS instance, fetch JWKS and register keys'
