complete -c pdnsutil -f

complete -c pdnsutil -s h -l help
complete -c pdnsutil -l version
complete -c pdnsutil -s v -l verbose
complete -c pdnsutil -l config-name -r
complete -c pdnsutil -l config-dir -F -r
complete -c pdnsutil -l no-colors

# up to date as of 4.8.4
# the --help format is not very useful for programmatic access
set -l commands \
	activate-zone-key add-zone-key create-bind-db deactivate-zone-key \
	disable-dnssec export-zone-dnskey export-zone-ds export-zone-key \
	export-zone-key-pem generate-zone-key import-zone-key \
	import-zone-key-pem publish-zone-key remove-zone-key set-nsec3 \
	unpublish-zone-key unset-nsec3 set-publish-cds set-publish-cdnskey \
	unset-publish-cds unset-publush-cdnskey \
	\
	activate-tsig-key deactivate-tsig-key delete-tsig-key \
	generate-tsig-key import-tsig-key list-tsig-keys \
	\
	add-record add-autoprimary remove-autoprimary list-autoprimaries \
	create-zone create-secondary-zone change-secondary-zone-primary \
	check-all-zones check-zone clear-zone delete-rrset delete-zone \
	edit-zone get-meta hash-password hash-zone-record increase-serial \
	list-keys list-all-zones list-member-zones list-zone load-zone \
	rectify-zone rectify-all-zones replace-rrset secure-zone \
	secure-all-zones set-kind set-options-json set-option set-catalog \
	set-account add-meta set-meta set-presigned show-zone test-schema \
	unset-presigned raw-lua-from-content zonemd-verify-file \
	\
	backend-cmd bench-db \
	b2b-migrate ipencrypt ipdecrypt

function __fish_pdnsutil_using_command
	set -l cmd (commandline -pc)
	test -z "$cmd"
	and return 1
	contains -- $cmd $argv
	and return 0
end

# for example, activate-zone-key needs 2 arguments after "activate-zone-key"
# we presume that all the arguments after the command are its arguments
# we can get the amount of arguments using this formula:
# cmdlen - commandidx

function __fish_pdnsutil_argumentn -a cmd
	# TODO: move to -x once ready
	set -l line (commandline -opc)
	set -l cmdidx (contains -i "$cmd" $line)
	or begin echo -1; return 1; end
	math (count $line) - $cmdidx
end

function __fish_pdnsutil_on_argument -a cmd num
	test (__fish_pdnsutil_argumentn $cmd) -eq $num
end

function __fish_pdnsutil_zones
	pdnsutil list-all-zones
end

# == Subcommands
# = DNSSEC Related Commands
set -l dnssec_algs \
	rsasha1 rsasha1-nsec3-sha1 \
	rsasha256 rsasha512 \
	ecdsa256 ecdsa384 \
	ed25519 ed448

# activate-zone-key ZONE KEY-ID
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a activate-zone-key -d 'Activate a DNSSEC key'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument activate-zone-key 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument activate-zone-key 1' \
	-r # TODO: list zone keys for this zone

# add-zone-key ZONE [KSK,ZSK] [active,inactive] [published,unpublished] KEYBITS ALGORITHM
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a add-zone-key -d 'Create a new DNSSEC key'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument add-zone-key 0' \
	-ra '(__fish_pdnsutil_zones)'
# TODO: do this "correctly"
complete -c pdnsutil -n 'test (__fish_pdnsutil_argumentn add-zone-key) -gt 0' \
	-a 'KSK ZSK active inactive published unpublished'

# create-bind-db FILE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a create-bind-db -d 'Create a DNSSEC database for the BIND backend'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument create-bind-db 0' \
	-Fr

# deactive-zone-key ZONE KEY-ID
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a deactivate-zone-key -d 'Deactivate a DNSSEC key'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument deactivate-zone-key 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument deactivate-zone-key 1' \
	-r # TODO: list zone keys for this zone

# disable-dnssec ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a disable-dnssec -d 'Deactivates all keys and presigning for a zone'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument disable-dnssec 0' \
	-ra '(__fish_pdnsutil_zones)'

# export-zone-dnskey ZONE KEY-ID
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a export-zone-dnskey # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument export-zone-dnskey 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument export-zone-dnskey 1' \
	-r # TODO: list-zone-keys for this zone

# export-zone-ds ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a export-zone-ds # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument export-zone-ds 0' \
	-ra '(__fish_pdnsutil_zones)'

# export-zone-key ZONE KEY-ID
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a export-zone-key # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument export-zone-key 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument export-zone-key 1' \
	-r # TODO: list-zone-keys for this zone

# export-zone-key-pem ZONE KEY-ID
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a export-zone-key-pem # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument export-zone-key-pem 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument export-zone-key-pem 1' \
	-r # TODO: list-zone-keys for this zone

# generate-zone-key {ZSK,PSK} [ALGORITHM] [KEYBITS]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a generate-zone-key # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument generate-zone-key 0' \
	-ra 'ZSK PSK'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument generate-zone-key 1' \
	-ra "$dnssec_algs"
# keybits omitted

# import-zone-key ZONE FILE {KSK,ZSK}
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a import-zone-key # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument import-zone-key 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument import-zone-key 1' \
	-Fr
complete -c pdnsutil -n '__fish_pdnsutil_on_argument import-zone-key 2' \
	-ra 'ZSK PSK'

# import-zone-key-pem ZONE FILE ALGORITHM {KSK,ZSK}
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a import-zone-key-pem # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument import-zone-key 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument import-zone-key 1' \
	-Fr
complete -c pdnsutil -n '__fish_pdnsutil_on_argument import-zone-key 2' \
	-ra "$dnssec_algs"
complete -c pdnsutil -n '__fish_pdnsutil_on_argument import-zone-key 3' \
	-ra 'ZSK PSK'

# publish-zone-key ZONE KEY-ID
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a publish-zone-key -d 'Publish a DNSSEC key in a zone'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument publish-zone-key 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument publish-zone-key 1' \
	-r # TODO: list-zone-keys for this zone

# remove-zone-key ZONE KEY-ID
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a remove-zone-key -d 'Remove a DNSSEC key from a zone'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument remove-zone-key 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument remove-zone-key 1' \
	-r # TODO: list-zone-keys for this zone

# set-nsec3 ZONE [’HASH-ALGORITHM FLAGS ITERATIONS SALT’] [narrow]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a set-nsec3 -d 'Set NSEC3 parameters for a zone'
# TODO: complete things other than zone
complete -c pdnsutil -n '__fish_pdnsutil_on_argument set-nsec3 0' \
	-ra '(__fish_pdnsutil_zones)'

# unpublish-zone-key ZONE KEY-ID
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a unpublish-zone-key -d 'Unpublish a DNSSEC key from a zone'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument unpublish-zone-key 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument unpublish-zone-key 1' \
	-r # TODO: list-zone-keys for this zone

# unset-nsec3 ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a unset-nsec3 -d 'Convert a zone from NSEC3 to NSEC'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument unset-nsec3 0' \
	-ra '(__fish_pdnsutil_zones)'

# set-publish-cds ZONE [DIGESTALGOS]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a set-publish-cds # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument set-publish-cds 0' \
	-ra '(__fish_pdnsutil_zones)'

# set-publish-cdnskey ZONE [delete]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a set-publish-cdnskey # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument set-publish-cdnskey 0' \
	-ra '(__fish_pdnsutil_zones)'

# unset-publish-cds ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a unset-publish-cds # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument unset-publish-cds 0' \
	-ra '(__fish_pdnsutil_zones)'

# unset-publish-cdnskey ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a unset-publish-cdnskey # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument unset-publish-cdnskey 0' \
	-ra '(__fish_pdnsutil_zones)'

# = TSIG Related Commands
set -l tsig_algos hmac-md5 hmac-sha1 \
	hmac-sha224 hmac-sha256 hmac-sha384 hmac-sha512

# activate-tsig-key ZONE NAME {primary,secondary,producer,consumer}
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a activate-tsig-key -d 'Enable TSIG authenticated AXFR'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument activate-tsig-key 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument activate-tsig-key 1' \
	-r # TODO: tsig keys
complete -c pdnsutil -n '__fish_pdnsutil_on_argument activate-tsig-key 2' \
	-ra 'primary secondary producer consumer'

# deactivate-tsig-key ZONE NAME {primary,secondary,producer,consumer}
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a deactivate-tsig-key -d 'Disable TSIG authenticated AXFR'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument deactivate-tsig-key 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument deactivate-tsig-key 1' \
	-r # TODO: tsig keys
complete -c pdnsutil -n '__fish_pdnsutil_on_argument deactivate-tsig-key 2' \
	-ra 'primary secondary producer consumer'

# delete-tsig-key NAME
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a delete-tsig-key -d 'Delete a TSIG key'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument delete-tsig-key 0' \
	-r # TODO: tsig keys

# generate-tsig-key NAME ALGORITHM
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a generate-tsig-key -d 'Generate a new TSIG key'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument generate-tsig-key 1' \
	-ra "$tsig_algos"

# import-tsig-key NAME ALGORITHM KEY
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a import-tsig-key -d 'Import a TSIG key'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument import-tsig-key 1' \
	-ra "$tsig_algos"

# list-tsig-keys
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a list-tsig-keys -d 'List all configured TSIG keys'

# = Zone Manipulation Commands
# add-record ZONE NAME TYPE [TTL] CONTENT
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a add-record -d 'Add new records'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument add-record 0' \
	-ra '(__fish_pdnsutil_zones)'
# TODO: hints for the other arguments??

# add-autoprimary IP NAMESERVER [ACCOUNT]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a add-autoprimary -d 'Add a new autoprimary'

# remove-autoprimary IP NAMESERVER
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a remove-autoprimary -d 'Remove an autoprimary'

# list-autoprimaries
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a list-autoprimaries -d 'List all autoprimaries'

# create-zone ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a create-zone -d 'Create a new primary zone'

# create-secondary-zone ZONE PRIMARY [PRIMARY…]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a create-secondary-zone -d 'Create a new secondary zone'

# change-secondary-zone-primary ZONE PRIMARY [PRIMARY…]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a change-secondary-zone-primary -d 'Change the primaries for a secondary zone'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument change-secondary-zone-primary 0' \
	-ra '(__fish_pdnsutil_zones)'

# check-all-zones
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a check-all-zones -d 'Check all zones for correctness'

# check-zone ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a check-zone -d 'Check a zone for correctness'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument check-zone 0' \
	-ra '(__fish_pdnsutil_zones)'

# clear-zone ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a clear-zone -d 'Remove all records from a zone'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument clear-zone 0' \
	-ra '(__fish_pdnsutil_zones)'

# delete-rrset ZONE NAME TYPE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a delete-rrset -d 'Delete a named RRSET from a zone'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument delete-rrset 0' \
	-ra '(__fish_pdnsutil_zones)'
# TODO: list rrsets in the selected zone?

# delete-zone ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a delete-zone -d 'Delete a zone'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument delete-zone 0' \
	-ra '(__fish_pdnsutil_zones)'

# edit-zone ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a edit-zone -d 'Edit a zone in BIND format in your EDITOR'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument edit-zone 0' \
	-ra '(__fish_pdnsutil_zones)'

# get-meta ZONE [ATTRIBUTE…]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a get-meta # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument get-meta 0' \
	-ra '(__fish_pdnsutil_zones)'

# hash-password [WORK-FACTOR]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a hash-password # TODO: description

# hash-zone-record ZONE RNAME
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a hash-zone-record # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument hash-zone-record 0' \
	-ra '(__fish_pdnsutil_zones)'
# TODO: RNAME

# increase-serial ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a increase-serial -d 'Increase the SOA serial for a zone by 1'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument increase-serial 0' \
	-ra '(__fish_pdnsutil_zones)'

# list-keys [ZONE]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a list-keys -d 'List DNSSEC keys'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument list-keys 0' \
	-a '(__fish_pdnsutil_zones)'

# list-all-zones
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a list-all-zones -d 'List all active zone names'
complete -c pdnsutil -n '__fish_seen_subcommand_from list-all-zones' \
	-s v -l verbose -d 'Even list the inactive zone names'

# list-member-zones CATALOG
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a list-member-zones # TODO: description
# TODO: list catalogs?

# list-zone ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a list-zone -d 'Show all records in a zone'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument list-zone 0' \
	-ra '(__fish_pdnsutil_zones)'

# load-zone ZONE FILE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a load-zone -d 'Create or overwrite a zone from a file'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument list-zone 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument list-zone 1' \
	-rF

# rectify-zone ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a recrify-zone # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument rectify-zone 0' \
	-ra '(__fish_pdnsutil_zones)'

# rectify-all-zones
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a recrify-all-zones # TODO: description

# replace-rrset ZONE NAME TYPE [TTL] CONTENT [CONTENT…]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a replace-rrset # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument replace-rrset 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument replace-rrset 1' \
	-r # TODO: existing RRs?
# TODO: types for the rest?

# secure-zone ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a secure-zone # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument secure-zone 0' \
	-ra '(__fish_pdnsutil_zones)'

# secure-all-zones [increase-serial]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a secure-all-zones # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument secure-zone 0' \
	-a increase-serial

# set-kind ZONE KIND
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a set-kind # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument set-kind 0' \
	-ra '(__fish_pdnsutil_zones)'
complete -c pdnsutil -n '__fish_pdnsutil_on_argument set-kind 1' \
	-ra 'primary secondary native producer consumer'

# set-options-json ZONE JSON
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a set-options-json # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument set-options-json 0' \
	-ra '(__fish_pdnsutil_zones)'
# TODO: JSON?

# set-option ZONE [producer*|*consumer] [coo*|*unique*|*group] VALUE [VALUE…]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a set-option # TODO: description
# TODO: I'm honestly not sure how this one works

# set-catalog ZONE CATALOG
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a set-catalog # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument set-catalog 0' \
	-ra '(__fish_pdnsutil_zones)'
# TODO: catalog?

# set-account ZONE ACCOUNT
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a set-account # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument set-account 0' \
	-ra '(__fish_pdnsutil_zones)'
# TODO: account?

# add-meta ZONE ATTRIBUTE [VALUE…]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a add-meta # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument add-meta 0' \
	-ra '(__fish_pdnsutil_zones)'
# TODO: attributes?

# set-meta ZONE ATTRIBUTE [VALUE…]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a set-meta # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument set-meta 0' \
	-ra '(__fish_pdnsutil_zones)'
# TODO: attributes?

# set-presigned ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a set-presigned # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument set-presigned 0' \
	-ra '(__fish_pdnsutil_zones)'

# show-zone ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a show-zone # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument show-zone 0' \
	-ra '(__fish_pdnsutil_zones)'

# test-schema ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a test-schema # TODO: description
# ZONE is to be created here

# unset-presigned ZONE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a unset-presigned # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument unset-presigned 0' \
	-ra '(__fish_pdnsutil_zones)'

# raw-lua-from-content TYPE CONTENT
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a raw-lua-from-content # TODO: description
# TODO: rest

# zonemd-verify-file ZONE FILE
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a zonemd-verify-file # TODO: description
# TODO: rest

# = Debugging Tools
# backend-cmd BACKEND CMD [CMD…]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a backend-cmd # TODO: description
# TODO: rest

# bench-db [FILE]
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a bench-db # TODO: description
complete -c pdnsutil -n '__fish_pdnsutil_on_argument bench-db 0' \
	-rF

# = Other Tools
# b2b-migrate OLD NEW
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a b2b-migrate # TODO: description

# ipencrypt IP-ADDRESS password
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a ipencrypt # TODO: description

# ipdecrypt IP-ADDRESS password
complete -c pdnsutil -n "not __fish_seen_subcommand_from $commands" \
	-a ipdecrypt # TODO: description
